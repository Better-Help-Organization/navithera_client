import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/notification/session_selection_service.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navithera_client/feature/home/data/models/upcoming_session_models.dart';
import 'package:navithera_client/feature/home/presentation/providers/matched_therapist_provider.dart';
import 'package:navithera_client/feature/home/presentation/providers/upcoming_session_provider.dart';
import 'package:navithera_client/feature/notification/presentation/pages/notification_screen.dart';
import 'package:navithera_client/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navithera_client/core/theme/app_typography.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/core/util/greeting.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

final notificationCountProvider =
    StateNotifierProvider<NotificationCountNotifier, int>((ref) {
      return NotificationCountNotifier();
    });

class NotificationCountNotifier extends StateNotifier<int> {
  NotificationCountNotifier() : super(0);

  void setCount(int count) => state = count;
  void reset() => state = 0;
  void increment() => state = state + 1;
  void decrement() => state = state > 0 ? state - 1 : 0;
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final Dio _dio = Dio();

  NotificationService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<int?> fetchUnreadCount() async {
    try {
      await _attachAuthHeader();

      final response = await _dio.get(
        '${base_url_dev}/client/me/notifications',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data.containsKey('unreadCount')) {
          return data['unreadCount'] as int;
        }
      }
      return 0;
    } catch (e) {
      log("Error fetching unread count: $e");
      return 0;
    }
  }
}

class HomeRefreshNotifier extends StateNotifier<int> {
  HomeRefreshNotifier() : super(0);
  void refresh() => state++;
}

class Quote {
  final String content;
  final String author;

  Quote({required this.content, required this.author});
}

// Create a provider for the mood service
final moodServiceProvider = Provider<MoodService>((ref) {
  return MoodService();
});

final therapistMatchServiceProvider = Provider<TherapistMatchService>((ref) {
  return TherapistMatchService();
});

final ratingServiceProvider = Provider<RatingService>((ref) {
  return RatingService();
});

final quoteServiceProvider = Provider<QuoteService>((ref) {
  return QuoteService();
});

// Add this provider near your other service providers
final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService();
});

class SessionService {
  final Dio _dio = Dio();

  SessionService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Map<String, dynamic>?> fetchSessions() async {
    try {
      await _attachAuthHeader();

      DateTime now = DateTime.now();
      print("now: ${now}");

      final response = await _dio.get(
        '${base_url_dev}/client/me/sessions?filters=schedule>${now},hasTherapistAttended=0,approvalStatus=confirmed&sort=schedule=asc',
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      log("Error fetching sessions: $e");
      return null;
    }
  }
}

// class QuoteService {
//   final Dio _dio = Dio();

//   QuoteService() {
//     _dio.options.connectTimeout = const Duration(seconds: 20);
//     _dio.options.receiveTimeout = const Duration(seconds: 20);
//   }

//   Future<void> _attachAuthHeader() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final accessToken = sharedPreferences.getString('access_token');
//     if (accessToken != null && accessToken.isNotEmpty) {
//       _dio.options.headers['Authorization'] = 'Bearer $accessToken';
//     } else {
//       _dio.options.headers.remove('Authorization');
//     }
//   }

//   Future<Quote?> fetchQuote() async {
//     try {
//       await _attachAuthHeader();
//       final response = await _dio.get(
//         '${base_url_dev}/quote?sort=createdAt=desc',
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map && data['data'] is List && data['data'].isNotEmpty) {
//           final firstQuote = data['data'][0];

//           final content = firstQuote['content'] as String?;
//           final author = firstQuote['author'] as String?;

//           if (content != null && author != null) {
//             return Quote(content: content.trim(), author: author.trim());
//           }
//         }
//       }
//       return null;
//     } catch (e) {
//       log("Error fetching quote: $e");
//       return null;
//     }
//   }

//   Future<List<Quote>> fetchQuotes({int take = 10}) async {
//     try {
//       await _attachAuthHeader();
//       final response = await _dio.get(
//         '${base_url_dev}/quote?sort=createdAt=desc&take=$take',
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map && data['data'] is List) {
//           final List<Quote> quotes = [];
//           for (final quoteData in (data['data'] as List)) {
//             final content = quoteData['content'] as String?;
//             final author = quoteData['author'] as String?;

//             if (content != null && author != null) {
//               quotes.add(Quote(content: content.trim(), author: author.trim()));
//             }
//           }
//           return quotes;
//         }
//       }
//       return [];
//     } catch (e) {
//       log("Error fetching quotes: $e");
//       return [];
//     }
//   }
// }

class QuoteService {
  final Dio _dio = Dio();

  QuoteService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Quote?> fetchQuote() async {
    try {
      await _attachAuthHeader();
      final response = await _dio.get('${base_url_dev}/quote/daily');

      print("response: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data['data'] != null) {
          final quoteData = data['data'];

          final content = quoteData['content'] as String?;
          final author = quoteData['author'] as String?;

          print("Quote content: $content");
          print("Quote author: $author");

          if (content != null && author != null) {
            return Quote(content: content.trim(), author: author.trim());
          }
        }
      }
      return null;
    } catch (e) {
      log("Error fetching quote: $e");
      return null;
    }
  }

  // Remove the fetchQuotes method since you don't need multiple quotes anymore
  // Future<List<Quote>> fetchQuotes({int take = 10}) async { ... }
}

