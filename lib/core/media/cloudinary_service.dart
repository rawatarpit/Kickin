import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const _cloudName = 'YOUR_CLOUD_NAME';
  static const _uploadPreset = 'YOUR_UNSIGNED_PRESET';

  /// Generic upload (used internally)
  static Future<String> uploadImage(File file) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = _uploadPreset
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('Image upload failed');
    }

    final json = jsonDecode(body);
    return json['secure_url'];
  }

  /// ✅ Explicit profile image API (what your UI expects)
  static Future<String> uploadProfileImage(File file) {
    return uploadImage(file);
  }
}
