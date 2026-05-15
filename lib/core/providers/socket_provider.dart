import 'package:flutter/foundation.dart';         
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  
import 'package:navithera_client/core/providers/user_status_provider.dart';
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

final socketServiceProvider = StateProvider<SocketService>((ref) {
  return SocketService(ref);
});

class SocketService {
  final Ref ref;
  io.Socket? socket;
  bool _isConnected = false;

  // Secure storage instance
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
  );

  SocketService(this.ref);

  Future<void> connect() async {
    // Secure token read
    final accessToken = await _secureStorage.read(key: 'access_token');

    // Never log the token
    if (kDebugMode) debugPrint('Socket connecting...');

    if (accessToken == null) {
      if (kDebugMode) debugPrint('No access token found');
      return;
    }

    disconnect();

    const basePath = 'dev';

    socket = io.io(
      'https://app.navithera.com',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/$basePath/socket.io')
          .disableAutoConnect()
          .setAuth({'token': accessToken})
          .build(),
    );

    socket!.onConnect((_) {
      if (kDebugMode) debugPrint('Socket connected');
      _isConnected = true;
    });

    socket!.onDisconnect((_) {
      if (kDebugMode) debugPrint('Socket disconnected');
      _isConnected = false;
    });

    socket!.onConnectError((err) {
      if (kDebugMode) debugPrint('Socket connection error');
      _isConnected = false;
    });

    socket!.onError((err) {
      if (kDebugMode) debugPrint('Socket error');
      _isConnected = false;
    });

    socket!.on("userProfileUpdated", (data) {
      ref.read(chatProvider.notifier).getChatThreads(silent: true);
    });

    socket!.on('userStatus', (data) {
      try {
        final statusData = Map<String, dynamic>.from(data);
        final userId = statusData['userId'] as String;
        final isOnline = statusData['isOnline'] as bool;

        ref.read(userStatusProvider.notifier).updateStatus(userId, isOnline);
      } catch (e) {
        if (kDebugMode) debugPrint('Error parsing user status: $e');
      }
    });

    socket!.connect();
  }

  void disconnect() {
    socket?.clearListeners();
    socket?.dispose();
    socket = null;
    _isConnected = false;
  }

  bool get isConnected => _isConnected;

  void listenForUserStatus(String userId, Function(dynamic) callback) {
    socket?.on('userStatus', (data) {
      final statusData = data as Map<String, dynamic>;
      if (statusData['userId'] == userId) {
        callback(statusData);
      }
    });
  }

  void stopListeningForUserStatus() {
    socket?.off('userStatus');
  }
}