import 'package:flutter/material.dart';

import '../../../../../core/theme/kickin_spacing.dart';
import '../../../../../core/theme/kickin_colors.dart';
import '../../../../../core/theme/kickin_typography.dart';

class StoryStrip extends StatelessWidget {
  const StoryStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: KickinSpacing.lg,
          vertical: KickinSpacing.sm,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(width: KickinSpacing.md),
        itemBuilder: (_, index) {
          return Column(
            children: const [
              _StoryAvatar(),
              SizedBox(height: 6),
              Text('User', style: KickinTypography.caption),
            ],
          );
        },
      ),
    );
  }
}

class _StoryAvatar extends StatelessWidget {
  const _StoryAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [KickinColors.primary, KickinColors.primaryMuted],
        ),
      ),
      child: const CircleAvatar(
        radius: 26,
        backgroundColor: KickinColors.surface,
      ),
    );
  }
}
