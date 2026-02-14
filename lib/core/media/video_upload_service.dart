import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoUploadService {
  static const _cloudName = 'YOUR_CLOUD_NAME';
  static const _uploadPreset = 'YOUR_UNSIGNED_PRESET';

  static Future<Map<String, String>> uploadVideo(File file) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$_cloudName/video/upload',
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = _uploadPreset
          ..fields['folder'] = 'reels'
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('Video upload failed');
    }

    final json = jsonDecode(body);

    return {
      'videoUrl': json['secure_url'],
      'thumbnailUrl': json['secure_url'].replaceAll('.mp4', '.jpg'),
    };
  }
}
