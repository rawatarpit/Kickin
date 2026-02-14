import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isActive;

  const ReelPlayer({
    super.key,
    required this.controller,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isActive && !controller.value.isPlaying) {
      controller.play();
    } else if (!isActive && controller.value.isPlaying) {
      controller.pause();
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}
