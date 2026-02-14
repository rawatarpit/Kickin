import '../../../core/supabase/supabase_client.dart';

class NearbyUsersRemote {
  static Future<List<Map<String, dynamic>>> fetch({
    required String currentUserId,
    required String role,
    int radiusKm = 50,
    int limit = 50,
  }) async {
    final res = await SupabaseClientProvider.client.rpc(
      'nearby_users',
      params: {
        'current_user_id': currentUserId,
        'user_type': role,
        'radius_km': radiusKm,
        'result_limit': limit,
      },
    );

    return List<Map<String, dynamic>>.from(res);
  }
}
