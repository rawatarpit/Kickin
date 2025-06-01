// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io' as io show File;
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:video_compress/video_compress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

/// Web-only import
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<List<String>> selectUploadFiles(
  String folderPath, // e.g., "users/12345"
  bool allowMultiple,
  bool isVideo,
) async {
  // Get environment variables from FFConfig
  final cloudName = "kickin";
  final apiKey = "626621789513738";
  final apiSecret = "4j_ex69aWZ55MQnoAPFxAx9yN_I";

  // Random ID generator
  String randomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random.secure();
    return List.generate(length, (_) => chars[rnd.nextInt(chars.length)])
        .join();
  }

  // Signature generator
  String generateSignature(Map<String, String> params, String secret) {
    final sortedKeys = params.keys.toList()..sort();
    final paramStr = sortedKeys.map((k) => '$k=${params[k]}').join('&');
    return sha1.convert(utf8.encode('$paramStr$secret')).toString();
  }

  // File selection
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: isVideo ? FileType.video : FileType.image,
    allowMultiple: allowMultiple,
    withData: kIsWeb,
  );

  if (result == null) return [];

  List<String> previewUrls = [];
  List<String> uploadedUrls = [];

  for (final pickedFile in result.files) {
    try {
      Uint8List uploadBytes;
      String uploadFileName = pickedFile.name;
      String? previewUrl;

      if (kIsWeb) {
        final fileBytes = pickedFile.bytes;
        if (fileBytes == null) continue;

        if (!isVideo) {
          final decoded = img.decodeImage(fileBytes);
          if (decoded == null) continue;
          final resized = img.copyResize(decoded, width: 1080);
          uploadBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 75));
        } else {
          uploadBytes = fileBytes;
        }

        // Preview for web
        final blob = html.Blob([uploadBytes]);
        previewUrl = html.Url.createObjectUrlFromBlob(blob);
      } else {
        final path = pickedFile.path;
        if (path == null) continue;
        io.File file = io.File(path);

        if (isVideo) {
          final info = await VideoCompress.compressVideo(
            path,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
          );
          if (info == null || info.file == null) continue;
          file = info.file!;
        } else {
          final dir = await getTemporaryDirectory();
          final targetPath =
              '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          final compressed = await FlutterImageCompress.compressAndGetFile(
            file.absolute.path,
            targetPath,
            quality: 75,
            minWidth: 1080,
          );
          if (compressed != null) file = compressed as io.File;
        }

        uploadBytes = await file.readAsBytes();

        if (!isVideo) {
          final base64 = base64Encode(uploadBytes);
          previewUrl = 'data:image/jpeg;base64,$base64';
        }
      }

      // Add preview
      if (previewUrl != null) {
        previewUrls.add(previewUrl);
        FFAppState().update(() {
          FFAppState().PreviewUrls = List.from(previewUrls);
        });
      }

      // Cloudinary Upload
      final timestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
      final publicId = '${folderPath.replaceAll('/', '_')}_${randomString(6)}';

      final signature = generateSignature({
        'folder': folderPath,
        'public_id': publicId,
        'timestamp': timestamp,
      }, apiSecret);

      final uri =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/auto/upload');
      final request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        uploadBytes,
        filename: uploadFileName,
      ));

      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['folder'] = folderPath;
      request.fields['public_id'] = publicId;

      final streamedResponse = await request.send();
      final responseStr = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode != 200) {
        print('Cloudinary upload failed: ${responseStr}');
        continue;
      }

      final uploadedUrl = jsonDecode(responseStr)['secure_url'];
      if (uploadedUrl != null) uploadedUrls.add(uploadedUrl);
    } catch (e) {
      print('Upload error: $e');
      continue;
    }
  }

  return uploadedUrls;
}
