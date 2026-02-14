import 'package:flutter/material.dart';

import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_colors.dart';
import '../../../../core/theme/kickin_typography.dart';

class SuggestedUsersRow extends StatelessWidget {
  const SuggestedUsersRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary UI-only state (backend plugs later)
    final users = List.generate(6, (i) => i);

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: KickinSpacing.lg),
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (_, __) => const SizedBox(width: KickinSpacing.md),
        itemBuilder: (_, i) {
          return const _SuggestedUserCard();
        },
      ),
    );
  }
}

class _SuggestedUserCard extends StatelessWidget {
  const _SuggestedUserCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(KickinSpacing.md),
      decoration: BoxDecoration(
        color: KickinColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KickinColors.border),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: KickinColors.background,
          ),
          const SizedBox(height: 8),
          const Text(
            'Username',
            style: KickinTypography.body,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text('2 mutuals', style: KickinTypography.caption),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Follow'),
            ),
          ),
        ],
      ),
    );
  }
}
