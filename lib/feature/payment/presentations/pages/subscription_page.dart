import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_telebirr/flutter_telebirr.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
// import 'package:navithera_client/feature/payment/presentations/pages/payment_page.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
// import 'package:web/web.dart' as html;

// Providers
final vatProvider = StateProvider<double?>((ref) => null);
final exchangeRateProvider = StateProvider<double?>((ref) => null);

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
);
// Keep as FutureProvider but use ref.refresh for force reload
final userPreferencesProvider = FutureProvider<Map<String, dynamic>?>((
  ref,
) async {
  final token = await _secureStorage.read(key: 'access_token');
  if (token == null) throw Exception('No token found');

  final uri = Uri.parse(
    '$base_url_dev/client/me/preferences?fields=level.*,modal.*&sort=createdAt=desc',
  );
  final response = await http.get(
    uri,
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode != 200) {
    throw Exception(
      "We're having trouble loading your preference. Please check your connection and try again.",
    );
  }

  final data = jsonDecode(response.body);
  print("Selected data: $data");

  final list = data['data'];

  if (list != null && list is List && list.isNotEmpty) {
    final prefdata = list.first;
    print("Selected prefdata: $prefdata");

    ref.read(selectedPrefProvider.notifier).state = prefdata['id'];

    final level = prefdata['level'];
    final modal = prefdata['modal'];

    return {
      'levelId': level?['id'],
      'levelType': level?['type'],
      'levelPrice': level?['price']?.toString(),
      'modalId': modal?['id'],
      'modalName': modal?['name'],
    };
  }

  print("⚠️ No user preferences found");
  return null;
});

// Subscription model
class Subscription {
  final String id;
  final int type; // 0=free,1=monthly,3=quarterly,6=semi-annual,12=yearly
  final int price;
  final String? level;
  final String? levelId;
  final Map<String, dynamic>? modal;

  Subscription({
    required this.id,
    required this.type,
    required this.price,
    this.level,
    this.levelId,
    this.modal,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    final levelMap = json['level'] as Map<String, dynamic>?;
    final modalMap = json['modal'] as Map<String, dynamic>?;

    return Subscription(
      id: json['id'],
      type: json['type'],
      price: json['price'],
      level: levelMap?['type'] as String?,
      levelId: levelMap?['id'] as String?,
      modal: modalMap,
    );
  }
}

// Subscription Service
class SubscriptionService {
  static Future<List<Subscription>> fetchFilteredSubscriptions({
    required String? levelId,
    required String? modalId,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) throw Exception('No token found');

    // Build query parameters
    final params = <String, String>{
      'fields': 'price,type,level.*,modal.*',
      'take': '0', // Get all records
    };

    // Add filters if provided
    final filters = <String>['is_admin_created=1'];
    if (levelId != null && levelId.isNotEmpty) {
      filters.add('level.id=$levelId');
    }
    print("Modal ID in fetch: $modalId");
    if (modalId != null && modalId.isNotEmpty) {
      filters.add('modal.id=$modalId');
    }

    if (filters.isNotEmpty) {
      params['filters'] = filters.join(',');
    }

    final uri = Uri.parse(
      '$base_url_dev/subscription',
    ).replace(queryParameters: params);

    print("Fetching subscriptions from: ${uri.toString()}");

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch subscriptions: ${response.body}');
    }

    final data = jsonDecode(response.body);
    print("Subscriptions response: ${data['data'].length} items found");

    final List subscriptions = data['data'];
    return subscriptions.map((e) => Subscription.fromJson(e)).toList();
  }

