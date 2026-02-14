import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../supabase/identity_service.dart';
import 'user_role.dart';

final currentUserRoleProvider = FutureProvider<UserRole>((ref) async {
  return IdentityService.getCurrentUserRole();
});
