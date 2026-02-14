import 'package:flutter/material.dart';

import '../navigation/bottom_nav_shell.dart';
import '../auth/user_role.dart';
import 'app_app_bar.dart';
import 'app_bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final BottomNavItem currentTab;
  final UserRole userRole;

  const AppScaffold({
    super.key,
    required this.body,
    required this.currentTab,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(),
      body: SafeArea(child: body),
      bottomNavigationBar: AppBottomNav(
        currentTab: currentTab,
        userRole: userRole,
      ),
    );
  }
}
