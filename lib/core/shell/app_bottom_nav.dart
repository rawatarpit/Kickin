import 'package:flutter/material.dart';

import '../navigation/bottom_nav_shell.dart';
import '../navigation/app_routes.dart';
import '../auth/user_role.dart';
import '../theme/kickin_colors.dart';

class AppBottomNav extends StatelessWidget {
  final BottomNavItem currentTab;
  final UserRole userRole;

  const AppBottomNav({
    super.key,
    required this.currentTab,
    required this.userRole,
  });

  void _onTap(BuildContext context, BottomNavItem item) {
    if (item == currentTab) return;
    Navigator.pushNamedAndRemoveUntil(context, item.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final items =
        BottomNavItem.values
            .where((item) => item.isVisibleFor(userRole))
            .toList();

    return BottomNavigationBar(
      currentIndex: items.indexOf(currentTab),
      onTap: (index) => _onTap(context, items[index]),
      backgroundColor: KickinColors.surface,
      selectedItemColor: KickinColors.primary,
      unselectedItemColor: KickinColors.textMuted,
      type: BottomNavigationBarType.fixed,
      items: items.map(_buildItem).toList(),
    );
  }

  BottomNavigationBarItem _buildItem(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        );
      case BottomNavItem.reels:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline),
          label: 'Reels',
        );
      case BottomNavItem.jobs:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Jobs',
        );
      case BottomNavItem.tournaments:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events_outlined),
          label: 'Tournaments',
        );
      case BottomNavItem.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        );
    }
  }
}
