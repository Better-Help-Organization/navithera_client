import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ✅
import 'package:navithera_client/core/constants/base_url.dart';

class FileUploadService {
  // Use secure storage
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
  );

  static Future<String> uploadProfilePicture(File imageFile) async {
    // Read token securely
    final accessToken = await _secureStorage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    final uri = Uri.parse('${base_url_dev}/client/me/upload/profile');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $accessToken';

    String extension = imageFile.path.split('.').last.toLowerCase();
    String mimeType;

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
        // Only log in debug mode
        if (kDebugMode) {
          debugPrint('Profile picture uploaded successfully');
        }
        return responseData['data']['filename'];
      } else {
        throw Exception(
          'Failed to upload profile picture: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Only log in debug mode
      if (kDebugMode) {
        debugPrint('Error uploading profile picture: $e');
      }
      throw Exception('Error uploading profile picture: $e');
    }
  }
}