// lib/core/notification/notification_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/notification/new_message_notificaiton.dart';
import 'package:navithera_client/core/notification/session_selection_service.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navithera_client/feature/chat/presentation/providers/message_provider.dart';
import 'package:navithera_client/feature/home/presentation/pages/home_screen.dart';
import 'package:navithera_client/feature/home/presentation/providers/matched_therapist_provider.dart';
import 'package:navithera_client/feature/home/presentation/providers/upcoming_session_provider.dart';
import 'package:navithera_client/feature/therapy/presentation/pages/call_screen.dart';
import 'package:navithera_client/main.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import to access navigatorKey
import 'package:uuid/uuid.dart';

class PendingRoute {
  final String path;
  final Object? extra;

  PendingRoute({required this.path, this.extra});
}

// final fcmServiceProvider = Provider<FCMService>((ref) {
//   return FCMService(FirebaseMessaging.instance);
// });
final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService(FirebaseMessaging.instance, ref);
});

final activeCallDialogProvider =
    StateProvider<Map<String, OverlaySupportEntry?>>((ref) => {});
//final pendingRouteProvider = StateProvider<String?>((ref) => null);
final pendingRouteProvider = StateProvider<PendingRoute?>((ref) => null);

class FCMService {
  final FirebaseMessaging _fcm;
  final Ref _ref;

  FCMService(this._fcm, this._ref);

