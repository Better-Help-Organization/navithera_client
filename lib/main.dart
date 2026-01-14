import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/localization/providers/locale_provider.dart';
import 'package:navithera_client/core/notification/notification_service.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navithera_client/firebase_options.dart';
import 'package:navithera_client/l10n/l10n.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import "package:navithera_client/core/localization/fallback_localization.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase if not already done
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  try {
    await FCMBackgroundBridge.handleBackgroundMessage(message);
  } catch (e, st) {
    log('Background handler error: $e\n$st');
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (Firebase.apps.isEmpty) {
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } on FirebaseException catch (e) {
        if (e.code == 'duplicate-app') {
          log('Firebase already initialized: ${e.message}');
        } else {
          rethrow;
        }
      }
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final sharedPreferences = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: MyApp(),
      ),
    );
  } catch (e, st) {
    log('Main initialization error: $e\n$st');
    rethrow;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    try {
      // Initialize FCM - COMMENTED OUT FOR NOW
      final fcmService = ref.read(fcmServiceProvider);
      fcmService.initialize();
      if (kIsWeb) {
        fcmService.initFCMWeb();
      }

      _listenCallKitActions();
    } catch (e, st) {
      log('initState error: $e\n$st');
    }
  }

  Map<String, dynamic> _asMap(dynamic v) {
    if (v == null) return <String, dynamic>{};
    if (v is Map) {
      return v.map((k, val) => MapEntry(k.toString(), val));
    }
    if (v is String) {
      try {
        final decoded = jsonDecode(v);
        if (decoded is Map) {
          return decoded.map((k, val) => MapEntry(k.toString(), val));
        }
      } catch (_) {}
    }
    // Try toJson on objects coming from plugin models
    try {
      final toJson = (v as dynamic).toJson();
      if (toJson is Map) {
        return toJson.map((k, val) => MapEntry(k.toString(), val));
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  void _listenCallKitActions() {
    FlutterCallkitIncoming.onEvent.listen((callEvent) async {
      if (callEvent == null) return;

      // --- normalize the event ---
      final eventMap = _asMap(callEvent);

      // --- event type ---
      String? type =
          (() {
            final m = eventMap;
            String? t =
                (m['event'] ??
                        m['name'] ??
                        m['action'] ??
                        (m['type'] is String ? m['type'] : null))
                    ?.toString();

            if (t == null) {
              final ev = _asMap(m['event']);
              t = ev['name']?.toString() ?? ev['type']?.toString();
            }
            if (t == null) {
              try {
                t = (callEvent as dynamic).event?.toString();
              } catch (_) {}
            }
            return t;
          })();

      // --- body ---
      final body = _asMap(eventMap['body'] ?? (callEvent as dynamic).body);

      // --- extra ---
      Map<String, dynamic> extra = _asMap(body['extra']);
      if (extra.isEmpty) {
        extra = {...body, ..._asMap(body['android']), ..._asMap(body['ios'])};
      }

      // --- idMap from event (FCM payload style) ---
      final idMap = _asMap(eventMap['id']);
      // Merge any missing pieces into extra
      extra.addAll({
        if (!extra.containsKey('chatId') && idMap['chatId'] != null)
          'chatId': idMap['chatId'],
        if (!extra.containsKey('room') && idMap['room'] != null)
          'room': idMap['room'],
        if (!extra.containsKey('callerName') && idMap['callerName'] != null)
          'callerName': idMap['callerName'],
        if (!extra.containsKey('isVideoCall') && idMap['isVideoCall'] != null)
          'isVideoCall': idMap['isVideoCall'],
        if (!extra.containsKey('isGroupCall') && idMap['isGroupCall'] != null)
          'isGroupCall': idMap['isGroupCall'],
        if (!extra.containsKey('token') && idMap['token'] != null)
          'token': idMap['token'],
      });

      // --- Extract variables ---
      final String? chatId =
          (extra['chatId'] ?? idMap['chatId'] ?? body['chatId'])?.toString();
      final String? roomName =
          (extra['room'] ?? idMap['room'] ?? body['room'])?.toString();
      final bool isVideoCall =
          (extra['isVideoCall'] ??
              idMap['isVideoCall'] ??
              body['isVideoCall'] ??
              false) ==
          true;
      final bool isGroupCall =
          (extra['isGroupCall'] ??
              idMap['isGroupCall'] ??
              body['isGroupCall'] ??
              false) ==
          true;
      final String? token =
          (extra['token'] ?? idMap['token'] ?? body['token'])?.toString();

      String? callerName =
          (extra['callerName'] ??
                  body['callerName'] ??
                  body['nameCaller'] ??
                  extra['nameCaller'] ??
                  body['name'] ??
                  extra['name'])
              ?.toString();

      callerName ??= 'Caller';
      final context = navigatorKey.currentContext;
      // if (context == null) return;

      switch (type) {
        case 'Event.actionCallAccept':
        case 'ACTION_CALL_ACCEPT':
        case 'actionCallAccept':
          if (roomName != null &&
              chatId != null &&
              isVideoCall != null &&
              isGroupCall != null &&
              token != null) {
            if (context != null) {
              // App is in foreground/background - navigate directly
              ref
                  .read(fcmServiceProvider)
                  .joinCallFromCallKit(
                    roomName: roomName,
                    participantName: callerName,
                    chatId: chatId,
                    isVideocall: isVideoCall,
                    isGroupCall: isGroupCall,
                    token: token,
                  );
            } else {
              // App was terminated - set pending route
              ref.read(pendingRouteProvider.notifier).state = PendingRoute(
                path: '/call-screen',
              );
            }
          } else {
            debugPrint('Missing room/chatId on accept; cannot join');
          }
          break;

        case 'Event.actionCallDecline':
        case 'Event.actionCallEnded':
        case 'ACTION_CALL_DECLINE':
        case 'ACTION_CALL_ENDED':
          if (chatId != null) {
            await ref.read(fcmServiceProvider).rejectCall(chatId);
          }
          break;

        default:
          break;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final authState = ref.read(authProvider);
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - mark messages as read and check for new ones
      authState.whenOrNull(
        authenticated: (user) async {
          await ref.read(chatProvider.notifier).getChatThreads(silent: true);
          // ref.read(socketServiceProvider).connect();
          try {
            final socketService = ref.read(socketServiceProvider);
            await socketService.connect();
            print("Socket connected after login");
          } catch (e) {
            print("Socket connection error: $e");
            // Don't block navigation if socket fails
          }
          return null;
        },
      );
    } else if (state == AppLifecycleState.hidden) {
      authState.whenOrNull(
        authenticated: (user) async {
          print("disconnected!!!!!!");
          final socketService = ref.read(socketServiceProvider);
          socketService.disconnect();
          // await ref.read(chatProvider.notifier).getChatThreads(silent: true);
          // ref.read(socketServiceProvider).connect();
          return null;
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //_messageController.dispose();
    //_scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return OverlaySupport.global(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Navicare',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light, // or dark
          ),
          fontFamily: 'PlusJakartaSans',
        ),
        supportedLocales: L10n.all,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          FallbackMaterialLocalizationsDelegate(),
          FallbackWidgetsLocalizationsDelegate(),
          FallbackCupertinoLocalizationsDelegate(),
        ],
        locale: locale,
      ),
    );
  }
}
