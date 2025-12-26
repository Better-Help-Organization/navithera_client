import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/home/presentation/providers/matched_therapist_provider.dart';
import 'package:navithera_client/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, List<Session>>((
  ref,
) {
  return SessionNotifier();
});

class SessionNotifier extends StateNotifier<List<Session>> {
  SessionNotifier() : super([]);

  final Dio _dio = Dio();
  bool _isLoading = false;

  Future<void> loadSessions() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      await _attachAuthHeader();
      final response = await _dio.get(
        '${base_url_dev}/client/me/sessions?fields=therapist.*,schedule,duration,hasTherapistAttended,approvalStatus&take=0',
      );

      final sessionsData = (response.data['data'] as List);
      final sessions = sessionsData.map((e) => Session.fromMap(e)).toList();
      log("sessionsxoxo $sessions");

      state = sessions;
    } catch (e) {
      print('Error loading sessions: $e');
      // Keep existing state on error
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _attachAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}

// --------- Session Models ---------
class Session {
  final String id;
  final DateTime schedule;
  final int duration;
  final Therapist therapist;
  final List<Therapist> group;
  final String? note;
  final bool hasTherapistAttended;
  final String approvalStatus;

  Session({
    required this.id,
    required this.schedule,
    required this.duration,
    required this.therapist,
    required this.approvalStatus,
    this.group = const [],
    this.note,
    this.hasTherapistAttended = false,
  });

  factory Session.fromMap(Map<String, dynamic> map) {
    log("map: $map");
    return Session(
      id: map['id']?.toString() ?? '',
      schedule: DateTime.parse(map['schedule']?.toString() ?? ''),
      duration: map['duration'] is int ? map['duration'] as int : 0,
      therapist: Therapist.fromMap(map['therapist'] as Map<String, dynamic>),
      approvalStatus: map['approvalStatus']?.toString() ?? 'pending',
      group:
          map['group'] is List
              ? (map['group'] as List)
                  .map((e) => Therapist.fromMap(e as Map<String, dynamic>))
                  .toList()
              : [],
      note: map['note']?.toString(),
      hasTherapistAttended:
          map['hasTherapistAttended'] is bool
              ? map['hasTherapistAttended'] as bool
              : false,
    );
  }

  Session copyWith({
    String? id,
    DateTime? schedule,
    int? duration,
    Therapist? therapist,
    String? note,
    bool? hasTherapistAttended,
    String? approvalStatus,
    List<Therapist>? group,
  }) {
    return Session(
      id: id ?? this.id,
      schedule: schedule ?? this.schedule,
      duration: duration ?? this.duration,
      therapist: therapist ?? this.therapist,
      note: note ?? this.note,
      hasTherapistAttended: hasTherapistAttended ?? this.hasTherapistAttended,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      group: group ?? this.group,
    );
  }

  DateTime get endTime => schedule.add(Duration(minutes: duration));
}

class Therapist {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int avatar;
  final String phoneNumber;
  final String status;
  final String gender;

