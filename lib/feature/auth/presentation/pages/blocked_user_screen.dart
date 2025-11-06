import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Create a provider for the parameter value
final userSubscriptionMessageProvider = FutureProvider<String>((ref) async {
  return ref.read(_fetchUserSubscriptionMessageProvider.future);
});

final _fetchUserSubscriptionMessageProvider = FutureProvider<String>((
  ref,
) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token == null) throw Exception('No token found');

    // Replace with your actual base URL
    //const baseUrl = 'https://your-api-domain.com';
    final uri = Uri.parse(
      '$base_url_dev/params?filters=name=USER_SUBSCRIPTION_PROCESSING_TIME',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        "We're having trouble loading the data you're looking for. Please check your connection and try again.",
      );
    }

    final data = jsonDecode(response.body);
    log("parameter data: $data");

    if (data['data'] != null && data['data'].isNotEmpty) {
      final message = data['data'][0]['value'].toString();
      log("parameter value: $message");
      return message;
    } else {
      throw Exception('No parameter data found');
    }
  } catch (e) {
    log("Error fetching parameter: $e");
    // Return a default message if API fails
    return "Your account is currently under review. Please wait and try again, or contact support if the issue persists.";
  }
});

class BlockedUserScreen extends ConsumerStatefulWidget {
  const BlockedUserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlockedUserScreenState();
}

class _BlockedUserScreenState extends ConsumerState<BlockedUserScreen> {
  bool isLoading = false;

  void _callUs() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '0998888866');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final messageAsync = ref.watch(userSubscriptionMessageProvider);

    log("userjono: ${user}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            Column(
              children: [
                // Display the fetched message or loading/error states
                messageAsync.when(
                  data:
                      (message) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  loading: () => const CircularProgressIndicator(),
                  error:
                      (error, stack) => Text(
                        'Unable to load message. Please try again.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed:
                          isLoading
                              ? null
                              : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await ref
                                    .read(authProvider.notifier)
                                    .getCurrentUser();
                                ref.read(routerProvider).go('/auth-gate');
                                setState(() {
                                  isLoading = false;
                                });
                              },
                      icon:
                          isLoading
                              ? SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.teal,
                                ),
                              )
                              : const Icon(Icons.refresh, color: Colors.teal),
                      label: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: GestureDetector(
                        onTap: _callUs,
                        child: const Text(
                          '0998888866',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(flex: 3),
            GestureDetector(
              onTap: () async {
                try {
                  await ref.read(authProvider.notifier).logout();
                  ref.read(routerProvider).go('/login');
                  final socketService = ref.read(socketServiceProvider);
                  socketService.disconnect();
                } catch (e) {
                  log("Error during logout: $e");
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFF5A4F82), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
