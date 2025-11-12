// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;
// import 'package:navithera_client/core/constants/base_url.dart';
// import 'package:navithera_client/core/theme/app_colors.dart';
// import 'package:navithera_client/core/util/format_duration.dart';
// import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Add VAT provider
// final vatProvider = StateProvider<double?>((ref) => null);
// final exchangeRateProvider = StateProvider<double?>((ref) => null);

// // Add this to your providers file or create a new one
// final userPreferencesProvider = FutureProvider<Map<String, dynamic>?>((
//   ref,
// ) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('access_token');
//   if (token == null) throw Exception('No token found');

//   final uri = Uri.parse(
//     '$base_url_dev/client/me/preferences?fields=level.*&sort=createdAt=desc',
//   );
//   final response = await http.get(
//     uri,
//     headers: {'Authorization': 'Bearer $token'},
//   );

//   if (response.statusCode != 200) {
//     throw Exception(
//       "We're having trouble loading your preference. Please check your connection and try again.",
//     );
//   }

//   final data = jsonDecode(response.body);
//   if (data['data'] != null && data['data'].isNotEmpty) {
//     final levelData = data['data'][0]['level'];
//     return {
//       'levelId': levelData['id'],
//       'levelType': levelData['type'],
//       'levelPrice': levelData['price'].toString(),
//     };
//   }
//   return null;
// });

// class Subscription {
//   final String id;
//   final int type; // 0=free,1=monthly,3=quarterly
//   final int price;
//   final String level;
//   final String levelId;

//   Subscription({
//     required this.id,
//     required this.type,
//     required this.price,
//     required this.level,
//     required this.levelId,
//   });

//   // factory Subscription.fromJson(Map<String, dynamic> json) {
//   //   return Subscription(
//   //     id: json['id'],
//   //     type: json['type'],
//   //     price: json['price'],
//   //     level: json['level']['type'],
//   //     levelId: json['level']['id'],
//   //   );
//   // }
//   factory Subscription.fromJson(Map<String, dynamic> json) {
//     // Use the null-aware operator (?.) to check if json['level'] is null.
//     // If it is null, the expression short-circuits to null,
//     // and the null-coalescing operator (??) provides a default value.

//     final levelMap = json['level'] as Map<String, dynamic>?;

//     return Subscription(
//       id: json['id'],
//       type: json['type'],
//       price: json['price'],
//       // Safely access 'type'. If levelMap is null, default to 'N/A' or a placeholder.
//       level: levelMap?['type'] as String? ?? 'N/A',
//       // Safely access 'id'. If levelMap is null, default to an empty string.
//       levelId: levelMap?['id'] as String? ?? '',
//     );
//   }
// }

// class SubscriptionService {
//   static Future<List<Subscription>> fetchSubscriptions() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//     if (token == null) throw Exception('No token found');

//     final uri = Uri.parse(
//       '$base_url_dev/subscription?fields=price%2Ctype%2Clevel.%2A',
//     );
//     final response = await http.get(
//       uri,
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed: ${response.body}');
//     }

//     final data = jsonDecode(response.body)['data'] as List;
//     print("Bearerxoxo: ${data}");
//     return data.map((e) => Subscription.fromJson(e)).toList();
//   }

//   static Future<String> createSubscription({
//     required int type,
//     required int price,
//     required String levelId,
//     int? oldPrice,
//     required String startDate,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('access_token');
//     if (token == null) throw Exception('No token found');

//     final uri = Uri.parse('$base_url_dev/subscription');

//     final body = json.encode({
//       'type': type,
//       'price': price * 4,
//       'levelId': levelId,
//       'old_price': 100000,
//       'start_date': startDate,
//     });

//     print("Request Body: $body");

//     final response = await http.post(
//       uri,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: body,
//     );

//     print("response: ${response.body}");

//     if (response.statusCode != 201) {
//       throw Exception('Failed to create subscription: ${response.body}');
//     }

//     final responseData = jsonDecode(response.body);
//     return responseData['data']['id'];
//   }
// }

// class SubscriptionPage extends ConsumerStatefulWidget {
//   const SubscriptionPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<SubscriptionPage> createState() => _SubscriptionPageState();
// }

