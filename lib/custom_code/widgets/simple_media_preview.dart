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

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';

class SimpleMediaPreview extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;

  const SimpleMediaPreview({
    Key? key,
    required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<SimpleMediaPreview> createState() => _SimpleMediaPreviewState();
}

class _SimpleMediaPreviewState extends State<SimpleMediaPreview> {
  VideoPlayerController? _videoController;
  bool _isVideo = false;
  bool _isMuted = true;
  Uint8List? _videoBytes; // For data:video base64
  Uint8List? _imageBytes; // For data:image base64

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  @override
  void didUpdateWidget(SimpleMediaPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _disposeVideo();
      _initializeMedia();
    }
  }

  @override
  void dispose() {
    _disposeVideo();
    super.dispose();
  }

  void _disposeVideo() {
    _videoController?.pause();
    _videoController?.dispose();
    _videoController = null;
  }

  void _initializeMedia() async {
    final url = widget.url;

    // Check for data: URL
    if (url.startsWith('data:')) {
      final commaIndex = url.indexOf(',');
      if (commaIndex == -1) {
        // Invalid data URL
        _setImage(null);
        return;
      }

      final metadata =
          url.substring(5, commaIndex); // after 'data:' before comma
      final base64Data = url.substring(commaIndex + 1);
      final mimeType = metadata.split(';').first;

      final bytes = base64Decode(base64Data);

      if (mimeType.startsWith('video/')) {
        // Video from base64: we can't pass bytes directly to video_player, need file
        // On web, can create blob url, but Flutter doesn't support that.
        // So on web, fallback to empty or error
        if (kIsWeb) {
          // Can't play base64 video on web with video_player, just show message
          setState(() {
            _isVideo = false;
            _imageBytes = null;
          });
          return;
        }
        // On mobile, write to temp file, then play
        // But for simplicity, we won't implement file writing here as user asked minimal.
        // So fallback to no video
        setState(() {
          _isVideo = false;
          _imageBytes = null;
        });
        return;
      } else if (mimeType.startsWith('image/')) {
        setState(() {
          _isVideo = false;
          _imageBytes = bytes;
        });
      } else {
        // Unsupported mime
        setState(() {
          _isVideo = false;
          _imageBytes = null;
        });
      }
      return;
    }

    // For normal URLs - check extension for video or image
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.endsWith('.mp4') ||
        lowerUrl.endsWith('.mov') ||
        lowerUrl.endsWith('.mpeg') ||
        lowerUrl.endsWith('.webm')) {
      // Video URL
      _videoController = VideoPlayerController.network(url);
      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.setVolume(_isMuted ? 0 : 1);
      _videoController!.play();
      setState(() {
        _isVideo = true;
        _imageBytes = null;
      });
    } else if (lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png') ||
        lowerUrl.endsWith('.gif') ||
        lowerUrl.endsWith('.bmp') ||
        lowerUrl.endsWith('.webp')) {
      // Image URL
      setState(() {
        _isVideo = false;
        _imageBytes = null; // no base64 image, show network image
      });
    } else {
      // Unknown extension - fallback to image network
      setState(() {
        _isVideo = false;
        _imageBytes = null;
      });
    }
  }

  void _toggleMute() {
    if (_videoController == null) return;
    setState(() {
      _isMuted = !_isMuted;
      _videoController!.setVolume(_isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideo &&
        _videoController != null &&
        _videoController!.value.isInitialized) {
      final videoPlayer = AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      );

      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            if (kIsWeb)
              videoPlayer
            else
              // On mobile, wrap with GestureDetector for mute toggle
              GestureDetector(
                onTap: _toggleMute,
                child: videoPlayer,
              ),
            if (kIsWeb)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: _toggleMute,
                ),
              ),
          ],
        ),
      );
    }

    if (_imageBytes != null) {
      // Show decoded base64 image
      return Image.memory(
        _imageBytes!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      );
    }

    // Show network image fallback
    return Image.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error, size: 48),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
