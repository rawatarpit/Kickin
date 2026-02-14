import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardService {
  LeaderboardService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // TOP SCORERS
  // =========================================================

  Future<List<Map<String, dynamic>>> getTopScorers(String tournamentId) async {
    return _safeViewList(
      table: 'ktm_top_scorers',
      filterColumn: 'tournament_id',
      filterValue: tournamentId,
      orderColumn: 'goals',
    );
  }

  // =========================================================
  // TOP ASSISTS
  // =========================================================

  Future<List<Map<String, dynamic>>> getTopAssists(String tournamentId) async {
    return _safeViewList(
      table: 'ktm_top_assists',
      filterColumn: 'tournament_id',
      filterValue: tournamentId,
      orderColumn: 'assists',
    );
  }

  // =========================================================
  // PLAYER SUMMARY
  // =========================================================

  Future<Map<String, dynamic>> getPlayerTournamentSummary({
    required String tournamentId,
    required String playerId,
  }) async {
    try {
      final response =
          await _client
              .from('ktm_player_tournament_summary')
              .select()
              .eq('tournament_id', tournamentId)
              .eq('player_id', playerId)
              .single();

      return Map<String, dynamic>.from(response as Map);
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // TEAM SUMMARY
  // =========================================================

  Future<Map<String, dynamic>> getTeamTournamentSummary({
    required String tournamentId,
    required String teamId,
  }) async {
    try {
      final response =
          await _client
              .from('ktm_team_tournament_summary')
              .select()
              .eq('tournament_id', tournamentId)
              .eq('team_id', teamId)
              .single();

      return Map<String, dynamic>.from(response as Map);
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // INTERNAL VIEW HELPER
  // =========================================================

  Future<List<Map<String, dynamic>>> _safeViewList({
    required String table,
    required String filterColumn,
    required String filterValue,
    required String orderColumn,
  }) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq(filterColumn, filterValue)
          .order(orderColumn, ascending: false);

      final list = (response as List<dynamic>);
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Leaderboard fetch failed';
  }
}
