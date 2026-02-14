import 'package:flutter/material.dart';

import '../../models/feed_item_ui_model.dart';
import '../../theme/kickin_typography.dart';

class FeedCaption extends StatelessWidget {
  final FeedItemUIModel item;

  const FeedCaption({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Caption support is optional – safe for ads / jobs later
    if (item is! FeedItemUIModel) return const SizedBox.shrink();

    return const SizedBox(); // Text plugs in later when caption is added to model
  }
}