  Therapist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    required this.status,
    required this.gender,
  });

  factory Therapist.fromMap(Map<String, dynamic> map) {
    return Therapist(
      id: map['id']?.toString() ?? '',
      firstName: map['firstName']?.toString() ?? '',
      lastName: map['lastName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      avatar: map['avatar'] is int ? map['avatar'] as int : 1,
      phoneNumber: map['phoneNumber']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      gender: map['gender']?.toString() ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}

// --------- Session Calendar Screen ---------
class SessionCalendarScreen extends StatefulWidget {
  const SessionCalendarScreen({super.key});

  @override
  State<SessionCalendarScreen> createState() => _SessionCalendarScreenState();
}

class _SessionCalendarScreenState extends State<SessionCalendarScreen>
    with WidgetsBindingObserver {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final ValueNotifier<List<Session>> _selectedSessions = ValueNotifier([]);
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Load sessions using provider
    final context = navigatorKey.currentContext;
    if (context != null) {
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
    }

    // Add app lifecycle observer
    WidgetsBinding.instance.addObserver(this);
  }

  void _setupSessionListener(WidgetRef ref) {
    // Listen to session changes and update selected sessions
    ref.listen<List<Session>>(sessionProvider, (previous, next) {
      if (_selectedDay != null) {
        _selectedSessions.value = _getSessionsForDay(_selectedDay!, next);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _selectedSessions.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - refresh sessions
      final context = navigatorKey.currentContext;
      if (context != null) {
        final container = ProviderScope.containerOf(context);
        container.read(sessionProvider.notifier).loadSessions();
      }
    }
  }

  void _updateSelectedSessions() {
    if (_selectedDay == null) return;

    final context = navigatorKey.currentContext;
    if (context != null) {
      final sessions = ProviderScope.containerOf(context).read(sessionProvider);
      _selectedSessions.value = _getSessionsForDay(_selectedDay!, sessions);
    }
  }

  List<Session> _getSessionsForDay(DateTime day, List<Session> sessions) {
    return sessions.where((session) {
      return isSameDay(session.schedule, day);
    }).toList();
  }

  List<Session> _getGroupSessionsForDay(DateTime day, List<Session> sessions) {
    return sessions.where((session) {
      // print("session.group.length: ${session.group.length}");
      if (session.group.length == 0) {
        return false;
      }
      return isSameDay(session.schedule, day);
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _updateSelectedSessions();
    }
  }

  // NEW: Function to update session attendance
  Future<void> _updateSessionAttendance(
    String sessionId,
    bool hasAttended,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      final dio = Dio();
      if (accessToken != null && accessToken.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Make the API call
      final response = await dio.patch(
        '${base_url_dev}/session/attendance/$sessionId',
        data: {'hasTherapistAttended': hasAttended},
      );

      print("here response: ${response}");

      if (response.statusCode == 200) {
        // Reload sessions to get updated data
        final context = navigatorKey.currentContext;
        if (context != null) {
          final container = ProviderScope.containerOf(context);
          await container.read(sessionProvider.notifier).loadSessions();
          // await container.read(matchedTherapistProvider.notifier).load();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Attendance ${hasAttended ? 'marked' : 'updated'} successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to update attendance');
      }
    } catch (e) {
      String errorMessage = 'Failed to update attendance.';
      if (e is DioException && e.response != null) {
        // ignore: avoid_print

        final responseData = e.response?.data;
        String errorMessage = 'Failed to update attendance';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to update attendance';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        // return {'success': false, 'message': errorMessage};
      } else {
        // ignore: avoid_print
        print('Error submitting');
        // return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
      print("here: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateGroupSessionAttendance(
    String sessionId,
    bool hasAttended,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      final dio = Dio();
      if (accessToken != null && accessToken.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Make the API call
      final response = await dio.post(
        '${base_url_dev}/session/group-attendance/$sessionId',
      );

      log("here response: ${response}");

      if (response.statusCode == 201) {
        // Reload sessions to get updated data
        final context = navigatorKey.currentContext;
        if (context != null) {
          final container = ProviderScope.containerOf(context);
          await container.read(sessionProvider.notifier).loadSessions();
          // await container.read(matchedTherapistProvider.notifier).load();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Attendance ${hasAttended ? 'marked' : 'updated'} successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to update attendance');
      }
    } catch (e) {
      String errorMessage = 'Failed to update attendance.';
      if (e is DioException && e.response != null) {
        // ignore: avoid_print

        final responseData = e.response?.data;
        String errorMessage = 'Failed to update attendance';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to update attendance';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        // return {'success': false, 'message': errorMessage};
      } else {
        // ignore: avoid_print
        print('Error submitting');
        // return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
      print("here: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // NEW: Show session details popup with attendance option
  void _showSessionDetailsPopup(Session session) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Session Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkCyan,
                      ),
                    ),
                    // NEW: Attendance button for client
                    if (!session.hasTherapistAttended &&
                        session.approvalStatus.toLowerCase() == 'confirmed')
                      IconButton(
                        icon: Icon(
                          Icons.check_circle_outline,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          // log("session clicked is : ${session.group.length}");
                          if (session.group.isNotEmpty) {
                            _updateGroupSessionAttendance(session.id, true);
                          } else {
                            _updateSessionAttendance(session.id, true);
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Therapist', session.therapist.fullName),
                _buildDetailRow('Date', _formatDate(session.schedule)),
                _buildDetailRow('Time', _formatTime(session.schedule)),
                _buildDetailRow('Duration', '${session.duration} minutes'),
                _buildDetailRow(
                  'Your Therapist Attendance',
                  session.hasTherapistAttended ? 'Attended' : 'Not Attended',
                ),
                _buildDetailRow('Status', session.approvalStatus),
                // if (session.note != null && session.note!.isNotEmpty)
                //   _buildDetailRow('Notes', session.note!),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // NEW: Helper method for detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey.shade800)),
          ),
        ],
      ),
    );
  }

  // NEW: Format date
  String _formatDate(DateTime date) {
    final localTime = date.toLocal();
    return '${localTime.day} ${_getMonthName(localTime.month)} ${localTime.year}';
  }

  // NEW: Format time
  String _formatTime(DateTime date) {
    final localTime = date.toLocal();
    return '${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}';
  }

  // NEW: Get month name
  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final sessions = ref.watch(sessionProvider);
        final isLoading = sessions.isEmpty && _isLoading;

        _setupSessionListener(ref);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: const Text(
              'Session Calendar',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: () => ref.read(sessionProvider.notifier).loadSessions(),
            child: Stack(
              children: [
                ListView(
                  children: [
                    // Calendar Card
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TableCalendar<Session>(
                          firstDay: DateTime.now().subtract(
                            const Duration(days: 365),
                          ),
                          lastDay: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          focusedDay: _focusedDay,
                          selectedDayPredicate:
                              (day) => isSameDay(_selectedDay, day),
                          calendarFormat: _calendarFormat,
                          eventLoader:
                              (day) => _getSessionsForDay(day, sessions),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            defaultDecoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            weekendDecoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            selectedDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppColors.primary, AppColors.darkCyan],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            todayDecoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                            markerDecoration: BoxDecoration(
                              color: AppColors.darkCyan,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            defaultTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            weekendTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            todayTextStyle: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            outsideTextStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: AppColors.darkCyan,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: AppColors.darkCyan,
                            ),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: AppColors.darkCyan,
                              fontWeight: FontWeight.w600,
                            ),
                            weekendStyle: TextStyle(
                              color: AppColors.darkCyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, date, events) {
                              return const SizedBox.shrink();
                            },
                            defaultBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              final hasGroupSessions =
                                  _getGroupSessionsForDay(
                                    date,
                                    sessions,
                                  ).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      hasGroupSessions
                                          ? Colors.purple
                                          : hasSessions
                                          ? const Color.fromARGB(
                                            255,
                                            96,
                                            102,
                                            101,
                                          )
                                          : Colors.transparent,

                                  // hasSessions
                                  //     ? const Color.fromARGB(
                                  //       255,
                                  //       96,
                                  //       102,
                                  //       101,
                                  //     )
                                  //     : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color:
                                        hasSessions
                                            ? Colors.white
                                            : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                            todayBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      hasSessions
                                          ? AppColors.primary
                                          : AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      hasSessions
                                          ? null
                                          : Border.all(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                          ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color:
                                        hasSessions
                                            ? Colors.white
                                            : AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                            selectedBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      hasSessions
                                          ? AppColors.primary
                                          : AppColors.darkCyan,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                          ),

                          onDaySelected: _onDaySelected,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Text(
                            'Sessions for ${_selectedDay != null ? _formatDate(_selectedDay!) : 'Selected Day'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Day Calendar Timeline
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ValueListenableBuilder<List<Session>>(
                        valueListenable: _selectedSessions,
                        builder: (context, selectedSessions, _) {
                          if (_error != null && sessions.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 60.0,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 48,
                                      color: Colors.red.shade300,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _error!,
                                      style: TextStyle(
                                        color: Colors.red.shade600,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    OutlinedButton.icon(
                                      onPressed:
                                          () =>
                                              ref
                                                  .read(
                                                    sessionProvider.notifier,
                                                  )
                                                  .loadSessions(),
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Try Again'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return _DayCalendarView(
                            sessions: selectedSessions,
                            onSessionTap:
                                _showSessionDetailsPopup, // NEW: Pass the tap handler
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),

                // Full-screen loading overlay
                if (isLoading)
                  Positioned.fill(
                    child: AbsorbPointer(
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Loading sessions...',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// UPDATED: DayCalendarView now accepts onSessionTap parameter
class _DayCalendarView extends StatelessWidget {
  final List<Session> sessions;
  final Function(Session) onSessionTap; // NEW: Add onSessionTap parameter

  const _DayCalendarView({required this.sessions, required this.onSessionTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Fixed height for the day calendar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Time markers (background)
          _buildTimeMarkers(),

          // Session blocks (overlay)
          ..._buildSessionBlocks(),
        ],
      ),
    );
  }

  Widget _buildTimeMarkers() {
    return Column(
      children: List.generate(24, (hour) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:00',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildSessionBlocks() {
    if (sessions.isEmpty) {
      return [
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.event_available,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Text(
                  'No sessions scheduled',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return sessions.map((session) {
      final localTime = session.schedule.toLocal();
      final startHour = localTime.hour;
      final startMinute = localTime.minute;
      final durationHours = session.duration ~/ 60;
      final durationMinutes = session.duration % 60;

      // Calculate position and height based on time
      final top = (startHour + 0.1 / 60) * (600 / 24);
      // final height = (durationHours + durationMinutes / 60) * (600 / 24);
      final height = 100;

      return Positioned(
        left: 60, // Offset for time markers
        top: top,
        right: 16,
        height: 20,
        child: _SessionTimeBlock(
          session: session,
          onTap: () => onSessionTap(session), // NEW: Pass the tap handler
        ),
      );
    }).toList();
  }
}

// UPDATED: SessionTimeBlock now accepts onTap parameter
class _SessionTimeBlock extends StatelessWidget {
  final Session session;
  final VoidCallback onTap; // NEW: Add onTap parameter

  const _SessionTimeBlock({required this.session, required this.onTap});

  @override
  Widget build(BuildContext context) {
    print('sessionyyy: ${session.group.length}');
    final Color primaryColor = AppColors.primary;
    return GestureDetector(
      onTap: onTap, // NEW: Use the onTap parameter
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                session.group.length != 0
                    ? [Colors.purple, Colors.deepPurple]
                    : session.approvalStatus == 'pending'
                    ? [Colors.yellow, Colors.yellow.shade700]
                    : [primaryColor, AppColors.darkCyan],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          child: Row(
            children: [
              Text(
                session.therapist.fullName,
                style: TextStyle(
                  color:
                      session.approvalStatus == 'pending'
                          ? Colors.black45
                          : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (session.hasTherapistAttended)
                Row(
                  children: [
                    SizedBox(width: 6),
                    Icon(Icons.check_circle, color: Colors.white, size: 12),
                    SizedBox(width: 2),
                    Text("Attended", style: TextStyle(color: Colors.white)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
