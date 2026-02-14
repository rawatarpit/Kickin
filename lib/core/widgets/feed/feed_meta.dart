import 'package:flutter/material.dart';

import '../../models/feed_item_ui_model.dart';
import '../../theme/kickin_typography.dart';
import '../../theme/kickin_colors.dart';

class FeedMeta extends StatelessWidget {
  final FeedItemUIModel item;

  const FeedMeta({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_timeAgo(item.createdAt), style: KickinTypography.caption),
        if (item.isSponsored) ...[
          const SizedBox(width: 8),
          const Text('Sponsored', style: KickinTypography.caption),
        ],
      ],
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}
