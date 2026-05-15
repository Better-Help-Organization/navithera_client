import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: base_url_dev,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add auth interceptor
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false, 
        responseBody: false, 
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  return dio;
});

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock
    )
  );
  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip adding token for auth endpoints
    if (options.path.contains('/auth/login') ||
        options.path.contains('/auth/login/client') ||
        options.path.contains('/auth/register')) {
      return handler.next(options);
    }

    try {
      final token = await _secureStorage.read(key: 'access_token');

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // Handle error silently or log it
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh or logout
      // You can implement token refresh logic here
      await _secureStorage.deleteAll();
    }

    handler.next(err);
  }
}
