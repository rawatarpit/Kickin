import 'package:flutter/material.dart';
import '../../theme/kickin_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const UserAvatar({super.key, this.imageUrl, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: KickinColors.border,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child:
          imageUrl == null
              ? Icon(
                Icons.person,
                size: size * 0.6,
                color: KickinColors.textMuted,
              )
              : null,
    );
  }
}
