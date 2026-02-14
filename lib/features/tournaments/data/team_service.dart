import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/models/team_model.dart';

class TeamService {
  TeamService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // CREATE (SECURE RPC)
  // =========================================================

  Future<void> createTeamSecure({
    required String tournamentId,
    required String name,
  }) async {
    await _safeRpcVoid(
      'create_team_secure',
      params: {'p_tournament_id': tournamentId, 'p_team_name': name},
    );
  }

  // =========================================================
  // READ
  // =========================================================

  Future<List<TeamModel>> fetchTeams(String tournamentId) async {
    try {
      final response = await _client
          .from('ktm_teams')
          .select()
          .eq('tournament_id', tournamentId);

      final list = (response as List<dynamic>);
      return list.map((e) => TeamModel.fromMap(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // INTERNAL HELPERS
  // =========================================================

  Future<void> _safeRpcVoid(
    String functionName, {
    Map<String, dynamic>? params,
  }) async {
    try {
      await _client.rpc(functionName, params: params ?? {});
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Team operation failed';
  }
}
