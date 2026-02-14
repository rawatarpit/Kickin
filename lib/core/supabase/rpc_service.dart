import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

class RpcService {
  static final SupabaseClient _client = SupabaseClientProvider.client;

  // -----------------------------------------------------
  // USER INITIALIZATION
  // -----------------------------------------------------

  static Future<void> ensureUserExists({required String firebaseUid}) async {
    await _client.rpc(
      'ensure_user_exists',
      params: {'p_firebase_uid': firebaseUid},
    );
  }

  static Future<void> registerDevice({
    required String firebaseUid,
    required String? fcmToken,
    required String deviceId,
  }) async {
    await _client.rpc(
      'register_device',
      params: {
        'p_firebase_uid': firebaseUid,
        'p_fcm_token': fcmToken,
        'p_device_id': deviceId,
      },
    );
  }

  // -----------------------------------------------------
  // SECURE MATCH RESULT
  // -----------------------------------------------------

  static Future<void> submitMatchResult({
    required String matchId,
    required int team1Score,
    required int team2Score,
  }) async {
    await _client.rpc(
      'submit_match_result_secure',
      params: {
        'p_match_id': matchId,
        'p_team1_score': team1Score,
        'p_team2_score': team2Score,
      },
    );
  }

  // -----------------------------------------------------
  // SECURE MATCH EVENT INSERT
  // -----------------------------------------------------

  static Future<void> insertMatchEvent({
    required String matchId,
    required String teamId,
    required String playerId,
    String? assistPlayerId,
    required String eventType,
    required int minute,
  }) async {
    await _client.rpc(
      'insert_match_event_secure',
      params: {
        'p_match_id': matchId,
        'p_team_id': teamId,
        'p_player_id': playerId,
        'p_assist_player_id': assistPlayerId,
        'p_event_type': eventType,
        'p_minute': minute,
      },
    );
  }
}
