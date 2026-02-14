import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationActionService {
  static final _client = Supabase.instance.client;

  static Future<void> markRead(String id) async {
    await _client
        .from('notifications')
        .update({
          'is_read': true,
          'viewed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);
  }

  static Future<void> acceptInvite({required String notificationId}) async {
    // TODO: Add business logic here
    // Example:
    // - Insert into connections
    // - Insert into tournament_members
    // - etc.

    await markRead(notificationId);
  }

  static Future<void> rejectInvite({required String notificationId}) async {
    await markRead(notificationId);
  }
}