// class _SubscriptionPageState extends ConsumerState<SubscriptionPage> {
//   late Future<List<Subscription>> _future;
//   String _selectedLevel = "associate";
//   bool _isCreatingSubscription = false;
//   bool _isLoadingPreferences = false;

//   @override
//   void initState() {
//     super.initState();
//     _future = SubscriptionService.fetchSubscriptions();
//     _checkUserPreferences();
//     _getVat();
//     _getExchangeRate();
//   }

//   String _getTypeLabel(int type) {
//     switch (type) {
//       case 0:
//         return 'Trial';
//       case 1:
//         return 'Monthly';
//       case 3:
//         return 'Quarterly';
//       case 6:
//         return 'Semi-Annual';
//       case 12:
//         return 'Yearly';
//       default:
//         return 'Unknown';
//     }
//   }

//   // Calculate price with time span multiplier, VAT, and currency conversion
//   int _calculateFinalPrice(
//     int basePrice,
//     int type,
//     double vatRate,
//     double exchangeRate,
//   ) {
//     if (type == 0) return 0; // Free trial

//     // Multiply by time span
//     int timeMultipliedPrice = basePrice * type;

//     // Apply VAT
//     double priceWithVat = timeMultipliedPrice * (1 + (vatRate));

//     // Convert to ETB using exchange rate (assuming basePrice is in USD)
//     double priceInEtb = priceWithVat * exchangeRate;

//     // Round to nearest integer
//     return priceInEtb.round();
//   }

//   Future<void> _handleSubscriptionTap(Subscription subscription) async {
//     setState(() {
//       _isCreatingSubscription = true;
//     });

//     try {
//       // Calculate start date (10 minutes from now)
//       final startDate = DateTime.now().add(const Duration(minutes: 10));
//       final formattedStartDate =
//           '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';

//       final selectedLevel = ref.read(selectedLevelProvider);
//       final selectedLevelPrice = ref.read(selectedLevelPriceProvider);
//       final vatRate = ref.read(vatProvider) ?? 0;
//       final exchangeRate = ref.read(exchangeRateProvider) ?? 1;

//       print("Selected level from provider: $selectedLevel");
//       print("Selected level price from provider: $selectedLevelPrice");
//       print("VAT rate: $vatRate%");
//       print("Exchange rate: $exchangeRate");

//       // Get the actual price from provider or use subscription price as fallback
//       final basePrice =
//           selectedLevelPrice != null
//               ? int.parse(selectedLevelPrice)
//               : subscription.price;

//       // Calculate final price with time span, VAT, and currency conversion
//       final finalPrice = _calculateFinalPrice(
//         basePrice,
//         subscription.type,
//         vatRate,
//         exchangeRate,
//       );
//       final oldPrice = _calculateFinalPrice(
//         580,
//         subscription.type,
//         vatRate,
//         exchangeRate,
//       );

//       // Create subscription
//       final subscriptionId = await SubscriptionService.createSubscription(
//         type: subscription.type,
//         price: finalPrice,
//         levelId: selectedLevel ?? subscription.levelId,
//         // oldPrice: oldPrice,
//         startDate: formattedStartDate,
//       );
//       final providerId = ref.read(selectedPrefProvider);

//       // Navigate to payment page with the created subscription ID
//       // context.push('/payment', extra: subscriptionId);
//       context.go('/payment?preferenceId=$providerId', extra: subscriptionId);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to create subscription: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isCreatingSubscription = false;
//       });
//     }
//   }

//   Future<void> _checkUserPreferences() async {
//     final selectedLevel = ref.read(selectedLevelProvider);
//     final selectedLevelPrice = ref.read(selectedLevelPriceProvider);

//     // If either is null, fetch from API
//     if (selectedLevel == null || selectedLevelPrice == null) {
//       setState(() {
//         _isLoadingPreferences = true;
//       });

//       try {
//         final preferences = await ref.read(userPreferencesProvider.future);

//         print("Fetched preferences: $preferences");

//         if (preferences != null) {
//           ref.read(selectedLevelProvider.notifier).state =
//               preferences['levelId'];
//           ref.read(selectedLevelPriceProvider.notifier).state =
//               preferences['levelPrice'];

