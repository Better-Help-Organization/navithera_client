import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/constants/base_url.dart';

import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/core/util/photo_viewer.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/call/exts.dart';
// import 'package:navithera_client/feature/call/pages/prejoin.dart';
import 'package:navithera_client/feature/call/pages/room.dart';
import 'package:navithera_client/feature/chat/data/models/chat_models.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/group_profile_screen.dart';
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart'
    show chatProvider;
import 'package:navithera_client/core/providers/user_status_provider.dart';
import 'package:navithera_client/feature/chat/presentation/providers/message_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final therapistInfoProvider = FutureProvider.family<UserModel, String>((
  ref,
  therapistId,
) async {
  final chatRepository = ref.read(chatRepositoryProvider);
  final result = await chatRepository.getTherapistInfo(therapistId);
  return result.fold((failure) => throw failure, (user) => user);
});

class ChatMessageScreen extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatMessageScreen({super.key, required this.chat});

  @override
  ConsumerState<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends ConsumerState<ChatMessageScreen>
    with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isSendingVN = ValueNotifier<bool>(false);
  StreamSubscription? _messageReadSubscription;
  bool _isSending = false;
  bool _initialStatusChecked = false;
  bool _busy = false;

  // Selection mode state
  bool _isSelectionMode = false;
  final Set<String> _selectedMessageIds = {};

  @override
  void initState() {
    super.initState();
    // Load messages when the screen is first displayed
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider(widget.chat.id).notifier).getMessages();
      _markChatAsRead();
      _setupMessageReadListener();
      _setupUserStatusListener();
      _fetchInitialTherapistStatus();
    });
  }

  void _toggleSelectionMode(String messageId) {
    setState(() {
      if (_isSelectionMode) {
        if (_selectedMessageIds.contains(messageId)) {
          _selectedMessageIds.remove(messageId);
          if (_selectedMessageIds.isEmpty) {
            _isSelectionMode = false;
          }
        } else {
          _selectedMessageIds.add(messageId);
        }
      } else {
        _isSelectionMode = true;
        _selectedMessageIds.add(messageId);
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedMessageIds.clear();
    });
  }

  Future<void> _deleteSelectedMessages() async {
    final idsToDelete = _selectedMessageIds.toList();

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Messages'),
            content: Text(
              'Are you sure you want to delete ${idsToDelete.length} messages?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      final notifier = ref.read(messageProvider(widget.chat.id).notifier);
      // Assuming the provider doesn't have a bulk delete, we loop.
      // Ideally, update the backend to support bulk delete.
      for (final id in idsToDelete) {
        notifier.deleteMessage(id);
      }
      _exitSelectionMode();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - mark messages as read and check for new ones
      _markChatAsRead();
      ref
          .read(messageProvider(widget.chat.id).notifier)
          .getMessages(silent: true);
    }
  }

  void _fetchInitialTherapistStatus() {
    final therapistId = widget.chat.user?.id;
    if (therapistId != null && !_initialStatusChecked) {
      // Fetch client info to get initial online status
      ref
          .read(therapistInfoProvider(therapistId).future)
          .then((clientInfo) {
            if (mounted) {
              setState(() {
                _initialStatusChecked = true;
                // Update the chat's online status based on client info
                // You might need to add an isOnline field to your Chat model
                // or handle this differently based on your data structure
              });
            }
          })
          .catchError((error) {
            print('Failed to fetch therapist info');
          });
    }
  }

  void _setupUserStatusListener() {
    final socketService = ref.read(socketServiceProvider);
    final userStatusNotifier = ref.read(userStatusProvider.notifier);

    // Listen for user status updates
    socketService.socket?.on('userStatus', (data) {
      final statusData = data as Map<String, dynamic>;
      final userId = statusData['userId'];
      final isOnline = statusData['isOnline'];

      // Update the status provider
      userStatusNotifier.updateStatus(userId, isOnline);
    });

    // If socket is not connected, try to connect
    if (!socketService.isConnected) {
      socketService.connect();
    }
  }

  void _markChatAsRead() async {
    final messageNotifier = ref.read(messageProvider(widget.chat.id).notifier);
    await messageNotifier.markAsRead();
    ref.read(chatProvider.notifier).markChatAsRead(widget.chat.id);
  }

  void _setupMessageReadListener() {
    print("hey hey");
    // Listen for message read events (adjust this based on your notification system)
    _messageReadSubscription = FirebaseMessaging.onMessage.listen((event) {
      if (event.data['code'] == '2' || event.data['code'] == 2) {
        _markChatAsRead();

        print("hey hey new message");
      }
      print("hey hey event data is ${event.data}");
    });
  }

  String _generateRandomRoomName() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        8,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  _join(
    String url,
    String token,
    BuildContext context, {
    required bool isVideoCall,
    VoidCallback? onBeforeNavigate,
  }) async {
    _busy = true;
    setState(() {});

    // final args = widget.args;

    try {
      //create new room
      const cameraEncoding = VideoEncoding(
        maxBitrate: 5 * 1000 * 1000,
        maxFramerate: 30,
      );

      const screenEncoding = VideoEncoding(
        maxBitrate: 3 * 1000 * 1000,
        maxFramerate: 15,
      );

      final room = Room(
        roomOptions: RoomOptions(
          // adaptiveStream: args.adaptiveStream,
          adaptiveStream: true,
          dynacast: true,
          defaultAudioPublishOptions: const AudioPublishOptions(
            name: 'custom_audio_track_name',
          ),
          defaultCameraCaptureOptions: const CameraCaptureOptions(
            maxFrameRate: 30,
            params: VideoParameters(dimensions: VideoDimensions(1280, 720)),
          ),
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: false,
            // simulcast: args.simulcast,
            videoCodec: "VP8",

            videoEncoding: cameraEncoding,
            screenShareEncoding: screenEncoding,
          ),
          // encryption: e2eeOptions,
        ),
      );
      // Create a Listener before connecting
      final listener = room.createListener();

      await room.prepareConnection(url, token);

      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: true),
          camera: TrackOption(enabled: isVideoCall),
        ),
      );

      if (!context.mounted) return;

      onBeforeNavigate?.call();
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder:
              (_) => RoomPage(
                room,
                listener,
                showVideoControl: isVideoCall,
                chatId: widget.chat.id,
                isGroup: widget.chat.isGroup!,
              ),
        ),
      );
    } catch (error) {
      print('Could not connect $error');
      if (!context.mounted) return;
      await context.showErrorDialog(error);
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }

  // Future<void> _startCall({bool isVideoCall = false}) async {
  //   final sharedPreferences = await SharedPreferences.getInstance();

  //   final accessToken = sharedPreferences.getString('access_token');
  //   // Generate random room name
  //   final roomName = _generateRandomRoomName();

  //   print("roomName: $roomName");
  //   print("name: ${widget.chat.id}");

  //   try {
  //     // Call your backend endpoint
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer ${accessToken}';

  //     final response = await dio.post(
  //       '${base_url_dev}/chat/call/${widget.chat.id}',
  //       data: {'room': roomName, 'isVideoCall': isVideoCall},
  //     );

  //     print("Response: ${response.data}");

  //     // Check if status code is 201
  //     if (response.statusCode == 201) {
  //       final responseData = response.data['data'];
  //       final String token = responseData['token'];

  //       if (token == null || token.isEmpty) {
  //         if (!mounted) return;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Failed to start call'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //         return;
  //       }
  //       // _joinRoomDirectly(context);
  //       // return;
  //       // Navigate to CallScreen with the generated room name
  //       if (!mounted) return;
  //       print("token ${token}");
  //       // _join(
  //       //   "wss://navicare-dmw0dh3w.livekit.cloud",
  //       //   token,
  //       //   context,
  //       // );
  //       final token2 =
  //           "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSTNyUGFadUdxYjI4OCIsImV4cCI6MTc2NDMyOTEzNCwibmJmIjowLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lIn0.Ef8iTBjiIGhpVbYBo9mt8hK0sQaqTUzpDcJCjXOrVQs";
  //       _join(
  //         "wss://demo-eukecq5l.livekit.cloud",
  //         token,
  //         context,
  //         isVideoCall: isVideoCall,
  //       );
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder:
  //       //         (context) =>
  //       //         // CallScreen(
  //       //         //   roomName: roomName,
  //       //         //   participantName: widget.chat.name ?? "Unknown",
  //       //         //   isVideoCall: isVideoCall,
  //       //         //   chatId: widget.chat.id,
  //       //         // ),
  //       //         PreJoinPage(
  //       //           args: JoinArgs(
  //       //             url: "wss://demo-eukecq5l.livekit.cloud", // Your known URL
  //       //             token: token2, // Your known token
  //       //             // token:
  //       //             //     "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSTNyUGFadUdxYjI4OCIsImV4cCI6MTc2NDE5NDMyMywibmJmIjowLCJzdWIiOiJtZW1lLXVzZXJuYW1lIn0.jMqEzPA1cRVRcdrIeSqns9UaBmQ67Ce9GXgIQflnEh8",
  //       //             adaptiveStream: true,
  //       //             dynacast: true,
  //       //             simulcast: false,
  //       //             e2ee: false,
  //       //             preferredCodec: 'VP8',
  //       //             enableBackupVideoCodec: true,
  //       //           ),
  //       //         ),
  //       //   ),
  //       // );
  //     } else {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             'Failed to start call: ${response.data['message'] ?? 'Unknown error'}',
  //           ),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     print("DioException: ${e.toString()}");
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An unexpected error occurred'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _startCall({bool isVideoCall = false}) async {
    // 1. Create a CancelToken to control the HTTP request
    final cancelToken = CancelToken();

    // Show calling overlay
    OverlayEntry? overlayEntry;

    void removeOverlay() {
      overlayEntry?.remove();
      overlayEntry = null;
      if (mounted) {
        setState(() {
          _busy = false;
        });
      }
    }

    overlayEntry = OverlayEntry(
      builder:
          (context) => CallingOverlay(
            userName: widget.chat.name ?? 'Unknown',
            isVideoCall: isVideoCall,
            onCancel: () {
              // 2. Trigger cancellation when user taps button
              if (!cancelToken.isCancelled) {
                cancelToken.cancel("User cancelled the call");
              }
              removeOverlay();
            },
          ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      _busy = true;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    final roomName = _generateRandomRoomName();

    print("roomName: $roomName");
    print("name: ${widget.chat.id}");

    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer ${accessToken}';

      // 3. Pass the cancelToken to the request
      final response = await dio.post(
        '${base_url_dev}/chat/call/${widget.chat.id}',
        data: {'room': roomName, 'isVideoCall': isVideoCall},
        cancelToken: cancelToken,
      );

      // 4. Check if cancelled immediately after await (in case cancel happened during response processing)
      if (cancelToken.isCancelled) {
        removeOverlay();
        return;
      }

      print("Response: ${response.data}");

      if (response.statusCode == 201) {
        final responseData = response.data['data'];
        final String token = responseData['token'];

        if (token == null || token.isEmpty) {
          removeOverlay();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to start call'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Navigate to call room
        if (!mounted) return;

        // Wait a moment for user to see the calling screen
        await Future.delayed(const Duration(milliseconds: 500));

        // 5. Check cancellation again before the heavy lifting of joining video
        if (cancelToken.isCancelled) {
          removeOverlay();
          return;
        }

        // Join the call
        await _join(
          "wss://livekit.navigo.et",
          token,
          context,
          isVideoCall: isVideoCall,
          onBeforeNavigate: () {
            removeOverlay();
          },
        );
      } else {
        removeOverlay();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to start call: ${response.data['message'] ?? 'Unknown error'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on DioException catch (e) {
      removeOverlay();

      // 6. Handle the specific Cancel exception silently
      if (CancelToken.isCancel(e)) {
        print("Call flow cancelled by user.");
        return;
      }

      print("DioException: ${e.toString()}");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      removeOverlay();
      print("Unexpected error: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Ensure overlay is removed if logic falls through
      if (overlayEntry != null) {
        removeOverlay();
      }
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    print("Sending message: $content");
    _messageController.clear();
    if (content.isEmpty) return;

    _isSendingVN.value = true;

    await ref
        .read(messageProvider(widget.chat.id).notifier)
        .sendMessage(content, ref.read(currentUserProvider)!.id);

    // Update chat threads in background (don’t block UI)
    // ignore: unawaited_futures
    await ref.read(chatProvider.notifier).getChatThreads(silent: true);

    _isSendingVN.value = false;
  }

  String _formatMessageTime(DateTime dt) {
    // Convert UTC to local time
    final localDt = dt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(localDt.year, localDt.month, localDt.day);

    if (messageDate == today) {
      return '${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      return 'Yesterday, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    } else {
      return '${localDt.month}/${localDt.day}, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    }
  }

  Widget _buildDateSeparator(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessageDetail message) {
    final user = ref.read(currentUserProvider);
    final isMe = message.client != null && user?.id == message.client!.id;
    final isSelected = _selectedMessageIds.contains(message.id);

    Widget bubbleContent = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          if (widget.chat.isGroup != null && widget.chat.isGroup == true)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: getRandomGradient(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    initials(
                      message.client?.firstName ??
                          message.therapist?.firstName ??
                          'T',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        Flexible(
          child: Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft:
                          isMe ? const Radius.circular(20) : Radius.zero,
                      bottomRight:
                          isMe ? Radius.zero : const Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: TextStyle(
                          color: isMe ? Colors.white : AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatMessageTime(message.createdAt),
                            style: TextStyle(
                              color: isMe ? Colors.white70 : Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            message.isRead == true && isMe
                                ? Icons.done_all
                                : message.isRead == false && isMe
                                ? Icons.done
                                : null,
                            size: 12,
                            color: isMe ? Colors.white70 : Colors.grey[600],
                          ),
                          if (message.isPending) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: isMe ? Colors.white70 : Colors.grey[600],
                            ),
                          ] else if (message.isFailed) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.error,
                              size: 12,
                              color: Colors.red,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return GestureDetector(
      onLongPress: () {
        // Only allow selecting own messages? Telegram allows selecting any message to forward/delete (delete for everyone depends).
        // The prompt implies "we can go and select other chats as well and delete all at once".
        // Typically users can only delete their own messages for everyone, or delete any message for themselves.
        // Assuming standard behavior: allow selecting any message.
        // The implementation of delete will handle permissions (or the backend will).
        _toggleSelectionMode(message.id);
      },
      onTap: () {
        if (_isSelectionMode) {
          _toggleSelectionMode(message.id);
        }
      },
      child: Container(
        color:
            _isSelectionMode && isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          children: [
            if (_isSelectionMode)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child:
                      isSelected
                          ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                          : null,
                ),
              ),
            Expanded(child: bubbleContent),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final messageState = ref.watch(messageProvider(widget.chat.id));

    print("Message State: ${widget.chat.groupList}");
    final therapistId = widget.chat.user?.id;
    final isOnlineFromSocket = ref.watch(userStatusProvider)[therapistId];

    // Watch the client info provider
    final clientInfoAsync =
        therapistId != null
            ? ref.watch(therapistInfoProvider(therapistId))
            : null;

    // Determine the final online status
    final bool isOnline;
    if (isOnlineFromSocket != null) {
      // Prefer real-time socket status
      isOnline = isOnlineFromSocket;
    } else if (clientInfoAsync != null &&
        clientInfoAsync is AsyncData<UserModel>) {
      // Use client info status as fallback
      isOnline =
          clientInfoAsync.value.isOnline ??
          false; // Adjust based on your UserModel
    } else {
      // Default to chat's stored status
      isOnline = widget.chat.isOnline ?? false;
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar:
          _isSelectionMode
              ? AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: _exitSelectionMode,
                ),
                title: Text(
                  '${_selectedMessageIds.length}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: _deleteSelectedMessages,
                  ),
                ],
              )
              : AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.black.withOpacity(0.1),
                leadingWidth: 30,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Check if it's a user with a profile image
                        if (widget.chat.avatarUrl != null &&
                            widget.chat.avatarUrl!.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => FullScreenImageViewer(
                                    imageUrl: widget.chat.avatarUrl!,
                                    heroTag: 'appbar-avatar-${widget.chat.id}',
                                  ),
                            ),
                          );
                        }

                        if (widget.chat.isGroup != null &&
                            widget.chat.isGroup == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => GroupProfileScreen(
                                    therapist: widget.chat.user,
                                    groupName: widget.chat.name ?? 'Group Chat',
                                    groupMembers: widget.chat.groupList,
                                  ),
                            ),
                          );
                        }
                      },
                      child:
                          (widget.chat.isGroup != null &&
                                  widget.chat.isGroup == false)
                              ? Hero(
                                tag: 'appbar-avatar-${widget.chat.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:
                                      widget.chat.avatarUrl != null &&
                                              widget.chat.avatarUrl!.isNotEmpty
                                          ? Image(
                                            image: NetworkImage(
                                              widget.chat.avatarUrl!,
                                            ),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Image(
                                                image: AssetImage(
                                                  getAvatarImage(
                                                    widget.chat.avatar ?? 0,
                                                  ),
                                                ),
                                                width: 80,
                                                height: 80,
                                              );
                                            },
                                          )
                                          : Image.asset(
                                            getAvatarImage(
                                              widget.chat.avatar ?? 0,
                                            ),
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              )
                              : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape:
                                      (widget.chat.isGroup != null &&
                                              widget.chat.isGroup == true)
                                          ? BoxShape.rectangle
                                          : BoxShape.circle,
                                  borderRadius:
                                      (widget.chat.isGroup != null &&
                                              widget.chat.isGroup == true)
                                          ? BorderRadius.circular(12)
                                          : null,
                                  gradient: LinearGradient(
                                    colors: getRandomGradient(),
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    initials(
                                      widget.chat.isGroup != null &&
                                              widget.chat.isGroup == false
                                          ? '${widget.chat.name}'
                                          : 'Group',
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.chat.name ?? 'Unknown',
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (widget.chat.isGroup == false)
                          Text(
                            isOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              fontSize: 12,
                              color: isOnline ? Colors.green : Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  if (widget.chat.isGroup != null &&
                      widget.chat.isGroup == false)
                    // if (!(_busy))
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () => _startCall(isVideoCall: false),
                      //  onPressed: _busy ? null : () => _join(context),
                    ),
                  if (widget.chat.isGroup != null &&
                      widget.chat.isGroup == false)
                    IconButton(
                      icon: const Icon(Icons.videocam_outlined),
                      onPressed: () => _startCall(isVideoCall: true),
                    ),
                ],
              ),

      body: Column(
        children: [
          // Only messages list rebuilds when provider emits
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final messageState = ref.watch(messageProvider(widget.chat.id));
                return switch (messageState) {
                  Initial() => const Center(child: Text('No messages yet')),
                  Loading() => const Center(child: CircularProgressIndicator()),
                  Error(:final failure) => Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(failure.message.toString()),
                      ),
                    ),
                  ),
                  Loaded(:final messages, :final canLoadMore) =>
                    _buildMessageList(messages),
                  // TODO: Handle this case.
                  MessageState() => throw UnimplementedError(),
                };
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 30,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  suffixIcon: ValueListenableBuilder<bool>(
                    valueListenable: _isSendingVN,
                    builder: (context, isSending, _) {
                      return IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: isSending ? Colors.grey : AppColors.primary,
                        ),
                        onPressed: isSending ? null : _sendMessage,
                      );
                    },
                  ),
                ),
                minLines: 1,
                maxLines: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<ChatMessageDetail> messages) {
    final widgets = <Widget>[];
    for (final m in messages) {
      print("mxbike : ${m}");
      widgets.add(_buildMessageBubble(m));
    }
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      reverse: true,
      children: widgets,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class CallingOverlay extends StatefulWidget {
  final String userName;
  final bool isVideoCall;
  final VoidCallback onCancel;

  const CallingOverlay({
    super.key,
    required this.userName,
    required this.isVideoCall,
    required this.onCancel,
  });

  @override
  State<CallingOverlay> createState() => _CallingOverlayState();
}

class _CallingOverlayState extends State<CallingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.85),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated avatar
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    getInitials(widget.userName),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // User name
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Call type and status
            Text(
              widget.isVideoCall ? 'Video Call' : 'Voice Call',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Calling text with animated dots
            _buildCallingText(),

            const SizedBox(height: 60),

            // Cancel button
            // ElevatedButton(
            //   onPressed: widget.onCancel,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     foregroundColor: Colors.white,
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 32,
            //       vertical: 12,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            //   child: const Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Icon(Icons.close, size: 20),
            //       SizedBox(width: 8),
            //       Text('Cancel Call', style: TextStyle(fontSize: 16)),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 30),

            // Spinning indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallingText() {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: 3),
      duration: const Duration(milliseconds: 1200),
      // repeatForever: true,
      builder: (context, value, child) {
        String dots = '.' * value;
        return Text(
          'Calling$dots',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Helper function for initials
String getInitials(String name) {
  final parts = name.split(' ');
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}';
  } else if (name.isNotEmpty) {
    return name[0];
  }
  return 'U';
}
