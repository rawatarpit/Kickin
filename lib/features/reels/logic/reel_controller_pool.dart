import 'package:video_player/video_player.dart';

class ReelControllerPool {
  final Map<int, VideoPlayerController> _cache = {};

  /// Get controller if already preloaded
  VideoPlayerController? operator [](int index) => _cache[index];

  /// Preload controller for index if not cached
  Future<VideoPlayerController> preload({
    required int index,
    required String url,
  }) async {
    if (_cache.containsKey(index)) {
      return _cache[index]!;
    }

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));

    await controller.initialize();
    controller.setLooping(true);

    _cache[index] = controller;
    return controller;
  }

  /// Start playback safely
  void play(int index) {
    final controller = _cache[index];
    if (controller != null &&
        controller.value.isInitialized &&
        !controller.value.isPlaying) {
      controller.play();
    }
  }

  /// Pause playback safely
  void pause(int index) {
    final controller = _cache[index];
    if (controller != null &&
        controller.value.isInitialized &&
        controller.value.isPlaying) {
      controller.pause();
    }
  }

  /// Dispose controllers outside active window (current ±1)
  void disposeOutsideWindow(int currentIndex) {
    final keys = _cache.keys.toList();

    for (final key in keys) {
      if ((key - currentIndex).abs() > 1) {
        _cache[key]?.dispose();
        _cache.remove(key);
      }
    }
  }

  /// Full cleanup
  void disposeAll() {
    for (final controller in _cache.values) {
      controller.dispose();
    }
    _cache.clear();
  }
}
