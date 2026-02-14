import 'package:flutter/material.dart';
import '../../../core/theme/kickin_colors.dart';

class MediaMessagePreview extends StatelessWidget {
  const MediaMessagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: KickinColors.border,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.image, size: 48),
    );
  }
}
