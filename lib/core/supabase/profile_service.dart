import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sb_profile.dart';
import 'supabase_client.dart';

class ProfileService {
  static final SupabaseClient _client = SupabaseClientProvider.client;

  /// Create profile (during signup)
  static Future<void> createProfile(SbProfile profile) async {
    try {
      await _client.from('profiles').insert(profile.toJson());
    } catch (e) {
      throw Exception('createProfile failed: $e');
    }
  }

  /// Update profile
  static Future<void> updateProfile({
    required String userId,
    required String name,
    String? profileImageUrl,
  }) async {
    try {
      await _client
          .from('profiles')
          .update({
            'name': name,
            if (profileImageUrl != null) 'profile_image': profileImageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('updateProfile failed: $e');
    }
  }

  /// Fetch full profile (used in bootstrap)
  static Future<SbProfile> fetchProfile(String uid) async {
    try {
      final response =
          await _client.from('profiles').select().eq('user_id', uid).single();

      return SbProfile.fromMap(response);
    } catch (e) {
      throw Exception('fetchProfile failed: $e');
    }
  }
}
