import '../auth/user_role.dart';
import 'app_routes.dart';

enum BottomNavItem { home, reels, jobs, tournaments, profile }

extension BottomNavItemX on BottomNavItem {
  String get route {
    switch (this) {
      case BottomNavItem.home:
        return AppRoutes.home;
      case BottomNavItem.reels:
        return AppRoutes.reels;
      case BottomNavItem.jobs:
        return AppRoutes.jobs;
      case BottomNavItem.tournaments:
        return AppRoutes.tournaments;
      case BottomNavItem.profile:
        return AppRoutes.profile;
    }
  }

  /// 🔒 ROLE VISIBILITY RULES
  bool isVisibleFor(UserRole role) {
    switch (this) {
      case BottomNavItem.jobs:
        return role == UserRole.coach ||
            role == UserRole.agent ||
            role == UserRole.agency ||
            role == UserRole.club ||
            role == UserRole.academy;

      default:
        return true;
    }
  }
}
