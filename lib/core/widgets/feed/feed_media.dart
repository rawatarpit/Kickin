import 'package:flutter/material.dart';

import '../../theme/kickin_colors.dart';

class FeedMedia extends StatelessWidget {
  final List<String> mediaUrls;
  final bool isVideo;
  final double? aspectRatio;
  final VoidCallback? onOpenReel;

  const FeedMedia({
    super.key,
    required this.mediaUrls,
    required this.isVideo,
    this.aspectRatio,
    this.onOpenReel,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = aspectRatio ?? 1;

    return GestureDetector(
      onTap: isVideo ? onOpenReel : null,
      child: AspectRatio(
        aspectRatio: ratio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              mediaUrls.first,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            if (isVideo)
              const Icon(
                Icons.play_circle_outline,
                size: 56,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