  static Future<String> createSubscription({
    required String subscriptionId,
    required String? userId,
  }) async {
    final token = await _secureStorage.read(key: 'access_token');
    if (token == null) throw Exception('No token found');

    final uri = Uri.parse('$base_url_dev/subscription');

    final body = json.encode({'subscriptionId': subscriptionId});

    print("Request Body: $body");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");

    if (response.statusCode == 409) {
      // Handle conflict - extract existing subscription ID from error message
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['message'] as String?;

      if (errorMessage != null) {
        // Extract the ID using regex to find the pattern in the error message
        final regex = RegExp(r"'([a-f0-9-]+-[a-f0-9-]+)'");
        final match = regex.firstMatch(errorMessage);

        if (match != null && match.groupCount >= 1) {
          String existingSubscriptionId = match.group(1)!;
          print("Found existing subscription ID: $existingSubscriptionId");

          // Subtract userId from the extracted subscription ID if userId is provided
          if (userId != null && userId.isNotEmpty) {
            if (existingSubscriptionId.startsWith(userId)) {
              existingSubscriptionId = existingSubscriptionId.substring(
                userId.length,
              );
              print(
                "Subscription ID after subtracting userId: $existingSubscriptionId",
              );
            } else {
              print(
                "UserId '$userId' not found at start of subscription ID '$existingSubscriptionId'",
              );
            }
          }

          return existingSubscriptionId.substring(1);
        }
      }

      // If we can't extract the ID, throw a more specific exception
      throw Exception(
        'Subscription already exists but could not extract ID from: $errorMessage',
      );
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to create subscription: ${response.body}');
    }

    final responseData = jsonDecode(response.body);
    return responseData['data']['id'];
  }
}

// Add modal provider if not exists
final selectedModalProvider = StateProvider<String?>((ref) => null);
final selectedModalNameProvider = StateProvider<String?>((ref) => null);

