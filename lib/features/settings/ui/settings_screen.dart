import 'package:flutter/material.dart';
import 'settings_row.dart';
import 'blocked_users_screen.dart';
import 'reported_users_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Privacy'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _sectionHeader('Account'),
          SettingsRow(title: 'Edit Profile', onTap: () {}),
          SettingsRow(title: 'Change Phone Number', onTap: () {}),

          _divider(),

          _sectionHeader('Privacy & Safety'),
          SettingsRow(
            title: 'Blocked Users',
            subtitle: 'People you’ve blocked',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BlockedUsersScreen()),
              );
            },
          ),
          SettingsRow(
            title: 'Reported Users',
            subtitle: 'Reports you’ve submitted',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportedUsersScreen()),
              );
            },
          ),

          _divider(),

          _sectionHeader('Security'),
          SettingsRow(title: 'Logout', onTap: () {}),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.white54),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 32),
    );
  }
}
