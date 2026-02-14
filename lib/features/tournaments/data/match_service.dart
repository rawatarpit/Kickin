import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/match_model.dart';

class MatchService {
  MatchService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // READ
  // =========================================================

  Future<List<MatchModel>> fetchMatches(String tournamentId) async {
    try {
      final response = await _client
          .from('ktm_matches')
          .select()
          .eq('tournament_id', tournamentId)
          .order('match_date', ascending: true);

      final list = (response as List<dynamic>);
      return list.map((e) => MatchModel.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<Map<String, dynamic>> getScorecardDetails(String matchId) async {
    return _safeRpcSingle(
      'get_scorecard_details',
      params: {'p_match_id': matchId},
    );
  }

  Future<List<Map<String, dynamic>>> getTeamPlayerStats({
    required String matchId,
    required String teamId,
  }) async {
    return _safeRpcList(
      'get_team_player_stats',
      params: {'p_match_id': matchId, 'p_team_id': teamId},
    );
  }

  // =========================================================
  // RESULT
  // =========================================================

  Future<void> submitMatchResult({
    required String matchId,
    required int team1Score,
    required int team2Score,
  }) async {
    await _safeRpcVoid(
      'submit_match_result_secure',
      params: {
        'p_match_id': matchId,
        'p_team1_score': team1Score,
        'p_team2_score': team2Score,
      },
    );
  }

  // =========================================================
  // ENGINE
  // =========================================================

  Future<void> assignTeamsToGroups(String tournamentId) async {
    await _safeRpcVoid(
      'ktm_assign_teams_to_groups',
      params: {'p_tournament_id': tournamentId},
    );
  }

  Future<void> generateGroupFixtures(String tournamentId) async {
    await _safeRpcVoid(
      'ktm_generate_group_fixtures_homeaway',
      params: {'p_tournament_id': tournamentId},
    );
  }

  Future<void> generateKnockoutInitial(String tournamentId) async {
    await _safeRpcVoid(
      'ktm_generate_knockout_initial_fixtures',
      params: {'p_tournament_id': tournamentId},
    );
  }

  Future<void> advanceKnockoutRound({
    required String tournamentId,
    required String round,
  }) async {
    await _safeRpcVoid(
      'ktm_advance_knockout_round',
      params: {'p_tournament_id': tournamentId, 'p_round': round},
    );
  }

  // =========================================================
  // INTERNAL HELPERS
  // =========================================================

  Future<List<Map<String, dynamic>>> _safeRpcList(
    String fn, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(fn, params: params ?? {});
      final list = (response as List<dynamic>? ?? []);
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<Map<String, dynamic>> _safeRpcSingle(
    String fn, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _client.rpc(fn, params: params ?? {});
      return Map<String, dynamic>.from(response as Map);
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  Future<void> _safeRpcVoid(String fn, {Map<String, dynamic>? params}) async {
    try {
      await _client.rpc(fn, params: params ?? {});
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Match engine operation failed';
  }
}
