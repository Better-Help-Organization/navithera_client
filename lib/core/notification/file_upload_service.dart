import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileUploadService {
  static Future<String> uploadProfilePicture(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    final uri = Uri.parse('${base_url_dev}/client/me/upload/profile');
    final request = http.MultipartRequest('POST', uri);

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Get the file extension to determine MIME type
    String extension = imageFile.path.split('.').last.toLowerCase();
    String mimeType;

    // Determine MIME type based on extension
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      default:
        mimeType = 'application/octet-stream';
    }

    // Attach the file with proper MIME type
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        print('Profile picture uploaded successfully');
        return responseData['data']['filename'];
      } else {
        throw Exception(
          'Failed to upload profile picture: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
      throw Exception('Error uploading profile picture: $e');
    }
  }
}
