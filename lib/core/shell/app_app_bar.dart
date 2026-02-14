import 'package:flutter/material.dart';
import '../theme/kickin_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KickinColors.background,
      elevation: 0,
      centerTitle: false,
      title: const Text('Kickin'),
      actions: const [
        Icon(Icons.notifications_none),
        SizedBox(width: 12),
        Icon(Icons.chat_bubble_outline),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