// Main Subscription Page with route-aware refresh
class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPage>
    with WidgetsBindingObserver {
  late Future<List<Subscription>> _future;
  bool _isRefreshing = false;
  bool _hasInitialLoad = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Refresh when app comes back to foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _hasInitialLoad) {
      print("App resumed, refreshing subscription data...");
      _refreshAllData();
    }
  }

  Future<void> _initializeData() async {
    await _refreshAllData();
    _hasInitialLoad = true;
  }

  Future<void> _refreshAllData() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      // Force refresh user preferences
      await _refreshUserPreferences();

      // Load subscriptions with updated preferences
      await _loadSubscriptions();

      // Load additional data
      await _getVat();
      await _getExchangeRate();
    } catch (e) {
      print("Error refreshing data: $e");
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  Future<void> _refreshUserPreferences() async {
    try {
      print("Refreshing user preferences...");

      // This forces the future provider to re-fetch the data
      final freshPreferences = await ref.refresh(
        userPreferencesProvider.future,
      );

      if (freshPreferences != null) {
        // Update all providers with fresh data
        ref.read(selectedLevelProvider.notifier).state =
            freshPreferences['levelId'];
        ref.read(selectedLevelPriceProvider.notifier).state =
            freshPreferences['levelPrice'];
        ref.read(selectedModalProvider.notifier).state =
            freshPreferences['modalId'];
        ref.read(selectedModalNameProvider.notifier).state =
            freshPreferences['modalName'];

        print("✅ Fresh preferences loaded:");
        print("  - Level ID: ${freshPreferences['levelId']}");
        print("  - Level Price: ${freshPreferences['levelPrice']}");
        ref.read(modalIdProvider.notifier).state = freshPreferences['modalId'];
        print("  - Modal ID: ${freshPreferences['modalId']}");
        print("  - Modal Name: ${freshPreferences['modalName']}");
      } else {
        print("⚠️ No preferences found after refresh");
      }
    } catch (e) {
      print("❌ Error refreshing preferences: $e");
      rethrow;
    }
  }

  Future<void> _loadSubscriptions() async {
    final selectedLevel = ref.read(selectedLevelProvider);
    final selectedModal = ref.read(selectedModalProvider);

    print(
      "Loading subscriptions with level: $selectedLevel, modal: $selectedModal",
    );

    setState(() {
      _future = SubscriptionService.fetchFilteredSubscriptions(
        levelId: selectedLevel,
        modalId: selectedModal,
      );
    });
  }

  String _getTypeLabel(int type) {
    switch (type) {
      case 0:
        return 'Trial';
      case 1:
        return 'Monthly';
      case 3:
        return 'Quarterly';
      case 6:
        return 'Semi-Annual';
      case 12:
        return 'Yearly';
      default:
        return 'Unknown';
    }
  }

  String _getTypeDescription(int type) {
    switch (type) {
      case 0:
        return '1 session - Perfect for trying our service';
      case 1:
        return '4 sessions - Great for getting started';
      case 3:
        return '12 sessions - Ideal for consistent progress';
      case 6:
        return '24 sessions - Best value for dedicated users';
      case 12:
        return '48 sessions - Ultimate commitment with maximum savings';
      default:
        return 'Subscription plan';
    }
  }

  void _handleSubscriptionTap(Subscription subscription) async {
    final subscriptionId = subscription.id;
    final providerId = ref.read(selectedPrefProvider);
    final user = ref.watch(currentUserProvider);

    try {
      // Future<void> _checkIfPrefFilled() async {
      try {
        final finalsubscriptionId =
            await SubscriptionService.createSubscription(
              subscriptionId: subscriptionId,
              userId: user?.id,
            );

        print("Selected subscription ID: $finalsubscriptionId");
        print("Selected provider ID: $providerId");
        print("Navigating to payment page with subscription ID");

        context.go(
          '/payment?preferenceId=$providerId',
          extra: finalsubscriptionId,
        );
        // print("hi hi");
        // final dio = Dio();
        // dio.options.headers['Authorization'] = 'Bearer $accessToken';

        // final response = await dio.post(
        //   '${base_url_dev}/telebirr/user-sub',
        //   data: {
        //     'subscriptionId': finalsubscriptionId,
        //     'title': _getTypeLabel(subscription.type),
        //     'amount': subscription.price,
        //   },
        // );

        // print("responsexoxo: ${response.data}");

        // if (response.statusCode == 200) {
        //   print(" Subscription created successfully. ");
        //   // Your existing navigation code here...
        // } else {
        //   if (!mounted) return;
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('an error occured'),
        //       backgroundColor: Colors.red,
        //     ),
        //   );
        // }
      } on DioException catch (e) {
        log("dio error: ${e.response?.data}");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        log("dio error2: ${e.toString()}");
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred'),
            backgroundColor: Colors.red,
          ),
        );
        // }
      }
    } catch (e) {
      print("Error creating subscription: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred. try again"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ... your existing imports ...

  // void _handleSubscriptionTap(Subscription subscription) async {
  //   final subscriptionId = subscription.id;
  //   final providerId = ref.read(selectedPrefProvider);
  //   final user = ref.watch(currentUserProvider);

  //   try {
  //     final sharedPreferences = await SharedPreferences.getInstance();
  //     final accessToken = sharedPreferences.getString('access_token');

  //     try {
  //       final finalsubscriptionId =
  //           await SubscriptionService.createSubscription(
  //             subscriptionId: subscriptionId,
  //             userId: user?.id,
  //           );

  //       print("Selected subscription ID: $finalsubscriptionId");
  //       print("Selected provider ID: $providerId");

  //       final dio = Dio();
  //       dio.options.headers['Authorization'] = 'Bearer $accessToken';

  //       final response = await dio.post(
  //         '${base_url_dev}/telebirr/user-sub',
  //         data: {
  //           'subscriptionId': finalsubscriptionId,
  //           'title': _getTypeLabel(subscription.type),
  //           // 'amount': subscription.price,
  //         },
  //       );

  //       print("responsexoxo: ${response.data}");

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         final responseData = response.data;
  //         final paymentUrl = responseData['data'];

  //         if (paymentUrl != null && paymentUrl is String) {
  //           print("Payment URL: $paymentUrl");

  //           // Open the URL automatically
  //           await _openPaymentUrl(paymentUrl);
  //         } else {
  //           if (!mounted) return;
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text('Payment URL not found in response'),
  //               backgroundColor: Colors.red,
  //             ),
  //           );
  //         }
  //       } else {
  //         if (!mounted) return;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('An error occurred: ${response.statusCode}'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     } on DioException catch (e) {
  //       log("dio error: ${e.response?.data}");
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     } catch (e) {
  //       log("dio error2: ${e.toString()}");
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('An unexpected error occurred'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print("Error creating subscription: $e");
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("An error occurred. try again"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  // Future<void> __openPaymentUrlUrl(String url) async {
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => PaymentPage(checkOutUrl: url)),
  //   // );
  //   // try {
  //   //   TelebirrPayment.instance.configure(
  //   //     publicKey:
  //   //         "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC/ZcoOng1sJZ4CegopQVCw3HYqqVRLEudgT+dDpS8fRVy7zBgqZunju2VRCQuHeWs7yWgc9QGd4/8kRSLY+jlvKNeZ60yWcqEY+eKyQMmcjOz2Sn41fcVNgF+HV3DGiV4b23B6BCMjnpEFIb9d99/TsjsFSc7gCPgfl2yWDxE/Y1B2tVE6op2qd63YsMVFQGdre/CQYvFJENpQaBLMq4hHyBDgluUXlF0uA1X7UM0ZjbFC6ZIB/Hn1+pl5Ua8dKYrkVaecolmJT/s7c/+/1JeN+ja8luBoONsoODt2mTeVJHLF9Y3oh5rI+IY8HukIZJ1U6O7/JcjH3aRJTZagXUS9AgMBAAECggEBALBIBx8JcWFfEDZFwuAWeUQ7+VX3mVx/770kOuNx24HYt718D/HV0avfKETHqOfA7AQnz42EF1Yd7Rux1ZO0e3unSVRJhMO4linT1XjJ9ScMISAColWQHk3wY4va/FLPqG7N4L1w3BBtdjIc0A2zRGLNcFDBlxl/CVDHfcqD3CXdLukm/friX6TvnrbTyfAFicYgu0+UtDvfxTL3pRL3u3WTkDvnFK5YXhoazLctNOFrNiiIpCW6dJ7WRYRXuXhz7C0rENHyBtJ0zura1WD5oDbRZ8ON4v1KV4QofWiTFXJpbDgZdEeJJmFmt5HIi+Ny3P5n31WwZpRMHGeHrV23//0CgYEA+2/gYjYWOW3JgMDLX7r8fGPTo1ljkOUHuH98H/a/lE3wnnKKx+2ngRNZX4RfvNG4LLeWTz9plxR2RAqqOTbX8fj/NA/sS4mru9zvzMY1925FcX3WsWKBgKlLryl0vPScq4ejMLSCmypGz4VgLMYZqT4NYIkU2Lo1G1MiDoLy0CcCgYEAwt77exynUhM7AlyjhAA2wSINXLKsdFFF1u976x9kVhOfmbAutfMJPEQWb2WXaOJQMvMpgg2rU5aVsyEcuHsRH/2zatrxrGqLqgxaiqPz4ELINIh1iYK/hdRpr1vATHoebOv1wt8/9qxITNKtQTgQbqYci3KV1lPsOrBAB5S57nsCgYAvw+cagS/jpQmcngOEoh8I+mXgKEET64517DIGWHe4kr3dO+FFbc5eZPCbhqgxVJ3qUM4LK/7BJq/46RXBXLvVSfohR80Z5INtYuFjQ1xJLveeQcuhUxdK+95W3kdBBi8lHtVPkVsmYvekwK+ukcuaLSGZbzE4otcn47kajKHYDQKBgDbQyIbJ+ZsRw8CXVHu2H7DWJlIUBIS3s+CQ/xeVfgDkhjmSIKGX2to0AOeW+S9MseiTE/L8a1wY+MUppE2UeK26DLUbH24zjlPoI7PqCJjl0DFOzVlACSXZKV1lfsNEeriC61/EstZtgezyOkAlSCIH4fGr6tAeTU349Bnt0RtvAoGBAObgxjeH6JGpdLz1BbMj8xUHuYQkbxNeIPhH29CySn0vfhwg9VxAtIoOhvZeCfnsCRTj9OZjepCeUqDiDSoFznglrKhfeKUndHjvg+9kiae92iI6qJudPCHMNwP8wMSphkxUqnXFR3lr9A765GA980818UWZdrhrjLKtIIZdh+X1",
  //   //     appId: '1511910021811206',
  //   //     appKey: "c4182ef8-9249-458a-985e-06d191f4d505",
  //   //     notifyUrl: '${base_url_dev}/telebirr/user-sub',
  //   //     shortCode: "841050",
  //   //     merchantDisplayName: "Organization name",
  //   //   );

  //   //   final response = await TelebirrPayment.instance.startPayment(
  //   //     itemName: "Goods name",
  //   //     totalAmount: "10",
  //   //   );

  //   //   print("response from telebirr: $response");
  //   // } catch (e) {
  //   //   print("Error launching payment URL: $e");
  //   // }
  //   Future<void> startPay(String url) async {
  //     // final uri = Uri.parse(url);

  //     // final bool launched = await launchUrl(
  //     //   uri,
  //     //   mode: LaunchMode.externalApplication,
  //     // );

  //     // if (!launched) {
  //     //   debugPrint("FAILED to open: $url");
  //     // }

  //     String paymentUrl =
  //         "https://developerportal.ethiotelebirr.et:38443/payment/web/paygate?appid=1511910021811206&merch_code=841050&nonce_str=UUDJ5BF5BEFR072F0CG0VXYSNB8VLYQQ&prepay_id=019f3c760fc4da5c56624aedc4b3baa3804006&timestamp=1764670833&sign=cQvTVbguARgAU9SJSGfh3Flh4ivL4Dwf0Ux1ReLQnUgfXD9onIXdqN+1tftf7XbaNfEtjp2qqcJ6nYXmHw7rcPP4fRr1IIjCUxNsnuwZHa5j2A6cGUoZNOVO0KNQ33UR9RAY/+tYlTGmvb2lDTTGl3PlXt6Ryg/m5ZsFlxRApV+xUiMaSVQexhgLv9s+upzwVFgXytSx8ILJTfFQhndBUk3/aiqUJh2OOMmlcmNyJ+umUT9RWlVEnKDYdDBdH1KoEhJPDWW88MvI3dW/knMEYh9xi7C83LjY5E4R6bGKcNhy/sGt7tZiGYKGg5keFamtY6A+bjvkUia8UseGt3iD1w==&sign_type=SHA256WithRSA&version=1.0&trade_type=Checkout";
  //     String encodedUrl = Uri.encodeComponent(paymentUrl);
  //     String htmlPageUrl =
  //         "   http://localhost:5500/index.html?url=$encodedUrl";

  //     // Launch WebView with the HTML page
  //     launchUrl(Uri.parse(htmlPageUrl), mode: LaunchMode.externalApplication);
  //   }

  //   startPay(url);
  //   // try {
  //   // if (kIsWeb) {
  //   // WEB SPECIFIC IMPLEMENTATION
  //   // This mimics exactly:
  //   // let anchorEle = document.createElement("a");
  //   // anchorEle.setAttribute("href", checkOutUrl);
  //   // anchorEle.setAttribute("target", "_blank");
  //   // anchorEle.setAttribute("rel", "external");
  //   // anchorEle.click();

  //   //   final anchor =
  //   //       html.AnchorElement(href: url)
  //   //         ..target = '_blank'
  //   //         ..rel = 'external';

  //   //   // Append to body temporarily to ensure click works in some browsers
  //   //   html.document.body?.children.add(anchor);
  //   //   anchor.click();
  //   //   anchor.remove(); // Clean up
  //   // } else {
  //   // MOBILE IMPLEMENTATION (Android/iOS)
  //   //   final uri = Uri.parse(url);

  //   //   if (await canLaunchUrl(uri)) {
  //   //     await launchUrl(
  //   //       uri,
  //   //       mode:
  //   //           LaunchMode
  //   //               .externalApplication, // Opens in Chrome/Safari, not in-app WebView
  //   //     );
  //   //   } else {
  //   //     if (!mounted) return;
  //   //     ScaffoldMessenger.of(context).showSnackBar(
  //   //       SnackBar(
  //   //         content: Text('Could not launch payment URL: $url'),
  //   //         backgroundColor: Colors.red,
  //   //       ),
  //   //     );
  //   //   }
  //   //   // }
  //   // } catch (e) {
  //   //   print("Error launching URL: $e");
  //   //   if (!mounted) return;
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(
  //   //       content: Text('Failed to open payment page: $e'),
  //   //       backgroundColor: Colors.red,
  //   //     ),
  //   //   );
  //   // }
  // }

  Future<void> _openPaymentUrl(String paymentUrl) async {
    // 1. First, trim the payment URL to remove any whitespace
    String trimmedPaymentUrl = paymentUrl.trim();

    // 2. Encode the payment URL for the query parameter
    String encodedPaymentUrl = Uri.encodeComponent(trimmedPaymentUrl);

    // 3. Create the redirect page URL
    // Make sure there's no space at the beginning
    String redirectPageUrl =
        "http://192.168.60.17:5501/index.html?url=$encodedPaymentUrl";
    //10.30.236.17
    // 4. Debug: Print URLs to verify
    print("Payment URL: $trimmedPaymentUrl");
    print("Encoded URL: $encodedPaymentUrl");
    print("Redirect Page URL: $redirectPageUrl");

    // 5. Try to launch the URL
    try {
      final uri = Uri.parse(redirectPageUrl.trim()); // Trim here too for safety

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $redirectPageUrl';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Fallback: Try to open the payment URL directly
      try {
        final directUri = Uri.parse(trimmedPaymentUrl);
        if (await canLaunchUrl(directUri)) {
          await launchUrl(directUri, mode: LaunchMode.externalApplication);
        }
      } catch (e2) {
        print('Error with direct URL: $e2');
      }
    }
  }

  Future<void> _getVat() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      if (token == null) throw Exception('No token found');

      final uri = Uri.parse('$base_url_dev/params?filters=name=vat');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          "We're having trouble loading VAT data. Please check your connection and try again.",
        );
      }

      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'].isNotEmpty) {
        final vatData = double.parse(data['data'][0]['value'].toString());
        ref.read(vatProvider.notifier).state = vatData;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching VAT: $e');
      ref.read(vatProvider.notifier).state = 15.0;
    }
  }

  Future<void> _getExchangeRate() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      if (token == null) throw Exception('No token found');

      final uri = Uri.parse('$base_url_dev/params?filters=name=exchange_rate');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          "We're having trouble loading exchange rate data. Please check your connection and try again.",
        );
      }

      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'].isNotEmpty) {
        final exchangeRateData = double.parse(
          data['data'][0]['value'].toString(),
        );
        ref.read(exchangeRateProvider.notifier).state = exchangeRateData;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error fetching exchange rate: $e');
      ref.read(exchangeRateProvider.notifier).state = 55.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Our Packages",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Refresh button
          IconButton(
            icon:
                _isRefreshing
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshAllData,
            color: Colors.black,
          ),
        ],
      ),
      body:
          _isRefreshing && !_hasInitialLoad
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _refreshAllData,
                child: FutureBuilder<List<Subscription>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !_hasInitialLoad) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Error loading subscriptions",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                snapshot.error.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refreshAllData,
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final subscriptions = snapshot.data ?? [];

                    // Define the order of subscription types we want to display
                    final availableTypes = [0, 1, 3, 6, 12];

                    // Filter and sort subscriptions by type
                    final filteredSubscriptions =
                        subscriptions
                            .where((sub) => availableTypes.contains(sub.type))
                            .toList()
                          ..sort((a, b) => a.type.compareTo(b.type));

                    if (filteredSubscriptions.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.subscriptions,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No subscriptions available",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Please check your preferences and try again",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _refreshAllData,
                              child: const Text('Reload'),
                            ),
                          ],
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Display current selection info
                          Consumer(
                            builder: (context, ref, child) {
                              final selectedLevel = ref.watch(
                                selectedLevelProvider,
                              );
                              final selectedModalName = ref.watch(
                                selectedModalNameProvider,
                              );
                              final selectedLevelPrice = ref.watch(
                                selectedLevelPriceProvider,
                              );

                              return Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary.withOpacity(0.12),
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: AppColors.primary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Your Selected Plan',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    if (selectedModalName != null)
                                      Text(
                                        'Service: $selectedModalName',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    if (selectedLevelPrice != null)
                                      Text(
                                        'Level Price: $selectedLevelPrice ETB per session',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    Text(
                                      'Found ${filteredSubscriptions.length} subscription options',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.lightBlue.shade200,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Warning: going back is not allowed once you select a package. Please choose carefully",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredSubscriptions.length,
                              itemBuilder: (context, index) {
                                final subscription =
                                    filteredSubscriptions[index];
                                final typeLabel = _getTypeLabel(
                                  subscription.type,
                                );

                                return SubscriptionCard(
                                  subscription: subscription,
                                  typeLabel: typeLabel,
                                  typeDescription: _getTypeDescription(
                                    subscription.type,
                                  ),
                                  onTap:
                                      () =>
                                          _handleSubscriptionTap(subscription),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}

// Subscription Card Widget (unchanged)
class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final String typeLabel;
  final String typeDescription;
  final VoidCallback onTap;

  const SubscriptionCard({
    Key? key,
    required this.subscription,
    required this.typeLabel,
    required this.typeDescription,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.secondary;
    final priceText = "${subscription.price} ETB";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: secondary,
          child: const Icon(Icons.star, color: Colors.white),
        ),
        title: Text(
          typeLabel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(typeDescription, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 4),
            if (subscription.level != null)
              Text(
                'Level: ${subscription.level!.toUpperCase()}',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              priceText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: secondary,
              ),
            ),
            if (subscription.type != 0)
              const Text(
                'total',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
