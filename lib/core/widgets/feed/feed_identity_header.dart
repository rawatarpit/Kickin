import 'package:flutter/material.dart';

import '../../content/content_identity.dart';
import '../../theme/kickin_spacing.dart';
import '../../theme/kickin_typography.dart';
import '../../theme/kickin_colors.dart';

class FeedIdentityHeader extends StatelessWidget {
  final ContentIdentity identity;

  const FeedIdentityHeader({super.key, required this.identity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage:
              identity.avatarUrl != null
                  ? NetworkImage(identity.avatarUrl!)
                  : null,
          backgroundColor: KickinColors.surface,
          child:
              identity.avatarUrl == null
                  ? const Icon(Icons.person, size: 18)
                  : null,
        ),
        const SizedBox(width: KickinSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(identity.displayName, style: KickinTypography.body),
              if (identity.username != null)
                Text('@${identity.username}', style: KickinTypography.caption),
            ],
          ),
        ),
        if (identity.isVerified)
          const Icon(Icons.verified, size: 16, color: KickinColors.primary),
      ],
    );
  }
}
