import 'package:flutter/material.dart';

import '../../models/feed_item_ui_model.dart';
import '../../theme/kickin_spacing.dart';
import '../../theme/kickin_colors.dart';
import 'feed_identity_header.dart';
import 'feed_media.dart';
import 'feed_actions.dart';
import 'feed_caption.dart';
import 'feed_meta.dart';

class FeedCard extends StatelessWidget {
  final FeedItemUIModel item;

  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onOpenReel;

  const FeedCard({
    super.key,
    required this.item,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onOpenReel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: KickinSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeedIdentityHeader(identity: item.identity),
          const SizedBox(height: KickinSpacing.sm),

          FeedCaption(item: item),

          if (item.mediaUrls.isNotEmpty) ...[
            const SizedBox(height: KickinSpacing.sm),
            FeedMedia(
              mediaUrls: item.mediaUrls,
              isVideo: item.isVideo,
              aspectRatio: item.aspectRatio,
              onOpenReel: item.isVideo ? onOpenReel : null,
            ),
          ],

          const SizedBox(height: KickinSpacing.sm),

          FeedActions(
            actions: item,
            contentType: item.contentType,
            onLike: onLike,
            onComment: onComment,
            onShare: onShare,
            onOpenReel: onOpenReel,
          ),

          const SizedBox(height: KickinSpacing.sm),

          FeedMeta(item: item),

          const Divider(height: KickinSpacing.lg, color: KickinColors.border),
        ],
      ),
    );
  }
}
