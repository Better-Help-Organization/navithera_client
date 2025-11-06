// notification_screen.dart
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navithera_client/core/notification/session_selection_service.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import 'package:navithera_client/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navithera_client/feature/notification/data/models/notification_models.dart';
import 'package:navithera_client/feature/notification/domain/repositories/notification_repository.dart';
import 'package:navithera_client/feature/notification/presentation/providers/notification_provider.dart';
//import 'package:navithera_client/feature/questionnaire/presentation/pages/match_request_screen.dart';
import 'package:navithera_client/main.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotifications();
      _markAllAsReadOnNavigate();
    });
  }

  Future<void> _markAllAsReadOnNavigate() async {
    try {
      await ref.read(notificationRepositoryProvider).markAllAsRead();
      // Optionally update local state if needed
      ref.read(notificationProvider.notifier).markAllNotificationsAsRead();
    } catch (e) {
      // Silent fail - we don't want to show error for this
      print('Failed to mark all as read on navigate: $e');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      await ref
          .read(notificationProvider.notifier)
          .getNotifications(loadMore: loadMore, silent: silent);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load notifications:'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(notificationProvider);
      if (state is NotificationLoaded && state.canLoadMore) {
        _loadNotifications(loadMore: true, silent: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    await _loadNotifications(silent: true);
  }

  Future<void> _markAllAsRead() async {
    try {
      await ref.read(notificationRepositoryProvider).markAllAsRead();
      ref.read(notificationProvider.notifier).markAllNotificationsAsRead();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to mark all as read'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        // title: Text(AppLocalizations.of(context)!.notifications),
        title: const Text("Notifications"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.checklist_rounded),
        //     onPressed: _markAllAsRead,
        //     tooltip: 'Mark all as read',
        //   ),
        // ],
      ),
      body: _buildBody(notificationState),
    );
  }

  Widget _buildBody(NotificationState notificationState) {
    return switch (notificationState) {
      NotificationInitial() => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: const Center(child: Text('No notifications available')),
      ),
      NotificationLoading() => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      NotificationError(:final failure) => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(failure.message.toString()),
              ),
            ),
          ),
        ),
      ),
      NotificationLoaded(:final notifications, :final canLoadMore) =>
        RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppColors.primary,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: notifications.length + (canLoadMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == notifications.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              final notification = notifications[index];
              return _buildNotificationItem(notification);
            },
          ),
        ),
      // TODO: Handle this case.
      NotificationState() => throw UnimplementedError(),
    };
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () {
            print("no: ${notification.title}");
            if (notification.title == "Session scheduled") {
              _handleNotification(notification.message ?? '');
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color:
                  notification.isRead
                      ? Colors.grey[50]
                      : AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getNotificationColor(notification.code),
                    ),
                    child: Icon(
                      _getNotificationIcon(notification.code),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight:
                          notification.isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    formatTelegramStyle(notification.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing:
                      !notification.isRead
                          ? Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                          : null,
                ),
                if (notification.isExpanded) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      notification.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (notification.message != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        'Additional details: ${notification.message}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getNotificationColor(String code) {
    switch (code) {
      case '1': // Session scheduled
        return Colors.blue;
      case '9': // Match accepted
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  void _handleNotification(String messageJson) {
    try {
      // Parse the JSON string from the notification message
      final messageData = jsonDecode(messageJson);

      // Convert to a format that extractMatchPayload can handle
      final remoteMessage = RemoteMessage(
        data: messageData is Map<String, dynamic> ? messageData : {},
        notification: RemoteNotification(
          title: messageData['title']?.toString(),
          body: messageData['body']?.toString(),
        ),
      );

      print("no2 : ${remoteMessage.data}");

      _handleSessionSelectionNotification(remoteMessage);
      ref.read(sessionProvider.notifier).loadSessions();
      // final payload = extractMatchPayload(remoteMessage);
      // if (payload != null) {
      //   final request = MatchRequest.fromMap(payload);
      //   _openNewMatchRequestPage(request);
      // } else {
      //   print('New match request payload not found or invalid');
      // }
    } catch (e) {
      print('Failed to parse notification message: $e');
    }
  }

  void _handleSessionSelectionNotification(RemoteMessage message) {
    try {
      final data = message.data;
      print("xoxoxo: ${data}");

      // Check if sessionIds exists and handle both string and list formats
      if (data['sessionIds'] != null) {
        List<String> sessionIds = [];

        if (data['sessionIds'] is String) {
          // Handle string format (JSON string)
          final idMap = json.decode(data['sessionIds']) as Map<String, dynamic>;
          sessionIds = List<String>.from(idMap['sessionIds'] ?? []);
        } else if (data['sessionIds'] is List) {
          // Handle direct list format
          sessionIds = List<String>.from(data['sessionIds']);
        }

        print("sessionIds: ${sessionIds}");
        final context = navigatorKey.currentContext;
        print("sessionIdss: ${context}");

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

  Map<String, dynamic>? extractMatchPayload(RemoteMessage message) {
    try {
      // Preferred: payload is in data['id'] as a JSON string
      if (message.data.containsKey('id')) {
        final raw = message.data['id'];
        if (raw is String) {
          final decoded = jsonDecode(raw);
          if (decoded is Map<String, dynamic>) return decoded;
        } else if (raw is Map<String, dynamic>) {
          return raw;
        }
      }

      // Fallback: try notification body as JSON
      if ((message.notification?.body ?? '').isNotEmpty) {
        final bodyDecoded = jsonDecode(message.notification!.body!);
        if (bodyDecoded is Map<String, dynamic>) {
          // Some senders put the object directly, others under "id"
          if (bodyDecoded['matchData'] != null &&
              bodyDecoded['clientData'] != null) {
            return bodyDecoded;
          }
          if (bodyDecoded['id'] is Map<String, dynamic>) {
            return bodyDecoded['id'] as Map<String, dynamic>;
          }
        }
      }

      // Last resort: use message.data directly if it looks like the object
      if (message.data['matchData'] != null &&
          message.data['clientData'] != null) {
        return Map<String, dynamic>.from(message.data);
      }
    } catch (e) {
      print('Failed to extract match payload: $e');
    }
    return null;
  }

  IconData _getNotificationIcon(String code) {
    switch (code) {
      case '1': // Session scheduled
        return Icons.calendar_today;
      case '9': // Match accepted
        return Icons.people_alt;
      default:
        return Icons.notifications;
    }
  }
}