class RatingService {
  final Dio _dio = Dio();

  RatingService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<int> submitRating({
    required String therapistId,
    required int value,
    String comment = '',
  }) async {
    try {
      await _attachAuthHeader();

      final response = await _dio.post(
        '${base_url_dev}/ratings',
        data: {'therapistId': therapistId, 'value': value, 'comment': comment},
      );

      return response.statusCode ?? 500;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        return statusCode ?? 500;
      }
      return 500;
    } catch (e) {
      return 500;
    }
  }
}

class MoodService {
  final Dio _dio = Dio();

  MoodService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<bool> submitMood(String mood) async {
    try {
      await _attachAuthHeader();

      final response = await _dio.post(
        '${base_url_dev}/mood',
        data: {'mood': mood},
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> fetchMoodForDate(DateTime dateUtc) async {
    try {
      await _attachAuthHeader();

      final dateLocal = dateUtc.toLocal();
      final targetDateLocal = DateTime(
        dateLocal.year,
        dateLocal.month,
        dateLocal.day,
      );

      final response = await _dio.get(
        '${base_url_dev}/client/me/moods',
        queryParameters: {
          'fields': 'date, mood',
          'sort': 'date=desc',
          'take': 10,
          'page': 1,
          'pageSize': 10,
        },
      );

      print("xoxoresponse: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map &&
            data['data'] is List &&
            (data['data'] as List).isNotEmpty) {
          for (final item in (data['data'] as List)) {
            final moodDate = item['date'] as String?;
            final mood = item['mood'] as String?;

            print("helllllllo: ${moodDate}");

            if (moodDate != null) {
              try {
                final apiDate = DateTime.parse(moodDate).toLocal();
                final apiDateLocal = DateTime(
                  apiDate.year,
                  apiDate.month,
                  apiDate.day,
                );

                if (apiDateLocal == targetDateLocal) {
                  log("Found today's mood: $mood");
                  return mood;
                }
              } catch (e) {
                log("Error parsing date: $e");
              }
            }
          }
        }
      }
      return null;
    } catch (e) {
      print("xoxoresponse: ${e}");
      log("Error fetching mood: $e");
      return null;
    }
  }
}

class TherapistMatchService {
  final Dio _dio = Dio();

  TherapistMatchService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSubmitting = false;
  String? _lastSubmittedMood;
  bool _isLoadingTodayMood = true;
  String? _todayMood;
  bool _isLoadingQuote = false;
  String? _quote;
  String _quoteAuthor = "Today's Quote";

  // New state for multiple quotes
  List<Quote> _quotes = [];
  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;

  @override
  void initState() {
    super.initState();
    _loadTodayMood();
    //_loadQuotes();
    _loadQuote();
    _setupMessageReadListener();
    _loadUnreadCount();

    // Load initial data using providers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(upcomingSessionProvider.notifier).loadNext();
      ref.read(matchedTherapistProvider.notifier).load();
    });
  }

