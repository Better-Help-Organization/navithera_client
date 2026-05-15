import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navithera_client/core/localization/providers/locale_provider.dart';
import 'package:navithera_client/core/notification/notification_service.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/security/rootdetection.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart'
    hide secureStorageProvider;
import 'package:navithera_client/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navithera_client/firebase_options.dart';
import 'package:navithera_client/l10n/l10n.dart';
import 'package:overlay_support/overlay_support.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import "package:navithera_client/core/localization/fallback_localization.dart";
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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

// ─── FRIDA DETECTION ────────────────────────────────────────────────────────
Future<bool> _isFridaDetected() async {
  // Check 1: Frida default server port 27042
  try {
    final socket = await Socket.connect(
      '127.0.0.1',
      27042,
      timeout: const Duration(milliseconds: 300),
    );
    socket.destroy();
    log('Frida detected: port 27042 open');
    return true;
  } catch (_) {}

  // Check 2: Frida server binary on disk
  try {
    final file = File('/data/local/tmp/frida-server');
    if (await file.exists()) {
      log('Frida detected: frida-server file found');
      return true;
    }
  } catch (_) {}

  // Check 3: Frida gadget or agent in process memory maps
  try {
    final mapsFile = File('/proc/self/maps');
    if (await mapsFile.exists()) {
      final content = await mapsFile.readAsString();
      if (content.contains('frida') || content.contains('gadget')) {
        log('Frida detected: found in /proc/self/maps');
        return true;
      }
    }
  } catch (_) {}

  // Check 4: Alternative Frida port 27043
  try {
    final socket = await Socket.connect(
      '127.0.0.1',
      27043,
      timeout: const Duration(milliseconds: 300),
    );
    socket.destroy();
    log('Frida detected: port 27043 open');
    return true;
  } catch (_) {}

  return false;
}
// ────────────────────────────────────────────────────────────────────────────

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

    // ─── SECURITY CHECKS ──────────────────────────────────────────────────
    bool isRooted = await FlutterJailbreakDetection.jailbroken;
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    bool fridaDetected = await _isFridaDetected();

    if (isRooted || developerMode || fridaDetected) {
      runApp(Rootdetection());
      return;
    }
    // ──────────────────────────────────────────────────────────────────────

    runApp(
      ProviderScope(
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

      final eventMap = _asMap(callEvent);

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

      final body = _asMap(eventMap['body'] ?? (callEvent as dynamic).body);

      Map<String, dynamic> extra = _asMap(body['extra']);
      if (extra.isEmpty) {
        extra = {...body, ..._asMap(body['android']), ..._asMap(body['ios'])};
      }

      final idMap = _asMap(eventMap['id']);
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
      authState.whenOrNull(
        authenticated: (user) async {
          await ref.read(chatProvider.notifier).getChatThreads(silent: true);
          try {
            final socketService = ref.read(socketServiceProvider);
            await socketService.connect();
            print("Socket connected after login");
          } catch (e) {
            print("Socket connection error: $e");
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
          return null;
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
            brightness: Brightness.light,
          ),
          fontFamily: 'PlusJakartaSans',
        ),
        supportedLocales: L10n.all,
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