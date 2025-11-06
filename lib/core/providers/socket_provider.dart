import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/providers/user_status_provider.dart';
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:shared_preferences/shared_preferences.dart';

final socketServiceProvider = StateProvider<SocketService>((ref) {
  return SocketService(ref);
});

class SocketService {
  final Ref ref;
  io.Socket? socket;
  bool _isConnected = false;

  SocketService(this.ref);

  Future<void> connect() async {
    // Get token from shared preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');

    print("accessToken from socket: ${accessToken}");

    if (accessToken == null) {
      print('No access token found');
      return;
    }

    // Disconnect if already connected
    disconnect();

    // Determine base path (similar to your web implementation)
    // For Flutter, you might need a different approach to get the environment
    // For now, let's assume 'dev' as in your web example
    const basePath = 'dev';

    // Create socket connection
    socket = io.io(
      'https://app.navigo.et',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/$basePath/socket.io')
          .disableAutoConnect()
          .setAuth({'token': accessToken})
          .build(),
    );

    socket!.onConnect((_) {
      print('✅ Connected with id: ${socket!.id}');
      _isConnected = true;
    });

    socket!.onDisconnect((_) {
      print('❌ Disconnected');
      _isConnected = false;
    });

    socket!.onConnectError((err) {
      print('⚠️ Connection error: $err');
      _isConnected = false;
    });

    socket!.onError((err) {
      print('⚠️ Socket error: $err');
      _isConnected = false;
    });

    socket!.on("userProfileUpdated", (data) {
      print('⚠️ Socket data profile: $data');

      print("Socket data profile: here 2x");

      ref.read(chatProvider.notifier).getChatThreads(silent: true);
    });

    // Listen for user status updates
    // socket!.on('userStatus', (data) {
    //   print('📢 User status update: $data');
    //   // Handle user status updates here
    // });
    socket!.on('userStatus', (data) {
      print('📢 User status update: $data');

      // Parse the data properly
      try {
        final statusData = Map<String, dynamic>.from(data);
        final userId = statusData['userId'] as String;
        final isOnline = statusData['isOnline'] as bool;

        // Update the user status provider
        final userStatusNotifier = ref.read(userStatusProvider.notifier);
        userStatusNotifier.updateStatus(userId, isOnline);

        print('Updated status for user $userId: $isOnline');
      } catch (e) {
        print('Error parsing user status: $e');
      }
    });

    socket!.connect();
  }

  // void disconnect() {
  //   socket?.disconnect();
  //   socket = null;
  //   _isConnected = false;
  // }
  void disconnect() {
    socket?.clearListeners();
    socket?.dispose(); // disposes listeners too
    socket = null;
    _isConnected = false;
  }

  bool get isConnected => _isConnected;

  // Method to listen for specific user status updates
  void listenForUserStatus(String userId, Function(dynamic) callback) {
    socket?.on('userStatus', (data) {
      final statusData = data as Map<String, dynamic>;
      if (statusData['userId'] == userId) {
        callback(statusData);
      }
    });
  }

  // Method to stop listening for user status
  void stopListeningForUserStatus() {
    socket?.off('userStatus');
  }
}
