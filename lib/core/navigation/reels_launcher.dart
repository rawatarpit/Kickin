import 'package:flutter/material.dart';

import '../models/feed_item_ui_model.dart';
import '../../features/reels/ui/reels_screen.dart';
import '../auth/user_role.dart';

class ReelsLauncher {
  static void open({
    required BuildContext context,
    required List<FeedItemUIModel> reels,
    required int initialIndex,
    required UserRole userRole,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ReelsScreen(
              reels: reels,
              initialIndex: initialIndex,
              userRole: userRole,
            ),
      ),
    );
  }
}
