import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_colors.dart';
import '../../../core/supabase/profile_read_service.dart';
import '../../../core/supabase/connection_service.dart';
import '../../../core/widgets/buttons/primary_button.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({required this.userId, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _client = Supabase.instance.client;

  bool _loadingAction = false;

  bool get _isOwnProfile => _client.auth.currentUser?.id == widget.userId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<Map<String, dynamic>?>(
      future: ProfileReadService.fetch(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(body: Center(child: Text('Profile not found')));
        }

        final profile = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text(profile['name'] ?? 'Profile')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(KickinSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(profile, textTheme),
                const SizedBox(height: KickinSpacing.lg),
                _buildConnectionsStat(),
                const SizedBox(height: KickinSpacing.lg),
                if (!_isOwnProfile) _buildConnectionButton(),
                const SizedBox(height: KickinSpacing.xl),
                Text('About', style: textTheme.titleMedium),
                const SizedBox(height: KickinSpacing.sm),
                Text(
                  profile['email'] ?? 'No email provided',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Map<String, dynamic> profile, TextTheme textTheme) {
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
                  ? const Icon(
                    Icons.person,
                    size: 36,
                    color: KickinColors.textMuted,
                  )
                  : null,
        ),
        const SizedBox(width: KickinSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile['name'] ?? '', style: textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(profile['user_type'] ?? '', style: textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionsStat() {
    return StreamBuilder<int>(
      stream: ConnectionService.connectionsCount(widget.userId),
      builder: (_, snapshot) {
        final count = snapshot.data ?? 0;

        return _Stat(label: 'Connections', value: count);
      },
    );
  }

  Widget _buildConnectionButton() {
    return FutureBuilder<String>(
      future: ConnectionService.getStatus(widget.userId),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        final status = snapshot.data ?? 'empty';

        late String label;
        late Future<void> Function() action;

        switch (status) {
          case 'accepted':
            label = 'Connected';
            action = () => ConnectionService.remove(widget.userId);
            break;

          case 'sent':
            label = 'Requested';
            action = () => ConnectionService.remove(widget.userId);
            break;

          default:
            label = 'Connect';
            action = () => ConnectionService.sendRequest(widget.userId);
        }

        return PrimaryButton(
          label: label,
          loading: _loadingAction,
          onTap: () async {
            if (_loadingAction) return;

            setState(() => _loadingAction = true);

            try {
              await action();
            } catch (_) {
              // optionally show error snackbar
            }

            if (mounted) {
              setState(() => _loadingAction = false);
            }
          },
        );
      },
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final int value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text('$value', style: textTheme.titleMedium),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}
