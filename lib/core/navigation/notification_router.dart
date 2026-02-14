import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/notifications/notification_model.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/profile/ui/user_profile_screen.dart';
import '../../features/reels/ui/reels_screen.dart';

class NotificationRouter {
  static void handle(BuildContext context, AppNotification notification) {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;

    /// 👤 FOLLOW
    if (notification.type == NotificationType.follow) {
      // If someone followed YOU → open THEIR profile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserProfileScreen(userId: notification.fromUserId),
        ),
      );
      return;
    }

    /// ❤️ LIKE / 💬 COMMENT → open post
    if (notification.postId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReelsScreen(initialPostId: notification.postId!),
        ),
      );
    }
  }
}