  AudioPlayer? _ringtonePlayer;
  String? _activeCallChatId;
  bool get _isCallDialogOpen => _activeCallChatId != null;

  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  Future<void> initialize() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundMessage);
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleInitialBackgroundMessage(initialMessage);
    }

    print('FCM initialized. Token: ${await getToken()}');
  }

  Future<void> initFCMWeb() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken(
      vapidKey:
          "BELdOx18JErKFF0TBMGM1JFR-gqfdYSKzmD8-Qw2hDn-gJVCyhgjXHzgOp_--f1quVjlownrkfz-scO74GZXSiE",
    );

    print("token ${token}");
  }

  void _handleForegroundMessage(RemoteMessage message) async {
    log(
      "Full message: ${message.data}",
    ); // This might contain the actual data payload
    print(
      "message: ${message.notification?.title} - ${message.notification?.body}",
    );

    try {
      //25
      if (message.data['code'] == '11' || message.data['code'] == 11) {
        // _handleSessionSelectionNotification(message);
        // _handleSessionNotification();
        final context = navigatorKey.currentContext;
        print("context: $context");
        if (context == null) return;
        // //ref.read(routerProvider).go('/auth-gate');
        //final result = await ref.read(authProvider.notifier).getCurrentUser();
        final container = ProviderScope.containerOf(context);
        await container.read(authProvider.notifier).getCurrentUser();
        GoRouter.of(context).push('/auth-gate');
        showOverlayNotification(
          (context) {
            return NewMessageNotificationBanner(
              title: "Status Change",
              body: "Your status is ${message.data['id']}.",
              isMessage: false,
              onTap: () {},
            );
          },
          duration: Duration(seconds: 5),
          position: NotificationPosition.top,
        );
        return;
      }
      if (message.data['code'] == '1' || message.data['code'] == 1) {
        _handleSessionSelectionNotification(message);
        _handleSessionNotification();
        //final context = navigatorKey.currentContext;
        // print("context: $context");
        // if (context == null) return;
        return;
      }
      if (message.data['code'] == '25' || message.data['code'] == 25) {
        print("25 25 25 25 code received");
        // _handleSessionSelectionNotification(message);
        // _handleSessionNotification();
        //final context = navigatorKey.currentContext;
        // print("context: $context");
        // if (context == null) return;
        final context = navigatorKey.currentContext;
        print("context: $context");
        if (context == null) return;
        // //ref.read(routerProvider).go('/auth-gate');
        //final result = await ref.read(authProvider.notifier).getCurrentUser();
        final container = ProviderScope.containerOf(context);
        await container.read(authProvider.notifier).getCurrentUser();
        GoRouter.of(context).push('/auth-gate');
        return;
      }
      if (message.data['code'] == '8' || message.data['code'] == 8) {
        print("event data is ${message.data}");
        final context = navigatorKey.currentContext;

        if (context == null) return;

        // Get the provider scope
        final container = ProviderScope.containerOf(context);

        // Refresh the chat list
        container.read(chatProvider.notifier).getChatThreads(silent: true);
        return;
      }
      if (message.data['code'] == '14' || message.data['code'] == 14) {
        // message.data['id'] is a JSON string
        final idJson = message.data['id'];
        final idMap = jsonDecode(idJson); // Convert to Map

        print("14xxy $idMap");

        final chatId = idMap['chat']; // Now works
        print("14 chatId: $chatId");

        _updateChatData(chatId);
      }
      if (message.notification?.title == 'Call Ended' ||
          message.notification?.body?.toLowerCase().contains('call ended') ==
              true ||
          message.data['code'] == '6' ||
          message.data['code'] == 6) {
        final chatId = _extractChatIdFromMessage(message);

        _showCallEndedSnackbar('Call ended by the other party');
        if (chatId != null) {
          _dismissCallPopupIfMatches(chatId);

          try {
            await FlutterCallkitIncoming.endAllCalls();
          } catch (_) {}
        }
        return;
      }
      if (message.data['code'] == '4' || message.data['code'] == 4) {
        print("event data is ${message.data}");
        _handleMessageReadEvent(message);
        return;
      }

      if (_isIncomingCallMessage(message)) {
        final call = _parseIncomingCall(message);

        if (call != null) {
          _showCallInvitationDialog(
            call.room,
            call.callerName,
            call.chatId,
            call.isVideoCall,
          );
        }
        return;
      }
      if (message.notification?.title == 'Added to Chat') {
        print("ok ok ok");
        // _handleNewMessageNotification(message);
        final context = navigatorKey.currentContext;

        if (context == null) return;

        // Get the provider scope
        final container = ProviderScope.containerOf(context);

        // Refresh the chat list
        container.read(chatProvider.notifier).getChatThreads(silent: true);
      } else if (message.notification?.title == 'Call Rejected') {
        _handleCallRejectedNotification(message);
      } else if (message.data['code'] == '2' || message.data['code'] == 2) {
        print("ok ok ok");
        // _handleNewMessageNotification(message);
        _showNewMessageNotificationBanner(message);
      } else if (message.notification?.title == 'Match accepted') {
        print("bearer 1");
        final context = navigatorKey.currentContext;
        if (context != null) {
          final container = ProviderScope.containerOf(context);
          print("bearer 2");

          // container.read(homeRefreshProvider.notifier).refresh();
          // _ref.read(homeRefreshProvider.notifier).refresh();
        }
        try {
          final data = message.data;
          if (data.containsKey('id')) {
            final matchData = json.decode(data['id']) as Map<String, dynamic>;

            if (matchData.containsKey('AcceptedTherapist')) {
              final therapistData =
                  matchData['AcceptedTherapist'] as Map<String, dynamic>;
              final therapist = UserModel.fromJson(therapistData);

              final context = navigatorKey.currentContext;
              if (context != null) {
                final container = ProviderScope.containerOf(context);

                // container.read(homeRefreshProvider.notifier).refresh();
                // _ref.read(homeRefreshProvider.notifier).refresh();
                // final container = ProviderScope.containerOf(context);

                // // Refresh the chat list
                // container
                //     .read(chatProvider.notifier)
                //     .getChatThreads(silent: true);

                // Navigate to therapist profile screen
                showOverlayNotification(
                  (context) {
                    return NewMessageNotificationBanner(
                      title: "Match accepted",
                      body: "Your match has accepted. Tap to view profile.",
                      isMessage: false,
                      onTap: () {
                        final currentLocation =
                            GoRouter.of(context)
                                .routerDelegate
                                .currentConfiguration
                                .last
                                .matchedLocation;
                        print("Current location: $currentLocation");
                        //final targetRoute = '/chat/$chatId';
                        print(
                          "Notification banner tapped. Navigating to chat...",
                        );
                        OverlaySupportEntry.of(
                          context,
                        )?.dismiss(animate: false);

                        if (currentLocation != '/therapist-profile') {
                          GoRouter.of(
                            context,
                          ).push('/therapist-profile', extra: therapist);
                        }
                      },
                    );
                  },
                  duration: Duration(seconds: 5),
                  position: NotificationPosition.top,
                );
                // final container = ProviderScope.containerOf(context);
                // final currentCount = container.read(homeRefreshProvider);
                // container.read(homeRefreshProvider.notifier).state =
                //     currentCount + 1;
              }
            }
          }
        } catch (e) {
          print('Error handling match accepted notification: $e');
        }
        //_handleMatchAcceptedNotification(message);
        //final context = navigatorKey.currentContext;
      } else if (message.notification?.title == "Session scheduled") {
        //final bodyJson = jsonDecode(message.data?.body ?? '{}');
        // print("Parsed body JSON: $bodyJson");
        _handleSessionNotification();
        final context = navigatorKey.currentContext;
        print("context: $context");
        if (context == null) return;
        // final container = ProviderScope.containerOf(context);

        // // Refresh the chat list
        // container.read(chatProvider.notifier).getChatThreads(silent: true);
      }
    } catch (e) {}
  }

  void _handleCallRejectedNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    // Check if we're currently in a call screen
    final currentLocation =
        GoRouter.of(
          context,
        ).routerDelegate.currentConfiguration.last.matchedLocation;
    if (currentLocation.contains('/call')) {
      // Show a message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Call was rejected by the other party'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );

      // Navigate back to previous screen
      Navigator.of(context).pop();
    }
  }

  void handleBackgroundMessage(RemoteMessage message) async {
    log(
      "Full message: ${message.data}",
    ); // This might contain the actual data payload
    print(
      "message: ${message.notification?.title} - ${message.notification?.body}",
    );
    if (message.data['code'] == '25' || message.data['code'] == 25) {
      // _handleSessionSelectionNotification(message);
      // _handleSessionNotification();
      //final context = navigatorKey.currentContext;
      // print("context: $context");
      // if (context == null) return;
      final context = navigatorKey.currentContext;
      print("context: $context");
      if (context == null) return;
      // //ref.read(routerProvider).go('/auth-gate');
      //final result = await ref.read(authProvider.notifier).getCurrentUser();
      final container = ProviderScope.containerOf(context);
      await container.read(authProvider.notifier).getCurrentUser();
      GoRouter.of(context).push('/auth-gate');
      return;
    }
    if (message.data['code'] == '11' || message.data['code'] == 11) {
      // _handleSessionSelectionNotification(message);
      // _handleSessionNotification();
      final context = navigatorKey.currentContext;
      print("context: $context");
      if (context == null) return;
      // //ref.read(routerProvider).go('/auth-gate');
      //final result = await ref.read(authProvider.notifier).getCurrentUser();
      final container = ProviderScope.containerOf(context);
      await container.read(authProvider.notifier).getCurrentUser();
      GoRouter.of(context).push('/auth-gate');
      showOverlayNotification(
        (context) {
          return NewMessageNotificationBanner(
            title: "Status Change",
            body: "",
            isMessage: false,
            onTap: () {},
          );
        },
        duration: Duration(seconds: 5),
        position: NotificationPosition.top,
      );
      return;
    }
    if (message.data['code'] == '1' || message.data['code'] == 1) {
      _handleSessionSelectionNotification(message);
      _handleSessionNotification();
      //final context = navigatorKey.currentContext;
      // print("context: $context");
      // if (context == null) return;
      return;
    }

    if (message.data['code'] == '4' || message.data['code'] == 4) {
      print("event data is ${message.data}");
      _handleMessageReadEvent(message);
      return;
    }
    if (message.data['code'] == '8' || message.data['code'] == 8) {
      print("event data is ${message.data}");
      final context = navigatorKey.currentContext;

      if (context == null) return;

      // Get the provider scope
      final container = ProviderScope.containerOf(context);

      // Refresh the chat list
      container.read(chatProvider.notifier).getChatThreads(silent: true);
      return;
    }
    // if (message.notification?.title == 'Incoming Call') {
    //   final idJsonString = message.data['id'];
    //   if (idJsonString != null) {
    //     // Parse the inner JSON
    //     final idMap = json.decode(idJsonString) as Map<String, dynamic>;

    //     // Extract room
    //     final room = idMap['room'] as String?;
    //     final chatId = idMap['chatId'];

    //     // Extract caller data
    //     final callerData = idMap['callerData'] as Map<String, dynamic>?;
    //     if (callerData != null) {
    //       final firstName = callerData['firstName'] as String?;
    //       final lastName = callerData['lastName'] as String?;
    //       final fullName = '$firstName $lastName';
    //       //final email = callerData['email'] as String?;

    //       _showCallInvitationDialog(room!, fullName ?? 'Guest', chatId);

    //       // You can now use these values in your UI or logic
    //     }
    //   }
    // } else
    if (_isIncomingCallMessage(message)) {
      final call = _parseIncomingCall(message);
      if (call != null) {
        await _showCallKitIncoming(call);
      }
      return;
    }

    if (message.notification?.title == "Session scheduled") {
      //final bodyJson = jsonDecode(message.data?.body ?? '{}');
      log("hohohohohoho");
      log("hohohohohoho: ${message.data}");
      // print("Parsed body JSON: $bodyJson");
      _handleSessionNotification();
      final context = navigatorKey.currentContext;
      print("context: $context");
      if (context == null) return;
      // final container = ProviderScope.containerOf(context);

      // // Refresh the chat list
      // container.read(chatProvider.notifier).getChatThreads(silent: true);
    } else if (message.notification?.title == 'Match accepted') {
      print("bearer 1");
      final context = navigatorKey.currentContext;
      if (context != null) {
        final container = ProviderScope.containerOf(context);
        print("bearer 2");

        // container.read(homeRefreshProvider.notifier).refresh();
        // _ref.read(homeRefreshProvider.notifier).refresh();
      }
      _handleMatchAcceptedNotification(message);
      // final context = navigatorKey.currentContext;

      // if (context == null) return;
      // final container = ProviderScope.containerOf(context);

      // // Refresh the chat list
      // container.read(chatProvider.notifier).getChatThreads(silent: true);
    } else if (message.notification?.title == 'Added to Chat') {
      print("ok ok ok");

      // _handleNewMessageNotification(message);
      final context = navigatorKey.currentContext;

      if (context == null) return;

      // Get the provider scope
      final container = ProviderScope.containerOf(context);

      // Refresh the chat list
      container.read(chatProvider.notifier).getChatThreads(silent: true);
    } else if (message.notification?.title == 'Call Rejected') {
      _handleCallRejectedNotification(message);
    } else if (message.data['code'] == '2' || message.data['code'] == 2) {
      final locationContext = navigatorKey.currentContext;
      print("Current location $locationContext");
      if (locationContext == null) return;

      final context = navigatorKey.currentContext;
      if (context == null) {
        print("Navigator context is null");
        return;
      }
      //final notification = message.notification;
      final data = message.data;
      // final chatId = message.data['chatId'];

      final chatData = jsonDecode(data["id"]);
      final chatId = chatData['chat']['id'];
      _updateChatData(chatId);
      final senderName =
          chatData['chat']['therapist']['firstName'] +
          ' ' +
          chatData['chat']['therapist']['lastName'];
      final therapistMap = chatData['chat']['therapist'];
      final therapist = UserModel.fromJson(therapistMap);
      final senderProfile = chatData['chat']['therapist']['profile'] ?? '';
      final senderAvatar = chatData['chat']['therapist']['avatar'] ?? '';

      // final currentContext = navigatorKey.currentContext;
      // final currentRoute = ModalRoute.of(currentContext!)?.settings.name;
      final newRoute = '/chat/$chatId';

      final currentLocation =
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.last.matchedLocation;
      print("Current location: $currentLocation");

      if (currentLocation != newRoute) {
        final chat = Chat(
          id: chatId,
          name: senderName,
          lastMessage: 'I sent you the design files 📎',
          avatarUrl:
              (senderAvatar == 7) &&
                      senderProfile != null &&
                      senderProfile!.isNotEmpty
                  ? '$base_url_for_image${senderProfile}?v=${DateTime.now().millisecondsSinceEpoch}'
                  : null,
          unreadCount: 0,
          timestamp: DateTime(2025, 4, 2, 14, 15),
          isOutgoing: true,
          isRead: true,
          user: therapist,
          avatar: senderAvatar,
        );
        GoRouter.of(context).push('/chat/$chatId', extra: chat);
      }
    }
  }

  void _handleSessionNotification() {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final container = ProviderScope.containerOf(context);

    //print("Session notification received: ${message.notification?.title}");
    container.read(sessionProvider.notifier).loadSessions();
    container.read(upcomingSessionProvider.notifier).loadNext();
    container.read(matchedTherapistProvider.notifier).load();
  }

  void handleInitialBackgroundMessage(RemoteMessage message) async {
    if (message.data['code'] == '4' || message.data['code'] == 4) {
      print("event data is ${message.data}");
      _handleMessageReadEvent(message);
      return;
    }
    if (message.data['code'] == '25' || message.data['code'] == 25) {
      final context = navigatorKey.currentContext;
      print("context: $context");
      if (context == null) return;

      final container = ProviderScope.containerOf(context);
      await container.read(authProvider.notifier).getCurrentUser();
      GoRouter.of(context).push('/auth-gate');
      return;
    }
    // if (message.notification?.title == 'Incoming Call') {
    //   final idJsonString = message.data['id'];
    //   if (idJsonString != null) {
    //     // Parse the inner JSON
    //     final idMap = json.decode(idJsonString) as Map<String, dynamic>;

    //     // Extract room
    //     final room = idMap['room'] as String?;
    //     final chatId = idMap['chatId'];

    //     // Extract caller data
    //     final callerData = idMap['callerData'] as Map<String, dynamic>?;
    //     if (callerData != null) {
    //       final firstName = callerData['firstName'] as String?;
    //       final lastName = callerData['lastName'] as String?;
    //       final fullName = '$firstName $lastName';
    //       //final email = callerData['email'] as String?;

    //       _showCallInvitationDialog(room!, fullName ?? 'Guest', chatId);

    //       // You can now use these values in your UI or logic
    //     }
    //   }
    // } else
    if (_isIncomingCallMessage(message)) {
      // App opened from terminated by tapping notification is typical.
      // We should present CallKit immediately to mirror Telegram-like behavior.
      final call = _parseIncomingCall(message);
      //final container = ProviderScope.containerOf(context);
      // container.read(pendingRouteProvider.notifier).state = PendingRoute(
      //   path: '/chat/$chatId',
      //   extra: chat,
      // );
      if (call != null) {
        await _showCallKitIncoming(call);
      }
      return;
    }

    if (message.notification?.title == 'Match accepted') {
      try {
        final data = message.data;
        if (data.containsKey('id')) {
          final matchData = json.decode(data['id']) as Map<String, dynamic>;

          if (matchData.containsKey('AcceptedTherapist')) {
            final therapistData =
                matchData['AcceptedTherapist'] as Map<String, dynamic>;
            final therapist = UserModel.fromJson(therapistData);

            // Store for later navigation if context is not available
            final container = ProviderScope.containerOf(
              navigatorKey.currentContext!,
            );
            container.read(pendingRouteProvider.notifier).state = PendingRoute(
              path: '/therapist-profile',
              extra: therapist,
            );
          }
        }
      } catch (e) {
        print('Error handling match accepted notification: $e');
      }
      // final context = navigatorKey.currentContext;

      // if (context == null) return;
      // final container = ProviderScope.containerOf(context);

      // // Refresh the chat list
      // container.read(chatProvider.notifier).getChatThreads(silent: true);
    } else if (message.notification?.title == 'Added to Chat') {
      print("ok ok ok");
      // _handleNewMessageNotification(message);
      final context = navigatorKey.currentContext;

      if (context == null) return;

      // Get the provider scope
      final container = ProviderScope.containerOf(context);

      // Refresh the chat list
      container.read(chatProvider.notifier).getChatThreads(silent: true);
    } else if (message.notification?.title == 'Call Rejected') {
      _handleCallRejectedNotification(message);
    } else if (message.data['code'] == '2' || message.data['code'] == 2) {
      final locationContext = navigatorKey.currentContext;
      print("Current location $locationContext");
      if (locationContext == null) return;

      final context = navigatorKey.currentContext;
      if (context == null) {
        print("Navigator context is null");
        return;
      }
      final container = ProviderScope.containerOf(context);
      //final notification = message.notification;
      final data = message.data;
      // final chatId = message.data['chatId'];

      final chatData = jsonDecode(data["id"]);
      final chatId = chatData['chat']['id'];
      _updateChatData(chatId);
      final senderName =
          chatData['chat']['therapist']['firstName'] +
          ' ' +
          chatData['chat']['therapist']['lastName'];
      final therapistMap = chatData['chat']['therapist'];
      final therapist = UserModel.fromJson(therapistMap);
      final senderProfile = chatData['chat']['therapist']['profile'] ?? '';
      final senderAvatar = chatData['chat']['therapist']['avatar'] ?? '';

      //container.read(pendingRouteProvider.notifier).state = '/chat/$chatId';
      final chat = Chat(
        id: chatId,
        name: senderName,
        lastMessage: 'I sent you the design files 📎',
        avatarUrl:
            (senderAvatar == 7) &&
                    senderProfile != null &&
                    senderProfile!.isNotEmpty
                ? '$base_url_for_image${senderProfile}?v=${DateTime.now().millisecondsSinceEpoch}'
                : null,
        unreadCount: 0,
        timestamp: DateTime(2025, 4, 2, 14, 15),
        isOutgoing: true,
        isRead: true,
        user: therapist,
        avatar: senderAvatar,
      );

      container.read(pendingRouteProvider.notifier).state = PendingRoute(
        path: '/chat/$chatId',
        extra: chat,
      );
    }
  }

  void _dismissCallPopupIfMatches(String chatId) async {
    if (_activeCallChatId == null) return;
    if (_activeCallChatId != chatId) return;

    try {
      // Stop ringtone
      await _ringtonePlayer?.stop();
    } catch (e) {
      print('Error stopping ringtone: $e');
    }

    // Try popping the dialog
    final context = navigatorKey.currentContext;
    if (context != null) {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    _activeCallChatId = null;
    _ringtonePlayer = null;
  }

  String? _extractChatIdFromMessage(RemoteMessage message) {
    try {
      if (message.data['id'] != null) {
        final raw = message.data['id'];
        final decoded = raw is String ? jsonDecode(raw) : raw;
        if (decoded is Map<String, dynamic>) {
          // You showed data like: { chatId: "...", callerData: {...}, ... }
          if (decoded['chatId'] is String) return decoded['chatId'] as String;
          // Some senders embed deeper
          if (decoded['chat'] is Map && decoded['chat']['id'] is String) {
            return decoded['chat']['id'] as String;
          }
        }
      }
      // Fallback: sometimes chatId is directly in data
      if (message.data['chatId'] is String)
        return message.data['chatId'] as String;
    } catch (e) {
      print('Error extracting chatId: $e');
    }
    return null;
  }

  void _showNewMessageNotificationBanner(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    //final currentRoute = GoRouter.of(context).location;
    final currentLocation =
        GoRouter.of(
          context,
        ).routerDelegate.currentConfiguration.last.matchedLocation;
    print("Current location: $currentLocation");
    print("Notification context: $context");
    final notification = message.notification;
    final data = message.data;

    print("Notification: ${notification?.title} - ${notification?.body}");
    print("Notification data: $data");

    String title = notification?.title ?? 'New Message';
    String body = data['message_preview'] ?? notification?.body ?? '';
    final chatData = jsonDecode(data["id"]);
    final chatId = chatData['chat']['id'];
    String senderName = 'Group Chat';
    final therapistMap = chatData['chat']['therapist'];
    final therapist = UserModel.fromJson(therapistMap);
    final senderProfile = chatData['chat']['therapist']['profile'] ?? '';
    final senderAvatar = chatData['chat']['therapist']['avatar'] ?? '';

    if (currentLocation == '/chat/$chatId') {
      print("Already on chat screen $chatId - skipping notification");
      _updateChatData(chatId); // Still update chat data
      return;
    }

    try {
      senderName =
          chatData['chat']['therapist']['firstName'] +
          ' ' +
          chatData['chat']['therapist']['lastName'];
    } catch (e) {
      // final senderName = 'Unknown Sender';
    }

    print("my name is ${senderName}");

    print("Notification data: $data");

    showOverlayNotification(
      (context) {
        return NewMessageNotificationBanner(
          title: senderName,
          body: body,
          onTap: () {
            //final currentRoute = GoRouter.of(context).location;
            //  final currentLocation = GoRouter.of(context).location;
            final currentLocation =
                GoRouter.of(
                  context,
                ).routerDelegate.currentConfiguration.last.matchedLocation;
            print("Current location: $currentLocation");
            final targetRoute = '/chat/$chatId';
            print("Notification banner tapped. Navigating to chat...");
            OverlaySupportEntry.of(context)?.dismiss(animate: false);
            final chat = Chat(
              id: chatId,
              name: senderName,
              lastMessage: 'I sent you the design files 📎',
              avatarUrl:
                  (senderAvatar == 7) &&
                          senderProfile != null &&
                          senderProfile!.isNotEmpty
                      ? '$base_url_for_image${senderProfile}?v=${DateTime.now().millisecondsSinceEpoch}'
                      : null,
              unreadCount: 0,
              timestamp: DateTime(2025, 4, 2, 14, 15),
              isOutgoing: true,
              isRead: true,
              user: therapist,
              avatar: senderAvatar,
            );
            if (currentLocation != '/chat/$chatId') {
              GoRouter.of(context).push('/chat/$chatId', extra: chat);
            }
          },
        );
      },
      duration: Duration(seconds: 5),
      position: NotificationPosition.top,
    );

    _updateChatData(chatId);
  }

  void _handleMatchAcceptedNotification(RemoteMessage message) {
    try {
      final data = message.data;
      if (data.containsKey('id')) {
        final matchData = json.decode(data['id']) as Map<String, dynamic>;

        if (matchData.containsKey('AcceptedTherapist')) {
          final therapistData =
              matchData['AcceptedTherapist'] as Map<String, dynamic>;
          final therapist = UserModel.fromJson(therapistData);

          final context = navigatorKey.currentContext;
          if (context != null) {
            // final container = ProviderScope.containerOf(context);
            // container.read(homeRefreshProvider.notifier).refresh();
            // Navigate to therapist profile screen
            GoRouter.of(context).push('/therapist-profile', extra: therapist);
          } else {
            // Store for later navigation if context is not available
            final container = ProviderScope.containerOf(
              navigatorKey.currentContext!,
            );
            container.read(pendingRouteProvider.notifier).state = PendingRoute(
              path: '/therapist-profile',
              extra: therapist,
            );
          }
        }
      }
    } catch (e) {
      print('Error handling match accepted notification: $e');
    }
  }

  void _updateChatData(String chatId) {
    // Get the current context using navigatorKey
    final context = navigatorKey.currentContext;
    print("updating chat data for chatId context $context: $chatId");
    if (context == null) return;

    print("Updating chat data for chatId: $chatId");

    // Get the provider scope
    final container = ProviderScope.containerOf(context);

    // Refresh the chat list
    container.read(chatProvider.notifier).getChatThreads(silent: true);

    // If we're currently viewing this chat, refresh messages too
    // final currentRoute = GoRouter.of(context).location;
    //if (currentRoute.contains(chatId)) {
    container.read(messageProvider(chatId).notifier).getMessages(silent: true);
    //}
  }

  void _showCallEndedSnackbar(String message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  void _showCallInvitationDialog(
    String roomName,
    String participant,
    String chatId,
    bool isVideocall,
  ) async {
    // Use the global navigator key to get the current context
    final context = navigatorKey.currentContext;
    if (context == null) {
      print("Navigator context is null");
      return;
    }

    if (_activeCallChatId != null) {
      print("activeCallChatId: ${_activeCallChatId}");
      _dismissCallPopupIfMatches(_activeCallChatId!);
    }

    _ringtonePlayer = AudioPlayer();
    _activeCallChatId = chatId;
    try {
      await _ringtonePlayer!.play(
        AssetSource('sounds/ringtone.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      print('Error playing ringtone: $e');
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Incoming Call",
      barrierColor: Colors.black.withOpacity(0.05),
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true, // important for consistent pop
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Incoming Call',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${participant}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          icon: const Icon(Icons.call_end),
                          label: const Text('Reject'),
                          onPressed: () async {
                            await _ringtonePlayer?.stop();
                            Navigator.of(
                              dialogContext,
                              rootNavigator: true,
                            ).pop();
                            _activeCallChatId = null;
                            _ringtonePlayer = null;

                            // Send rejection request
                            try {
                              await rejectCall(chatId);
                            } catch (e) {
                              print('Error sending rejection: $e');
                            }
                          },
                        ),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          icon: const Icon(Icons.call),
                          label: const Text('Accept'),
                          onPressed: () async {
                            await _ringtonePlayer?.stop();
                            Navigator.of(
                              dialogContext,
                              rootNavigator: true,
                            ).pop();
                            _activeCallChatId = null;
                            _ringtonePlayer = null;
                            _joinCallRoom(
                              roomName,
                              participant,
                              dialogContext,
                              chatId,
                              isVideocall,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSessionSelectionNotification(RemoteMessage message) {
    try {
      final data = message.data;
      if (data['code'] == '1') {
        final idJsonString = data['id'];
        if (idJsonString != null) {
          final idMap = json.decode(idJsonString) as Map<String, dynamic>;
          final sessionIds = List<String>.from(idMap['sessionIds'] ?? []);

          final context = navigatorKey.currentContext;
          if (context != null && sessionIds.isNotEmpty) {
            final service = _ref.read(sessionSelectionServiceProvider);
            service.showSessionSelectionDialog(
              context: context,
              sessionIds: sessionIds,
            );
          }
        }
      }
    } catch (e) {
      print('Error handling session selection notification: $e');
    }
  }

  void _handleMessageReadEvent(RemoteMessage message) {
    try {
      print("Message read event received: ${message.data}");

      final data = message.data;
      if (data.containsKey('id')) {
        final eventData = json.decode(data['id']) as Map<String, dynamic>;
        final chatId = eventData['chatId'];
        final readBy = eventData['readBy'];
        final count = eventData['count'];

        print(
          'Message read event - Chat: $chatId, Read by: $readBy, Count: $count',
        );

        // Update the UI by refreshing chat data
        _updateChatData(chatId);
      }
    } catch (e) {
      print('Error handling message read event: $e');
    }
  }

  Future<void> rejectCall(String chatId) async {
    final Dio _dio = Dio();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final accessToken = sharedPreferences.getString('access_token');

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '${base_url_dev}/chat/call/reject/$chatId',
      );

      if (response.statusCode == 201) {
        print('Call rejected successfully');
      } else {
        print('Failed to reject call: ${response.data}');
      }
    } catch (e) {
      print('Error rejecting call: $e');
    }
  }

  void _joinCallRoom(
    String roomName,
    String participantName,
    BuildContext context,
    String chatId,
    bool isVideoCall,
  ) {
    // Since you're using GoRouter, you can use regular Navigator.push
    // or create a route in your GoRouter for the call screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CallScreen(
              roomName: roomName,
              participantName: participantName,
              isVideoCall: isVideoCall,
              chatId: chatId,
            ),
      ),
    );
  }

  Future<void> _showCallKitIncoming(_IncomingCall call) async {
    final uuid = const Uuid().v4();

    final params = CallKitParams(
      id: uuid,
      nameCaller: call.callerName,
      appName: 'Navicare',
      avatar: '', // Empty string for generic user icon
      handle: call.callerName,
      type: call.isVideoCall ? 1 : 0, // 0 = audio, 1 = video
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Reject',
      // textMissedCall: 'Missed Call', // Add this to control missed call text
      // textCallback: 'Callback', // Add this
      extra: {
        'chatId': call.chatId,
        'room': call.room,
        'callerName': call.callerName,
        'isVideoCall': call.isVideoCall,
      },
      headers: <String, dynamic>{},
      android: AndroidParams(
        //isCustomNotification: true,
        isShowLogo: false, // Set to false to hide logo/text
        ringtonePath: 'ringtone',
        backgroundColor: '#0bb89b', // Your app's green color
        backgroundUrl: '', // No background image
        actionColor: '#4CAF50',
        // incomingCallNotificationChannelName: 'Incoming Calls',
        // missedCallNotificationChannelName: 'Missed Calls',
        // Hide the app name in notification
        //notificationIcon: 'ic_notification', // Use your app's notification icon
      ),
      ios: IOSParams(
        iconName: 'AppIcon', // Use your app's icon
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        // includesCallsInRecents: false,
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  bool _isIncomingCallMessage(RemoteMessage message) {
    // if (message.notification?.title == 'Incoming Call') return true;
    if (message.data['code'] == '5' ||
        message.data['code'] == 5 ||
        message.data['code'] == '30' ||
        message.data['code'] == 30)
      return true;
    final code = message.data['code'];
    return code == 'CALL_INCOMING' || code == 1 || code == '1';
  }

  _IncomingCall? _parseIncomingCall(RemoteMessage message) {
    try {
      final idJsonString = message.data['id'];
      Map<String, dynamic>? idMap;
      if (idJsonString is String) {
        idMap = json.decode(idJsonString) as Map<String, dynamic>;
      } else if (idJsonString is Map<String, dynamic>) {
        idMap = idJsonString;
      } else {
        idMap = {};
      }

      final chatId = idMap['chatId'] ?? idMap['chat']?['id'];
      final room = idMap['room'] as String?;
      final isVideoCall = idMap['isVideoCall'] as bool? ?? false;
      print("isVideoCall4: ${isVideoCall}");
      final callerData = idMap['callerData'] as Map<String, dynamic>?;
      final firstName = callerData?['firstName'] as String? ?? '';
      final lastName = callerData?['lastName'] as String? ?? '';
      final fullName =
          (firstName + ' ' + lastName).trim().isEmpty
              ? 'Caller'
              : '$firstName $lastName';

      if (chatId == null || room == null) return null;

      return _IncomingCall(
        chatId: chatId.toString(),
        room: room,
        callerName: fullName,
        isVideoCall: isVideoCall,
      );
    } catch (e) {
      log('parse incoming call error: $e');
      return null;
    }
  }

  void joinCallFromCallKit({
    required String roomName,
    required String participantName,
    required String chatId,
    required bool isVideocall,
  }) {
    print("context not null praying");
    final context = navigatorKey.currentContext;
    if (context == null) return;
    print("context not null praying: $context");

    if (context == null) {
      _ref.read(pendingRouteProvider.notifier).state = PendingRoute(
        path: '/call-screen',
        // callData: {
        //   'roomName': roomName,
        //   'participantName': participantName,
        //   'chatId': chatId,
        //   'isVideoCall': isVideocall,
        // },
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => CallScreen(
              roomName: roomName,
              participantName: participantName,
              isVideoCall: isVideocall,
              chatId: chatId,
            ),
      ),
    );
  }
}

class _IncomingCall {
  final String chatId;
  final String room;
  final String callerName;
  final bool isVideoCall;

  _IncomingCall({
    required this.chatId,
    required this.room,
    required this.callerName,
    required this.isVideoCall,
  });
}

// Background bridge usable from top-level background handler
class FCMBackgroundBridge {
  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    try {
      // Show CallKit incoming for incoming call messages
      if (_isIncomingCallMessage(message)) {
        final call = _parseIncomingCall(message);
        if (call != null) {
          await _showCallKitIncoming(call);
        }
        return;
      }

      // End call case
      if (message.notification?.title == 'Call Ended' ||
          message.notification?.body?.toLowerCase().contains('call ended') ==
              true ||
          message.data['code'] == '6' ||
          message.data['code'] == 6) {
        try {
          await FlutterCallkitIncoming.endAllCalls();
        } catch (_) {}
      }
    } catch (e, st) {
      log('FCMBackgroundBridge error: $e\n$st');
    }
  }

  static bool _isIncomingCallMessage(RemoteMessage message) {
    if (message.data['code'] == '5' || message.data['code'] == 5) return true;
    final code = message.data['code'];
    return code == 'CALL_INCOMING' || code == 1 || code == '1';
  }

  static _IncomingCall? _parseIncomingCall(RemoteMessage message) {
    try {
      final idJsonString = message.data['id'];
      Map<String, dynamic>? idMap;
      if (idJsonString is String) {
        idMap = json.decode(idJsonString) as Map<String, dynamic>;
      } else if (idJsonString is Map<String, dynamic>) {
        idMap = idJsonString;
      } else {
        idMap = {};
      }

      final chatId = idMap['chatId'] ?? idMap['chat']?['id'];
      final room = idMap['room'] as String?;
      final callerData = idMap['callerData'] as Map<String, dynamic>?;
      final isVideoCall = idMap['isVideoCall'] as bool? ?? false;
      print("isVideoCall5: ${isVideoCall}");
      final firstName = callerData?['firstName'] as String? ?? '';
      final lastName = callerData?['lastName'] as String? ?? '';
      final fullName =
          (firstName + ' ' + lastName).trim().isEmpty
              ? 'Caller'
              : '$firstName $lastName';

      if (chatId == null || room == null) return null;

      return _IncomingCall(
        chatId: chatId.toString(),
        room: room,
        callerName: fullName,
        isVideoCall: isVideoCall,
      );
    } catch (e) {
      log('parse incoming call error (bg): $e');
      return null;
    }
  }

  static Future<void> _showCallKitIncoming(_IncomingCall call) async {
    final uuid = const Uuid().v4();
    final params = CallKitParams(
      id: uuid,
      nameCaller: call.callerName,
      appName: 'Navicare',
      handle: call.callerName,
      type: 0, // set 1 if you want to mark as video capable
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Reject',
      extra: {
        'chatId': call.chatId,
        'room': call.room,
        'callerName': call.callerName,
        'isVideoCall': call.isVideoCall,
      },
      android: const AndroidParams(
        // isCustomNotification: true,
        isShowLogo: false,
        actionColor: '#4CAF50',
        // incomingCallNotificationChannelName: 'Incoming Calls',
        // missedCallNotificationChannelName: 'Missed Calls',
        ringtonePath: 'ringtone',
      ),
      ios: const IOSParams(handleType: 'generic', supportsVideo: true),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
