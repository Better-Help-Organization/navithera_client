import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/home/presentation/providers/upcoming_session_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart'; // Add intl: ^0.19.0 to pubspec.yaml

// ----------------------------------------------------------------------------
// Option 2: (Optional) Global key approach (uncomment and wire in MaterialApp)
// ----------------------------------------------------------------------------
// In your main.dart (or app root), pass this key into MaterialApp:
//   final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//   runApp(MaterialApp(scaffoldMessengerKey: scaffoldMessengerKey, ...));
// Then import that key here or keep it in a shared place.
// final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final sessionSelectionServiceProvider = Provider<SessionSelectionService>((ref) {
  return SessionSelectionService();
});

class SessionSelectionService {
  final Dio _dio = Dio();

  // Single secure storage instance shared across methods
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
  );

  Future<Map<String, dynamic>?> getSessionDetails(String sessionId) async {
    try {
      // Secure token read
      final accessToken = await _secureStorage.read(key: 'access_token');
      if (accessToken == null) return null;

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.get(
        '${base_url_dev}/client/me/sessions/$sessionId',
        queryParameters: {'fileds':'id,schedule'}
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        if (kDebugMode) {
          debugPrint('Failed to get session details: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error getting session details: $e');
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> submitSessionSelection({
    required String selectedId,
    required List<String> unselectedIds,
  }) async {
    try {
      // Secure token read
      final accessToken = await _secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        return {'success': false, 'message': 'Not authenticated'};
      }

      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await _dio.post(
        '${base_url_dev}/session/select',
        data: {'selectedId': selectedId, 'unselectedIds': unselectedIds},
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Session selected successfully'};
      } else {
        final errorMessage =
            response.data['message'] ?? 'Failed to submit session selection';
        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        if (kDebugMode) {
          debugPrint('Server error: ${e.response?.statusCode}');
        }

        final responseData = e.response?.data;
        String errorMessage = 'Failed to submit session selection';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              errorMessage;
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        return {'success': false, 'message': errorMessage};
      } else {
        return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
    }
  }

  void showSessionSelectionDialog({
    required BuildContext context,
    required List<String> sessionIds,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SessionSelectionDialog(
          sessionIds: sessionIds,
          onSelectionComplete: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class SessionSelectionDialog extends ConsumerStatefulWidget {
  final List<String> sessionIds;
  final VoidCallback onSelectionComplete;

  const SessionSelectionDialog({
    Key? key,
    required this.sessionIds,
    required this.onSelectionComplete,
  }) : super(key: key);

  @override
  ConsumerState<SessionSelectionDialog> createState() =>
      _SessionSelectionDialogState();
}

class _SessionSelectionDialogState
    extends ConsumerState<SessionSelectionDialog> {
  String? _selectedSessionId;
  // Map of sessionId -> details map (should contain 'schedule')
  Map<String, Map<String, dynamic>> _sessionDetails = {};
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadSessionDetails();
  }

  Future<void> _loadSessionDetails() async {
    final service = ref.read(sessionSelectionServiceProvider);

    for (final sessionId in widget.sessionIds) {
      final details = await service.getSessionDetails(sessionId);
      if (details != null) {
        if (!mounted) return;
        setState(() {
          _sessionDetails[sessionId] = details;
        });
      }
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitSelection() async {
    if (_selectedSessionId == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final service = ref.read(sessionSelectionServiceProvider);
    final unselectedIds =
        widget.sessionIds.where((id) => id != _selectedSessionId).toList();

    final result = await service.submitSessionSelection(
      selectedId: _selectedSessionId!,
      unselectedIds: unselectedIds,
    );

    // await ref.read(authProvider.notifier).getCurrentUser();

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    // Use root navigator context to ensure SnackBar shows above dialog
    final rootContext = Navigator.of(context, rootNavigator: true).context;

    if (result['success'] == true) {
      await ref.read(upcomingSessionProvider.notifier).loadNext();
      // Close dialog first, then show success snackbar.
      // Navigator.of(context).pop();
      await ref.read(authProvider.notifier).getCurrentUser();
      ref.read(routerProvider).go('/auth-gate');
      // print("hey hey23");
      ref.read(upcomingSessionProvider.notifier).loadNext();
      widget.onSelectionComplete();

      ScaffoldMessenger.of(rootContext).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Session selected successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      Navigator.of(context).pop();
      // Keep dialog open OR close it based on UX. Here we keep it open.
      ScaffoldMessenger.of(rootContext).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Failed to select session'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Formatting helpers
  String _formatDate(DateTime dt) => DateFormat('dd/MM/yyyy').format(dt);
  String _formatTime(DateTime dt) => DateFormat('HH:mm').format(dt);

  // Group session IDs by their local date (00:00 time)
  Map<DateTime, List<String>> _groupSessionsByDate() {
    final Map<DateTime, List<String>> grouped = {};

    for (final sessionId in widget.sessionIds) {
      final details = _sessionDetails[sessionId];
      if (details == null || details['schedule'] == null) continue;

      final schedule = DateTime.parse(details['schedule'].toString()).toLocal();
      final dateOnly = DateTime(schedule.year, schedule.month, schedule.day);

      grouped.putIfAbsent(dateOnly, () => []).add(sessionId);
    }

    // Sort sessions within each date by time
    for (final date in grouped.keys) {
      grouped[date]!.sort((a, b) {
        final da =
            DateTime.parse(
              _sessionDetails[a]!['schedule'].toString(),
            ).toLocal();
        final db =
            DateTime.parse(
              _sessionDetails[b]!['schedule'].toString(),
            ).toLocal();
        return da.compareTo(db);
      });
    }

    // Return entries sorted by date
    final entries =
        grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    return Map.fromEntries(entries);
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupSessionsByDate();

    return AlertDialog(
      title: const Text('Select a Session Time'),
      content:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                width: double.maxFinite,
                child:
                    grouped.isEmpty
                        ? const Text('No sessions available')
                        : ListView(
                          shrinkWrap: true,
                          children: [
                            for (final entry in grouped.entries) ...[
                              // Date header
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 12, 8, 6),
                                child: Text(
                                  _formatDate(entry.key),
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Sessions under this date
                              ...entry.value.map((sessionId) {
                                final details = _sessionDetails[sessionId];
                                final schedule =
                                    details != null &&
                                            details['schedule'] != null
                                        ? DateTime.parse(
                                          details['schedule'].toString(),
                                        ).toLocal()
                                        : null;

                                return Card(
                                  child: RadioListTile<String>(
                                    title:
                                        schedule != null
                                            ? Text(_formatTime(schedule))
                                            : Text(
                                              'Session $sessionId (Loading...)',
                                            ),
                                    // Add extra info as subtitle if needed
                                    value: sessionId,
                                    groupValue: _selectedSessionId,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedSessionId = value;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          ],
                        ),
              ),
      actions: [
        TextButton(
          onPressed:
              _isSubmitting
                  ? null
                  : () {
                    Navigator.of(context).pop();
                    ref.read(upcomingSessionProvider.notifier).loadNext();
                  },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed:
              _selectedSessionId != null && !_isSubmitting
                  ? _submitSelection
                  : null,
          child:
              _isSubmitting
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Confirm Selection'),
        ),
      ],
    );
  }
}
