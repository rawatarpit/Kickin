import 'package:supabase_flutter/supabase_flutter.dart';

class EventService {
  EventService(this._client);

  final SupabaseClient _client;

  // =========================================================
  // READ
  // =========================================================

  Future<List<Map<String, dynamic>>> fetchMatchEvents(String matchId) async {
    try {
      final response = await _client
          .from('ktm_match_events')
          .select()
          .eq('match_id', matchId)
          .order('minute', ascending: true);

      final list = (response as List<dynamic>);
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  // =========================================================
  // CREATE
  // =========================================================

  Future<void> insertEvent({
    required String matchId,
    required String playerId,
    required String eventType,
    required int minute,
    String? assistPlayerId,
    bool isOwnGoal = false,
    bool isPenalty = false,
  }) async {
    await _safeRpcVoid(
      'insert_match_event_secure',
      params: {
        'p_match_id': matchId,
        'p_player_id': playerId,
        'p_event_type': eventType,
        'p_minute': minute,
        'p_assist_player_id': assistPlayerId,
        'p_is_own_goal': isOwnGoal,
        'p_is_penalty': isPenalty,
      },
    );
  }

  // =========================================================
  // UPDATE
  // =========================================================

  Future<void> updateEventMinute({
    required String eventId,
    required int minute,
  }) async {
    await _safeRpcVoid(
      'edit_match_event_secure',
      params: {'p_event_id': eventId, 'p_minute': minute},
    );
  }

  // =========================================================
  // DELETE
  // =========================================================

  Future<void> deleteEvent(String eventId) async {
    await _safeRpcVoid(
      'delete_match_event_secure',
      params: {'p_event_id': eventId},
    );
  }

  // =========================================================
  // INTERNAL
  // =========================================================

  Future<void> _safeRpcVoid(String fn, {Map<String, dynamic>? params}) async {
    try {
      await _client.rpc(fn, params: params ?? {});
    } on PostgrestException catch (e) {
      throw Exception(_mapError(e));
    }
  }

  String _mapError(PostgrestException e) {
    if (e.code == 'P0001') return e.message;
    return 'Event operation failed';
  }
}
