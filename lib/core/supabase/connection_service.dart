import 'package:supabase_flutter/supabase_flutter.dart';

class ConnectionService {
  static final SupabaseClient _client = Supabase.instance.client;

  static String get _currentUserId => _client.auth.currentUser!.id;

  /// Send connection request
  static Future<void> sendRequest(String toUserId) async {
    await _client.from('connections').insert({
      'from_user_id': _currentUserId,
      'to_user_id': toUserId,
      'status': 'sent',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  /// Accept connection
  static Future<void> accept(String fromUserId) async {
    await _client
        .from('connections')
        .update({'status': 'accepted'})
        .eq('from_user_id', fromUserId)
        .eq('to_user_id', _currentUserId);
  }

  /// Remove connection
  static Future<void> remove(String userId) async {
    await _client
        .from('connections')
        .delete()
        .or(
          'and(from_user_id.eq.$_currentUserId,to_user_id.eq.$userId),'
          'and(from_user_id.eq.$userId,to_user_id.eq.$_currentUserId)',
        );
  }

  /// Get connection status
  static Future<String> getStatus(String otherUserId) async {
    final response =
        await _client
            .from('connections')
            .select('status, from_user_id, to_user_id')
            .or(
              'and(from_user_id.eq.$_currentUserId,to_user_id.eq.$otherUserId),'
              'and(from_user_id.eq.$otherUserId,to_user_id.eq.$_currentUserId)',
            )
            .maybeSingle();

    if (response == null) return 'empty';

    return response['status'] ?? 'empty';
  }

  /// Connection count (accepted only)
  static Stream<int> connectionsCount(String userId) {
    return _client
        .from('connections')
        .stream(primaryKey: ['id'])
        .map(
          (rows) =>
              rows
                  .where(
                    (row) =>
                        row['status'] == 'accepted' &&
                        (row['from_user_id'] == userId ||
                            row['to_user_id'] == userId),
                  )
                  .length,
        );
  }
}
