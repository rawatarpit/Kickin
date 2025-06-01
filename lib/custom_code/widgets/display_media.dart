// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const _kSupportedVideoMimes = {
  'video/mp4',
  'video/mpeg',
  'video/quicktime',
  'video/mov',
};

bool _isVideoPath(String url) {
  try {
    final uri = Uri.parse(url);
    final path = uri.path; // Get path without query parameters
    final mimeType = mime(path);
    return mimeType != null && _kSupportedVideoMimes.contains(mimeType);
  } catch (_) {
    return false;
  }
}

bool _isImagePath(String url) {
  try {
    final uri = Uri.parse(url);
    final path = uri.path;
    final mimeType = mime(path);
    return mimeType != null && mimeType.startsWith('image/');
  } catch (_) {
    return false;
  }
}

/// Unified DisplayMedia widget
class DisplayMedia extends StatefulWidget {
  const DisplayMedia({
    Key? key,
    this.width,
    this.height,
    required this.url,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String url;

  @override
  State<DisplayMedia> createState() => _DisplayMediaState();
}

class _DisplayMediaState extends State<DisplayMedia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(widget.url),
      width: widget.width,
      height: widget.height,
      child: _isVideoPath(widget.url)
          ? _DisplayVideoPlayer(
              url: widget.url,
              width: widget.width,
              height: widget.height,
            )
          : _isImagePath(widget.url)
              ? SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: kIsWeb
                      ? Image.network(
                          widget.url,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, size: 48),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          },
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.url,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, size: 48),
                          fit: BoxFit.contain,
                        ),
                )
              : _FileViewer(
                  path: widget.url,
                  width: widget.width,
                  height: widget.height,
                ),
    );
  }
}

class _DisplayVideoPlayer extends StatefulWidget {
  const _DisplayVideoPlayer({
    required this.url,
    this.width,
    this.height,
  });

  final String url;
  final double? width;
  final double? height;

  @override
  State<_DisplayVideoPlayer> createState() => _DisplayVideoPlayerState();
}

class _DisplayVideoPlayerState extends State<_DisplayVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isMuted = true;
  bool _isHolding = false;
  bool _isVisible = true;
  bool _isInitialized = false;
  Duration _pausedPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (kIsWeb) {
        // On web, directly use network controller
        _controller = VideoPlayerController.network(widget.url);
        await _controller.initialize();
      } else {
        // On mobile, try to cache video file then load
        final file = await DefaultCacheManager().getSingleFile(widget.url);
        _controller = VideoPlayerController.file(file);
        await _controller.initialize();
      }
      _controller.setLooping(true);
      _controller.setVolume(0);
      setState(() => _isInitialized = true);
      if (_isVisible) _controller.play();
    } catch (e) {
      debugPrint('Video load error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _pausedPosition = _controller.value.position;
        _controller.pause();
      } else {
        _controller.seekTo(_pausedPosition);
        _controller.play();
      }
    });
  }

  void _onHoldStart(LongPressStartDetails details) {
    setState(() {
      _isHolding = true;
      _controller.pause();
    });
  }

  void _onHoldEnd(LongPressEndDetails details) {
    setState(() {
      _isHolding = false;
      if (_isVisible) _controller.play();
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final visible = info.visibleFraction > 0.5;
    if (visible != _isVisible) {
      setState(() => _isVisible = visible);
      if (visible && !_controller.value.isPlaying && !_isHolding) {
        _controller.play();
      } else {
        _controller.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: VisibilityDetector(
        key: Key(widget.url),
        onVisibilityChanged: _onVisibilityChanged,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: _onHoldStart,
          onLongPressEnd: _onHoldEnd,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              if (kIsWeb) ...[
                Positioned(
                  right: 20,
                  top: (widget.height ?? 300) / 2 - 30,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _toggleMute,
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _FileViewer extends StatelessWidget {
  const _FileViewer({
    required this.path,
    this.width,
    this.height,
  });

  final String path;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final fileName = p.basename(path.replaceAll('%2F', '/').split('?').first);
    final fileExtension = path.split('.').last.split('?').first.toUpperCase();

    return SizedBox(
      width: width ?? 100,
      height: height ?? 120,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Icon(Icons.insert_drive_file,
                    size: constraint.biggest.height);
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fileExtension,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 6, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
