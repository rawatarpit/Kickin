import 'supabase_client.dart';
import '../auth/user_role.dart';

class IdentityService {
  // -----------------------------------------------------
  // PROFILE COMPLETION
  // -----------------------------------------------------

  static Future<bool> isProfileComplete(String firebaseUid) async {
    final result = await SupabaseClientProvider.client.rpc(
      'get_profile_status',
      params: {'p_firebase_uid': firebaseUid},
    );

    return result == true;
  }

  // -----------------------------------------------------
  // CURRENT USER ROLE
  // -----------------------------------------------------

  static Future<UserRole> getCurrentUserRole() async {
    final user = SupabaseClientProvider.client.auth.currentUser;

    if (user == null) {
      return UserRole.player;
    }

    final response =
        await SupabaseClientProvider.client
            .from('profiles')
            .select('role')
            .eq('firebase_uid', user.id)
            .maybeSingle();

    final roleString = response?['role'] as String?;

    switch (roleString) {
      case 'coach':
        return UserRole.coach;
      case 'agent':
        return UserRole.agent;
      case 'agency':
        return UserRole.agency;
      case 'club':
        return UserRole.club;
      case 'academy':
        return UserRole.academy;
      default:
        return UserRole.player;
    }
  }

  // -----------------------------------------------------
  // CURRENT SUPABASE USER ID
  // -----------------------------------------------------

  static String? getCurrentUserId() {
    return SupabaseClientProvider.client.auth.currentUser?.id;
  }

  static bool isLoggedIn() {
    return SupabaseClientProvider.client.auth.currentUser != null;
  }
}
