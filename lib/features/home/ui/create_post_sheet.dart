import 'package:flutter/material.dart';
import '../../../core/theme/kickin_colors.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';

class CreatePostSheet extends StatelessWidget {
  const CreatePostSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KickinSpacing.lg),
      decoration: const BoxDecoration(
        color: KickinColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create Post', style: KickinTypography.h2),
          const SizedBox(height: KickinSpacing.md),

          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'What’s happening?',
              hintStyle: KickinTypography.bodyMuted,
              border: InputBorder.none,
            ),
          ),

          const SizedBox(height: KickinSpacing.lg),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.image, color: KickinColors.textMuted),
              ElevatedButton(onPressed: () {}, child: const Text('Post')),
            ],
          ),
        ],
      ),
    );
  }
}