//           print("Fetched level from API: ${preferences['levelId']}");
//           print("Fetched level price from API: ${preferences['levelPrice']}");
//         }
//       } catch (e) {
//         print("Error fetching user preferences: $e");
//       } finally {
//         setState(() {
//           _isLoadingPreferences = false;
//         });
//       }
//     }
//   }

//   Future<void> _getVat() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('access_token');
//       if (token == null) throw Exception('No token found');

//       final uri = Uri.parse('$base_url_dev/params?filters=name=vat');
//       final response = await http.get(
//         uri,
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode != 200) {
//         throw Exception(
//           "We're having trouble loading the data you're looking for. Please check your connection and try again.",
//         );
//       }

//       final data = jsonDecode(response.body);
//       print("vat data: $data");
//       if (data['data'] != null && data['data'].isNotEmpty) {
//         final vatData = double.parse(data['data'][0]['value'].toString());
//         print("vat value: $vatData");
//         ref.read(vatProvider.notifier).state = vatData;
//       }
//     } catch (e) {
//       print("Error fetching VAT: $e");
//       // Set default VAT if API fails
//       ref.read(vatProvider.notifier).state = 15.0; // Default 15% VAT
//     }
//   }

//   Future<void> _getExchangeRate() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('access_token');
//       if (token == null) throw Exception('No token found');

//       final uri = Uri.parse('$base_url_dev/params?filters=name=exchange_rate');
//       final response = await http.get(
//         uri,
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode != 200) {
//         throw Exception(
//           "We're having trouble loading the data you're looking for. Please check your connection and try again.",
//         );
//       }

//       final data = jsonDecode(response.body);
//       print("exchange rate data: $data");
//       if (data['data'] != null && data['data'].isNotEmpty) {
//         final exchangeRateData = double.parse(
//           data['data'][0]['value'].toString(),
//         );
//         print("exchange rate value: $exchangeRateData");
//         ref.read(exchangeRateProvider.notifier).state = exchangeRateData;
//       }
//     } catch (e) {
//       print("Error fetching exchange rate: $e");
//       // Set default exchange rate if API fails
//       ref.read(exchangeRateProvider.notifier).state =
//           55.0; // Default 55 ETB per USD
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Our Packages",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body:
//           _isLoadingPreferences
//               ? const Center(child: CircularProgressIndicator())
//               : _isCreatingSubscription
//               ? const Center(child: CircularProgressIndicator())
//               : FutureBuilder<List<Subscription>>(
//                 future: _future,
//                 builder: (context, snapshot) {
//                   final selectedLevel = ref.read(selectedLevelProvider);
//                   final selectedLevelPrice = ref.read(
//                     selectedLevelPriceProvider,
//                   );
//                   final vatRate = ref.watch(vatProvider) ?? 0;
//                   final exchangeRate = ref.watch(exchangeRateProvider) ?? 1;

//                   print("Selected level in build: $selectedLevel");
//                   print("Selected level price in build: $selectedLevelPrice");
//                   print("VAT rate in build: $vatRate%");
//                   print("Exchange rate in build: $exchangeRate");

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return Center(child: Text("Error: ${snapshot.error}"));
//                   }

//                   final subs = snapshot.data!;
//                   final availableTypes = [0, 1, 3, 6, 12];

//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: availableTypes.length,
//                             itemBuilder: (context, index) {
//                               final typeId = availableTypes[index];
//                               final typeLabel = _getTypeLabel(typeId);

//                               // Use the level from provider or default to first available
//                               final currentLevel = selectedLevel ?? "associate";
//                               final basePrice =
//                                   selectedLevelPrice != null
//                                       ? int.parse(selectedLevelPrice!)
//                                       : 499;

//                               Subscription sub;
//                               try {
//                                 sub = subs.firstWhere(
//                                   (s) =>
//                                       s.level == currentLevel &&
//                                       s.type == typeId,
//                                 );
//                               } catch (e) {
//                                 // Create placeholder with level ID from first subscription
//                                 final levelSub = subs.firstWhere(
//                                   (s) => s.level == currentLevel,
//                                   orElse: () => subs.first,
//                                 );
//                                 sub = Subscription(
//                                   id: '',
//                                   type: typeId,
//                                   price: _calculateFinalPrice(
//                                     basePrice,
//                                     typeId,
//                                     vatRate,
//                                     exchangeRate,
//                                   ),
//                                   level: currentLevel,
//                                   levelId: levelSub.levelId,
//                                 );
//                               }

//                               return SubscriptionCard(
//                                 ref: ref,
//                                 price: basePrice,
//                                 subscription: sub,
//                                 typeLabel: typeLabel,
//                                 vatRate: vatRate,
//                                 exchangeRate: exchangeRate,
//                                 onTap: () => _handleSubscriptionTap(sub),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//     );
//   }
// }

// class SubscriptionCard extends StatelessWidget {
//   final Subscription subscription;
//   final String typeLabel;
//   final VoidCallback onTap;
//   final int price;
//   final WidgetRef ref;
//   final double vatRate;
//   final double exchangeRate;

//   const SubscriptionCard({
//     Key? key,
//     required this.subscription,
//     required this.typeLabel,
//     required this.onTap,
//     required this.price,
//     required this.ref,
//     required this.vatRate,
//     required this.exchangeRate,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final secondary = AppColors.secondary;

//     // Calculate final price for display
//     int calculateDisplayPrice(int basePrice, int type) {
//       if (type == 0) return 0;

//       int timeMultipliedPrice = basePrice * type;

//       double priceWithVat = timeMultipliedPrice * (1 + (vatRate));

//       double priceInEtb = priceWithVat * exchangeRate;

//       return priceInEtb.round();
//     }

//     String _getTypeDescription(int type) {
//       switch (type) {
//         case 0:
//           return '1 session - Perfect for trying our service';
//         case 1:
//           return '4 sessions - Great for getting started';
//         case 3:
//           return '12 sessions - Ideal for consistent progress';
//         case 6:
//           return '24 sessions - Best value for dedicated users';
//         case 12:
//           return '52 sessions - Ultimate commitment with maximum savings';
//         default:
//           return 'Subscription plan';
//       }
//     }

//     final displayPrice =
//         subscription.type == 0
//             ? calculateDisplayPrice(price, 1)
//             : calculateDisplayPrice(price, subscription.type) * 4;
//     final priceText = "$displayPrice ETB";

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x11000000),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: secondary,
//           child: const Icon(Icons.star, color: Colors.white),
//         ),
//         title: Text(
//           typeLabel,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               //'A simple description for the ${typeLabel.toLowerCase()} plan.',
//               _getTypeDescription(subscription.type),
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//             SizedBox(height: 4),
//           ],
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               '${formatPrice(priceText)} ETB',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: secondary,
//               ),
//             ),
//             if (subscription.type != 0)
//               const Text(
//                 'total',
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//           ],
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Providers
final vatProvider = StateProvider<double?>((ref) => null);
final exchangeRateProvider = StateProvider<double?>((ref) => null);

// Keep as FutureProvider but use ref.refresh for force reload
final userPreferencesProvider = FutureProvider<Map<String, dynamic>?>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
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
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
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

    print("response: ${response.body}");

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
        return '52 sessions - Ultimate commitment with maximum savings';
      default:
        return 'Subscription plan';
    }
  }

  void _handleSubscriptionTap(Subscription subscription) async {
    final subscriptionId = subscription.id;
    final providerId = ref.read(selectedPrefProvider);

    final finalsubscriptionId = await SubscriptionService.createSubscription(
      subscriptionId: subscriptionId,
    );

    print("Selected subscription ID: $finalsubscriptionId");
    print("Selected provider ID: $providerId");
    print("Navigating to payment page with subscription ID");

    context.go('/payment?preferenceId=$providerId', extra: finalsubscriptionId);
  }

  Future<void> _getVat() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
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
      print("Error fetching VAT: $e");
      ref.read(vatProvider.notifier).state = 15.0;
    }
  }

  Future<void> _getExchangeRate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
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
      print("Error fetching exchange rate: $e");
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
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue[100]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: Colors.blue[600],
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Your Selected Plan',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
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
