import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_colors.dart';
import '../../../core/supabase/profile_read_service.dart';
import '../../../core/supabase/connection_service.dart';
import '../../../core/widgets/buttons/primary_button.dart';

import 'profile_tabs.dart';
import 'profile_posts_tab.dart';
import 'profile_achievements_tab.dart';
import 'profile_experience_tab.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _client = Supabase.instance.client;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uid = _client.auth.currentUser!.id;

    return FutureBuilder<Map<String, dynamic>?>(
      future: ProfileReadService.fetch(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profile = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(KickinSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(profile: profile),
                const SizedBox(height: KickinSpacing.lg),
                _ConnectionsCount(userId: uid),
                const SizedBox(height: KickinSpacing.lg),
                PrimaryButton(
                  label: 'Edit profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfileScreen(profile: profile),
                      ),
                    );
                  },
                ),
                const SizedBox(height: KickinSpacing.xl),
                ProfileTabs(
                  index: _tabIndex,
                  onChange: (i) => setState(() => _tabIndex = i),
                ),
                const SizedBox(height: KickinSpacing.lg),
                _buildTab(uid),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(String uid) {
    switch (_tabIndex) {
      case 0:
        return ProfilePostsTab(userId: uid);
      case 1:
        return const ProfileAchievementsTab();
      case 2:
        return const ProfileExperienceTab();
      default:
        return const SizedBox();
    }
  }
}

class _Header extends StatelessWidget {
  final Map<String, dynamic> profile;

  const _Header({required this.profile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: KickinColors.surface,
          backgroundImage:
              profile['profile_image'] != null
                  ? NetworkImage(profile['profile_image'])
                  : null,
          child:
              profile['profile_image'] == null
                  ? const Icon(Icons.person)
                  : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile['name'] ?? '', style: textTheme.headlineMedium),
              Text(profile['user_type'] ?? '', style: textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConnectionsCount extends StatelessWidget {
  final String userId;

  const _ConnectionsCount({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: ConnectionService.connectionsCount(userId),
      builder: (_, snapshot) {
        final count = snapshot.data ?? 0;
        return Text(
          '$count Connections',
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}
