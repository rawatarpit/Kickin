import 'package:flutter/material.dart';
import '../../theme/kickin_colors.dart';
import '../../theme/kickin_motion.dart';
import '../../contracts/feed_actions_contract.dart';
import '../../content/content_type.dart';

class FeedActions extends StatelessWidget {
  final FeedActionsContract actions;
  final ContentType contentType;

  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onOpenReel;

  const FeedActions({
    super.key,
    required this.actions,
    required this.contentType,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onOpenReel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// ❤️ LIKE (only if supported)
        if (_supportsLike)
          _ActionIcon(
            icon: actions.isLiked ? Icons.favorite : Icons.favorite_border,
            color: actions.isLiked ? Colors.red : KickinColors.textMuted,
            onTap: onLike,
          ),

        if (_supportsLike) const SizedBox(width: 16),

        /// 💬 COMMENT
        if (_supportsComment)
          _ActionIcon(icon: Icons.chat_bubble_outline, onTap: onComment),

        if (_supportsComment) const SizedBox(width: 16),

        /// 📤 SHARE
        if (_supportsShare)
          _ActionIcon(icon: Icons.send_outlined, onTap: onShare),

        const Spacer(),

        /// 🎬 VIDEO → OPEN REELS
        if (contentType == ContentType.reel)
          _ActionIcon(icon: Icons.play_circle_outline, onTap: onOpenReel),
      ],
    );
  }

  bool get _supportsLike =>
      contentType == ContentType.post || contentType == ContentType.reel;

  bool get _supportsComment =>
      contentType == ContentType.post || contentType == ContentType.reel;

  bool get _supportsShare =>
      contentType != ContentType.tournament && contentType != ContentType.job;
}

// -----------------------------
// ICON WIDGET (PRIVATE)
// -----------------------------

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;

  const _ActionIcon({required this.icon, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedScale(
        scale: 1,
        duration: KickinMotion.fast,
        child: Icon(icon, size: 22, color: color ?? KickinColors.textMuted),
      ),
    );
  }
}