  Future<void> _loadUnreadCount() async {
    final notificationService = ref.read(notificationServiceProvider);
    final unreadCount = await notificationService.fetchUnreadCount();

    if (mounted) {
      ref.read(notificationCountProvider.notifier).setCount(unreadCount ?? 0);
    }
  }

  Future<void> _loadUser() async {
    await ref.read(authProvider.notifier).getCurrentUser();
    ref.read(upcomingSessionProvider.notifier).loadNext();
    ref.read(matchedTherapistProvider.notifier).load();
  }

  void _setupMessageReadListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("foreground message here: ${message.data}");
      print("Foreground notification received: ${message.notification?.title}");

      if (message.notification?.title == 'Match accepted') {
        // Refresh therapist when match accepted notification comes
        ref.read(matchedTherapistProvider.notifier).load();
      }

      if ((message.data['code'] == '1' || message.data['code'] == 1)) {
        // Refresh sessions when session notification comes
        ref.read(upcomingSessionProvider.notifier).loadNext();
      }
    });
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    super.dispose();
  }

  // Future<void> _loadQuotes() async {
  //   setState(() {
  //     _isLoadingQuote = true;
  //   });

  //   final quoteService = ref.read(quoteServiceProvider);
  //   final quotes = await quoteService.fetchQuotes(take: 10);

  //   setState(() {
  //     _quotes = quotes;
  //     if (_quotes.isNotEmpty) {
  //       _quote = _quotes.first.content;
  //       _quoteAuthor = _quotes.first.author;
  //       _startQuoteTimer();
  //     } else {
  //       _quote = null;
  //       _quoteAuthor = "Today's Quote";
  //     }
  //     _isLoadingQuote = false;
  //   });
  // }

  Future<void> _loadQuote() async {
    // Renamed from _loadQuotes
    setState(() {
      _isLoadingQuote = true;
    });

    final quoteService = ref.read(quoteServiceProvider);
    final quote = await quoteService.fetchQuote(); // Now fetches single quote

    setState(() {
      if (quote != null) {
        _quote = quote.content;
        _quoteAuthor = quote.author;
      } else {
        _quote = null;
        _quoteAuthor = "Today's Quote";
      }
      _isLoadingQuote = false;
    });
  }

  void _startQuoteTimer() {
    _quoteTimer?.cancel();

    if (_quotes.length <= 1) return;

    _quoteTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
          _quote = _quotes[_currentQuoteIndex].content;
          _quoteAuthor = _quotes[_currentQuoteIndex].author;
        });
      }
    });
  }

  // Future<void> _loadSessions() async {
  //   setState(() {
  //     _isLoadingSessions = true;
  //   });

  //   final sessionService = ref.read(sessionServiceProvider);
  //   final sessionsData = await sessionService.fetchSessions();

  //   if (mounted) {
  //     setState(() {
  //       _sessionsData = sessionsData;
  //       _isLoadingSessions = false;

  //       if (sessionsData != null &&
  //           sessionsData['data'] is List &&
  //           (sessionsData['data'] as List).isNotEmpty) {
  //         final firstSession = (sessionsData['data'] as List)[0];
  //         final scheduleString = firstSession['schedule'] as String?;
  //         if (scheduleString != null) {
  //           try {
  //             _nextSessionDate = DateTime.parse(scheduleString);
  //           } catch (e) {
  //             log("Error parsing session date: $e");
  //             _nextSessionDate = null;
  //           }
  //         }
  //       }
  //     });
  //   }
  // }

  Future<void> _loadTodayMood() async {
    setState(() {
      _isLoadingTodayMood = true;
    });

    final moodService = ref.read(moodServiceProvider);
    final todayUtc = DateTime.now().toUtc();
    final mood = await moodService.fetchMoodForDate(todayUtc);

    setState(() {
      _todayMood = mood;
      _lastSubmittedMood = mood;
      _isLoadingTodayMood = false;
    });
  }

  // Future<void> _loadTherapist() async {
  //   print("Bearer 5");
  //   setState(() {
  //     _isLoadingTherapist = true;
  //     _therapistError = null;
  //   });

  //   try {
  //     final user = ref.read(currentUserProvider);
  //     final service = ref.read(therapistMatchServiceProvider);

  //     if (user?.id == null) {
  //       setState(() {
  //         _isLoadingTherapist = false;
  //         _therapistError = 'client error';
  //       });
  //       return;
  //     }

  //     print("Loading therapist data for client: ${user!.id}");

  //     final therapist = await service.fetchLatestAcceptedTherapist(
  //       clientId: user.id,
  //     );

  //     if (!mounted) return;

  //     setState(() {
  //       _therapist = therapist;
  //       _isLoadingTherapist = false;
  //       if (therapist == null) {
  //         _therapistError = 'No therapist matched yet';
  //         print("No therapist found for client");
  //       } else {
  //         print(
  //           "Therapist loaded successfully: ${therapist.firstName} ${therapist.lastName}",
  //         );
  //       }
  //     });
  //   } catch (e) {
  //     print('Error loading therapist: $e');
  //     if (!mounted) return;

  //     setState(() {
  //       _isLoadingTherapist = false;
  //       _therapistError = 'Failed to load therapist data';
  //     });
  //   }
  // }

  Future<void> _refreshAll() async {
    await Future.wait([
      _loadTodayMood(),
      _loadQuote(),
      _loadUnreadCount(),
      _loadUser(),
    ]);

    // Refresh providers
    ref.read(upcomingSessionProvider.notifier).loadNext();
    ref.read(matchedTherapistProvider.notifier).load();
  }

  String formatSessionDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, MMMM d \'at\' HH:mm');
    return formatter.format(date.toLocal());
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Mood submission failed"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshAll();
    }
  }

  void _handleNotification(String messageJson) {
    try {
      final messageData = jsonDecode(messageJson);
      final remoteMessage = RemoteMessage(
        data: messageData is Map<String, dynamic> ? messageData : {},
        notification: RemoteNotification(
          title: messageData['title']?.toString(),
          body: messageData['body']?.toString(),
        ),
      );

      _handleSessionSelectionNotification(remoteMessage);
      // Refresh sessions after handling notification
      ref.read(upcomingSessionProvider.notifier).loadNext();
    } catch (e) {
      print('Failed to parse notification message: $e');
    }
  }

  void _handleSessionSelectionNotification(RemoteMessage message) {
    try {
      final data = message.data;
      print("xoxoxo: ${data}");

      if (data['sessionIds'] != null) {
        List<String> sessionIds = [];

        if (data['sessionIds'] is String) {
          final idMap = json.decode(data['sessionIds']) as Map<String, dynamic>;
          sessionIds = List<String>.from(idMap['sessionIds'] ?? []);
        } else if (data['sessionIds'] is List) {
          sessionIds = List<String>.from(data['sessionIds']);
        }

        final context = navigatorKey.currentContext;

        if (context != null && sessionIds.isNotEmpty) {
          final service = ref.read(sessionSelectionServiceProvider);
          service.showSessionSelectionDialog(
            context: context,
            sessionIds: sessionIds,
          );
        }
      }
    } catch (e) {
      print('Error handling session selection notification: $e');
    }
  }

  Widget _buildNotificationIcon() {
    final unreadCount = ref.watch(notificationCountProvider);

    return GestureDetector(
      onTap: () {
        ref.read(notificationCountProvider.notifier).reset();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationScreen()),
        );
      },
      child: Stack(
        children: [
          const Icon(Icons.notifications_outlined, size: 24),
          if (unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final moodService = ref.read(moodServiceProvider);
    final sessionState = ref.watch(upcomingSessionProvider);
    final therapistState = ref.watch(matchedTherapistProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshAll,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with profile and notifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child:
                                (user?.avatar == 7) &&
                                        (user?.profile != null &&
                                            user!.profile!.isNotEmpty)
                                    ? Image(
                                      image: NetworkImage(
                                        '${base_url_for_image}${user.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
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
                                            getAvatarImage(user.avatar ?? 0),
                                          ),
                                          width: 50,
                                          height: 50,
                                        );
                                      },
                                    )
                                    : Image(
                                      image: AssetImage(
                                        getAvatarImage(user?.avatar ?? 0),
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTimeBasedGreeting(context),
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user?.firstName ?? "",
                                    style: AppTypography.heading2,
                                  ),
                                  const SizedBox(width: 4),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              try {
                                if (mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => SessionCalendarScreen(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Failed to open calendar'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Icon(
                              Icons.calendar_month_outlined,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildNotificationIcon(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mood section
                  if (_isLoadingTodayMood) ...[
                    Text(
                      AppLocalizations.of(context)!.howAreYouFeeling,
                      style: AppTypography.heading1,
                    ),
                    const SizedBox(height: 12),
                    const _MoodSkeleton(),
                    const SizedBox(height: 12),
                  ],

                  if (!_isLoadingTodayMood && _todayMood == null) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildMoodOption(
                            moodService,
                            AppLocalizations.of(context)!.happy,
                            '😊',
                            'happy',
                          ),
                          _buildMoodOption(
                            moodService,
                            AppLocalizations.of(context)!.neutral,
                            '😐',
                            'neutral',
                          ),
                          _buildMoodOption(
                            moodService,
                            AppLocalizations.of(context)!.sad,
                            '😔',
                            'sad',
                          ),
                          _buildMoodOption(
                            moodService,
                            AppLocalizations.of(context)!.tired,
                            '😒',
                            'tired',
                          ),
                          _buildMoodOption(
                            moodService,
                            AppLocalizations.of(context)!.angry,
                            '🤬',
                            'angry',
                          ),
                        ],
                      ),
                    ),
                    if (_isSubmitting) ...[
                      const SizedBox(height: 12),
                      const _InlineSubmitSkeleton(),
                    ],
                  ],

                  if (_lastSubmittedMood != null && _todayMood == null) ...[
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        "Mood Submitted: $_lastSubmittedMood",
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Notification banner
                  if (user?.hasNotification != null)
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(top: 8, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.red.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade100.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Action Needed',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Please select a time to continue.',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              _handleNotification(
                                user?.hasNotification?.message ?? "",
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(Icons.calendar_month, size: 18),
                            label: const Text('Select'),
                          ),
                        ],
                      ),
                    ),

                  // Quote Card
                  // Container(
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       if (_isLoadingQuote)
                  //         const _QuoteSkeleton()
                  //       else if (_quote != null)
                  //         Text(
                  //           '"$_quote"',
                  //           style: AppTypography.quote.copyWith(
                  //             color: Colors.white,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         )
                  //       else
                  //         Text(
                  //           '"${AppLocalizations.of(context)!.selfEsteemQuote}"',
                  //           style: AppTypography.quote.copyWith(
                  //             color: Colors.white,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       const SizedBox(height: 12),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             '- $_quoteAuthor',
                  //             style: AppTypography.bodySmall.copyWith(
                  //               color: Colors.white70,
                  //             ),
                  //           ),
                  //           TextButton.icon(
                  //             onPressed: () {},
                  //             icon: const Icon(
                  //               Icons.share,
                  //               color: Colors.white,
                  //               size: 14,
                  //             ),
                  //             label: Text(
                  //               AppLocalizations.of(context)!.share,
                  //               style: AppTypography.buttonText.copyWith(
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Quote Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        if (_isLoadingQuote)
                          const _QuoteSkeleton()
                        else if (_quote != null)
                          GestureDetector(
                            onTap: () {
                              // Reload quote on tap
                              //_loadQuote();
                              // just testing
                              void openWebApp(String url) async {
                                final Uri uri = Uri.parse(url);

                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode:
                                        LaunchMode
                                            .externalApplication, // Opens in external browser
                                  );
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }

                              openWebApp(
                                'https://developerportal.ethiotelebirr.et:38443/payment/web/paygate?appid=1511910021811206&merch_code=841050&nonce_str=L9JLJU73WJVR7AR97RGEXH80HVVT9XUQ&prepay_id=018e80d2a89a74997bd5c54ae2da2a4af85002&timestamp=1761205113&sign=TMNx9mXqbHolipmoDX7LI2XBybOIjXJhEEGnZU8FX+TMimdtuL5T2e+c7E8DSsiK6M6NJEsSWU7m9xeJiQMH8WURKQNFG2KV/tfa9ckVSXBiU0iYkXRRFzN9zUppDe1y0G0z/kprEqGUwE6ehzuqNt1oV38zLKVUy0oHPh4GEMctwkehaZqJeMCGumTcmeA/I38dDd+DHlbBuWL09/3lOV+8nuSgiFaJ5u/I/tprES4lHwTjeHWIXP6T8Pn4v1tR/VM7lgTuxug+53J7EFy8HLPuuK+iDV8APfk4rbZ/uPDNYWyn8HE1GWT8dEqFwG6rzm5+TI8JaPxeJdoKKXEmZw==&sign_type=SHA256WithRSA&version=1.0&trade_type=Checkout',
                              );
                            },
                            child: Text(
                              '"$_quote"',
                              style: AppTypography.quote.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        else
                          Text(
                            '"${AppLocalizations.of(context)!.selfEsteemQuote}"',
                            style: AppTypography.quote.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '- $_quoteAuthor',
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 14,
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.share,
                                style: AppTypography.buttonText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Therapist & Session Section using providers
                  _buildTherapistAndSessionSection(
                    therapistState,
                    sessionState,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTherapistAndSessionSection(
    MatchedTherapistState therapistState,
    UpcomingSessionState sessionState,
    BuildContext context,
  ) {
    return Column(
      children: [
        // Therapist Section
        _buildTherapistSection(therapistState, context),

        const SizedBox(height: 12),

        // Session Section
        _buildSessionSection(sessionState),
      ],
    );
  }

  Widget _buildTherapistSection(
    MatchedTherapistState therapistState,
    BuildContext context,
  ) {
    return switch (therapistState) {
      MatchedTherapistInitial() => const _TherapistCardSkeleton(),
      MatchedTherapistLoading() => const _TherapistCardSkeleton(),
      MatchedTherapistError(:final failure) => _InfoBanner(
        icon: Icons.error_outline,
        text: failure.message,
        color: Colors.red,
      ),
      MatchedTherapistLoaded(:final therapist) =>
        therapist == null
            ? _InfoBanner(
              icon: Icons.info_outline,
              text: 'No therapist matched yet',
              color: Colors.blue,
            )
            : TherapistCard(
              therapist: therapist,
              onDetailsTap: () {
                final router = GoRouter.of(context);
                router.push('/therapist-profile', extra: therapist);
              },
              onMessageTap: () {},
              onRateTap: () {
                final ratingService = ref.read(ratingServiceProvider);
                _showRatingDialog(context, therapist, ratingService);
              },
            ),
      // TODO: Handle this case.
      MatchedTherapistState() => throw UnimplementedError(),
    };
  }

  Widget _buildSessionSection(UpcomingSessionState sessionState) {
    return switch (sessionState) {
      UpcomingSessionInitial() => const _SessionSkeleton(),
      UpcomingSessionLoading() => const _SessionSkeleton(),
      UpcomingSessionError(:final failure) => _InfoBanner(
        icon: Icons.error_outline,
        text: failure.message,
        color: Colors.red,
      ),
      UpcomingSessionLoaded(:final nextSession) =>
        nextSession == null
            ? Container() // No upcoming session
            : _buildSessionCard(nextSession),
      // TODO: Handle this case.
      UpcomingSessionState() => throw UnimplementedError(),
    };
  }

  Widget _buildSessionCard(SessionItem nextSession) {
    final sessionDateText = formatSessionDate(nextSession.schedule);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Upcoming Session: $sessionDateText',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // class _SessionSkeleton extends StatelessWidget {
  //   const _SessionSkeleton();

  //   @override
  //   Widget build(BuildContext context) {
  //     return Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: Colors.grey.shade50,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Row(
  //         children: const [
  //           _ShimmerBlock(width: 20, height: 20, radius: 10),
  //           SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 _ShimmerBlock(width: 200, height: 12, radius: 6),
  //                 SizedBox(height: 8),
  //                 _ShimmerBlock(width: 150, height: 10, radius: 6),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Widget _buildTherapistSection(BuildContext context, String sessionDateText) {
  //   final ratingService = ref.read(ratingServiceProvider);

  //   if (_therapistError != null) {
  //     return _InfoBanner(
  //       icon: Icons.error_outline,
  //       text: _therapistError!,
  //       color: Colors.red,
  //     );
  //   }

  //   if (_therapist == null) {
  //     return _InfoBanner(
  //       icon: Icons.info_outline,
  //       text: 'No therapist matched yet',
  //       color: Colors.blue,
  //     );
  //   }

  //   return Column(
  //     children: [
  //       if (sessionDateText.isNotEmpty)
  //         TherapistCard(
  //           therapist: _therapist!,
  //           onDetailsTap: () {
  //             final router = GoRouter.of(context);
  //             router.push('/therapist-profile', extra: _therapist);
  //           },
  //           onMessageTap: () {},
  //           onRateTap: () {
  //             _showRatingDialog(context, _therapist!, ratingService);
  //           },
  //         ),

  //       SizedBox(height: 12),
  //       if (sessionDateText.isNotEmpty)
  //         Container(
  //           decoration: BoxDecoration(
  //             color: AppColors.primary.withOpacity(0.15),
  //             borderRadius: BorderRadius.circular(16),
  //             border: Border.all(color: Colors.grey.shade200),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.04),
  //                 blurRadius: 12,
  //                 offset: const Offset(0, 6),
  //               ),
  //             ],
  //           ),
  //           padding: const EdgeInsets.all(16),
  //           child: Row(
  //             children: [
  //               // Optional: Add an icon
  //               Icon(
  //                 Icons.calendar_today,
  //                 color: Colors.green.shade700,
  //                 size: 20,
  //               ),
  //               const SizedBox(width: 12),

  //               Expanded(
  //                 // This makes the text wrap
  //                 child: Text(
  //                   'Upcoming Session: $sessionDateText',
  //                   style: AppTypography.bodySmall.copyWith(
  //                     color: Colors.green.shade700,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                   maxLines: 2, // Limit to 2 lines
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //     ],
  //   );
  // }

  void _showRatingDialog(
    BuildContext context,
    UserModel therapist,
    RatingService ratingService,
  ) {
    int selectedRating = 0;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Rate ${therapist.firstName}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('How would you rate your experience?'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 40,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      labelText: 'Comment (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed:
                      selectedRating == 0
                          ? null
                          : () async {
                            final statusCode = await ratingService.submitRating(
                              therapistId: therapist.id,
                              value: selectedRating,
                              comment: commentController.text,
                            );

                            if (statusCode == 201) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Rating submitted successfully!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.of(context).pop();
                            } else if (statusCode == 409) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'You have already rated this therapist.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Failed to submit rating. Please try again.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildMoodOption(
    MoodService moodService,
    String text,
    String emoji,
    String moodValue,
  ) {
    final isSelected = _lastSubmittedMood == moodValue;

    return GestureDetector(
      onTap:
          _isSubmitting
              ? null
              : () async {
                setState(() {
                  _isSubmitting = true;
                });

                final success = await moodService.submitMood(moodValue);

                if (!mounted) return;

                if (success) {
                  await _loadTodayMood();
                  setState(() {
                    _lastSubmittedMood = moodValue;
                    _isSubmitting = false;
                  });
                } else {
                  setState(() {
                    _isSubmitting = false;
                  });
                  _showErrorSnackbar();
                }
              },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(emoji, style: AppTypography.bodyLarge),
            const SizedBox(width: 6),
            Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayMoodBanner extends StatelessWidget {
  final String mood;
  const _TodayMoodBanner({required this.mood});

  @override
  Widget build(BuildContext context) {
    final capitalized =
        mood.isNotEmpty ? mood[0].toUpperCase() + mood.substring(1) : mood;
    final emoji = _moodToEmoji(mood);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Text(emoji, style: AppTypography.bodyLarge),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "You've already submitted today's mood: $capitalized",
              style: AppTypography.bodySmall.copyWith(
                color: Colors.green.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _moodToEmoji(String mood) {
    switch (mood) {
      case 'happy':
        return '😊';
      case 'neutral':
        return '😐';
      case 'sad':
        return '😔';
      case 'tired':
        return '😒';
      case 'angry':
        return '🤬';
      default:
        return '🙂';
    }
  }
}

class TherapistCard extends StatelessWidget {
  final UserModel therapist;
  final VoidCallback? onMessageTap;
  final VoidCallback? onDetailsTap;
  final VoidCallback? onRateTap;

  const TherapistCard({
    super.key,
    required this.therapist,
    this.onMessageTap,
    this.onDetailsTap,
    this.onRateTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = _buildAvatar(context);
    final subtitle = _buildSubtitle();

    return GestureDetector(
      onTap: onDetailsTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.yourTherapist,
            style: AppTypography.heading2,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              //color: Colors.white,
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: imageWidget,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: onRateTap,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50.withOpacity(0.5),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.amber.shade100,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.star_rate_rounded,
                                size: 18,
                                color: Colors.amber.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "${therapist.firstName} ${therapist.lastName}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildSubtitle() {
    final parts = <String>[];
    if ((therapist.gender ?? '').isNotEmpty) {
      parts.add(
        '${therapist.gender![0].toUpperCase()}${therapist.gender!.substring(1)}',
      );
    }
    // if ((therapist.email).isNotEmpty) {
    //   parts.add(therapist.email);
    // } else if ((therapist.phoneNumber ?? '').isNotEmpty) {
    //   parts.add(therapist.phoneNumber!);
    // }
    return parts.isEmpty ? 'Your matched therapist' : parts.join(' • ');
  }

  Widget _buildAvatar(BuildContext context) {
    final hasNetwork =
        therapist.avatar == 7 &&
        (therapist.profile != null && therapist.profile!.isNotEmpty);
    if (hasNetwork) {
      return Image(
        image: NetworkImage(
          '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
        ),
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image(
            image: AssetImage(getAvatarImage(therapist.avatar ?? 0)),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image(
        image: AssetImage(getAvatarImage(therapist.avatar ?? 0)),
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      );
    }
  }
}

class _SessionSkeleton extends StatelessWidget {
  const _SessionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          _ShimmerBlock(width: 20, height: 20, radius: 10),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerBlock(width: 200, height: 12, radius: 6),
                SizedBox(height: 8),
                _ShimmerBlock(width: 150, height: 10, radius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoBanner({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _MoodSkeleton extends StatelessWidget {
  const _MoodSkeleton();

  @override
  Widget build(BuildContext context) {
    // Simulate three rounded mood chips
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (i) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _ShimmerBlock(width: 18, height: 18, radius: 9),
                const SizedBox(width: 8),
                _ShimmerBlock(width: 60 + i * 10.0, height: 10, radius: 6),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _InlineSubmitSkeleton extends StatelessWidget {
  const _InlineSubmitSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _QuoteSkeleton extends StatelessWidget {
  const _QuoteSkeleton();

  @override
  Widget build(BuildContext context) {
    // On colored (primary) background
    return Column(
      children: const [
        _ShimmerBlock(
          width: double.infinity,
          height: 12,
          radius: 8,
          colorOverride: Colors.white24,
        ),
        SizedBox(height: 8),
        _ShimmerBlock(
          width: double.infinity,
          height: 12,
          radius: 8,
          colorOverride: Colors.white24,
        ),
        SizedBox(height: 8),
        _ShimmerBlock(
          width: 180,
          height: 12,
          radius: 8,
          colorOverride: Colors.white24,
        ),
      ],
    );
  }
}

class _TherapistCardSkeleton extends StatelessWidget {
  const _TherapistCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: const [
          _ShimmerBlock(width: 70, height: 70, radius: 14),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerBlock(width: 160, height: 14, radius: 6),
                SizedBox(height: 8),
                _ShimmerBlock(width: double.infinity, height: 10, radius: 6),
                SizedBox(height: 6),
                _ShimmerBlock(width: 140, height: 10, radius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBlock extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final Color? colorOverride;

  const _ShimmerBlock({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    this.colorOverride,
  });

  @override
  State<_ShimmerBlock> createState() => _ShimmerBlockState();
}

class _ShimmerBlockState extends State<_ShimmerBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor =
        widget.colorOverride ?? Colors.grey.shade300; // adjustable for contexts
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
