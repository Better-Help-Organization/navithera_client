// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:navithera_client/core/constants/base_url.dart';
// import 'package:navithera_client/core/theme/app_colors.dart';
// import 'package:navithera_client/core/theme/app_typography.dart';
// import 'package:navithera_client/core/util/avatar_util.dart';
// import 'package:navithera_client/core/util/photo_viewer.dart';
// import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:navithera_client/core/constants/base_url.dart';
// // import 'package:navithera_client/core/theme/app_colors.dart';
// // import 'package:navithera_client/core/theme/app_typography.dart';
// // import 'package:navithera_client/core/util/avatar_util.dart';
// // import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Add to your auth_models.dart or create a new ratings_models.dart

// class RatingResponse {
//   final List<Rating> data;
//   final String message;
//   final int statusCode;
//   final String method;
//   final String path;
//   final String timestamp;

//   RatingResponse({
//     required this.data,
//     required this.message,
//     required this.statusCode,
//     required this.method,
//     required this.path,
//     required this.timestamp,
//   });

//   factory RatingResponse.fromJson(Map<String, dynamic> json) {
//     return RatingResponse(
//       data:
//           (json['data'] as List).map((item) => Rating.fromJson(item)).toList(),
//       message: json['message'] ?? '',
//       statusCode: json['statusCode'] ?? 0,
//       method: json['method'] ?? '',
//       path: json['path'] ?? '',
//       timestamp: json['timestamp'] ?? '',
//     );
//   }
// }

// class Rating {
//   final String id;
//   final String updatedAt;
//   final String createdAt;
//   final int value;
//   final String comment;
//   final UserModel client;
//   final UserModel therapist;

//   Rating({
//     required this.id,
//     required this.updatedAt,
//     required this.createdAt,
//     required this.value,
//     required this.comment,
//     required this.client,
//     required this.therapist,
//   });

//   factory Rating.fromJson(Map<String, dynamic> json) {
//     return Rating(
//       id: json['id'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       value: json['value'] ?? 0,
//       comment: json['comment'] ?? '',
//       client: UserModel.fromJson(json['client']),
//       therapist: UserModel.fromJson(json['therapist']),
//     );
//   }
// }

// // Add this to your providers file or create a new service

// final therapistRatingsServiceProvider = Provider<TherapistRatingsService>((
//   ref,
// ) {
//   return TherapistRatingsService();
// });

// class TherapistRatingsService {
//   final Dio _dio = Dio();

//   TherapistRatingsService() {
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

//   Future<RatingResponse?> fetchTherapistRatings(String therapistId) async {
//     try {
//       await _attachAuthHeader();

//       final response = await _dio.get(
//         '${base_url_dev}/ratings?filters=therapist.id=$therapistId',
//         //queryParameters: {'filters': 'therapist.id=$therapistId'},
//       );

//       print("responseyyyyyy: ${therapistId}");

//       print("responseyyyyyy: ${response}");

//       if (response.statusCode == 200) {
//         return RatingResponse.fromJson(response.data);
//       }
//       return null;
//     } catch (e) {
//       log("Error fetching therapist ratings: $e");
//       return null;
//     }
//   }
// }

// class TherapistProfileScreen extends ConsumerStatefulWidget {
//   final UserModel therapist;

//   const TherapistProfileScreen({super.key, required this.therapist});

//   @override
//   ConsumerState<TherapistProfileScreen> createState() =>
//       _TherapistProfileScreenState();
// }

// class _TherapistProfileScreenState extends ConsumerState<TherapistProfileScreen>
//     with TickerProviderStateMixin {
//   late final TabController _tabController;
//   late Future<RatingResponse?> _ratingsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _ratingsFuture = _loadRatings();
//   }

//   Future<RatingResponse?> _loadRatings() async {
//     final ratingsService = ref.read(therapistRatingsServiceProvider);
//     return await ratingsService.fetchTherapistRatings(widget.therapist.id);
//   }

//   void _refreshRatings() {
//     setState(() {
//       _ratingsFuture = _loadRatings();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final therapist = widget.therapist;
//     final name = "${therapist.firstName} ${therapist.lastName}".trim();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About $name'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             SliverToBoxAdapter(child: _HeaderArea(therapist: therapist)),
//             SliverPersistentHeader(
//               pinned: true,
//               delegate: _TabBarSliverDelegate(
//                 TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   labelColor: AppColors.primary,
//                   unselectedLabelColor: Colors.grey.shade700,
//                   indicatorColor: AppColors.primary,
//                   labelStyle: AppTypography.bodyMedium.copyWith(
//                     fontWeight: FontWeight.w700,
//                   ),
//                   unselectedLabelStyle: AppTypography.bodyMedium,
//                   tabs: const [Tab(text: 'About me'), Tab(text: 'Reviews')],
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: TabBarView(
//           controller: _tabController,
//           children: [
//             _AboutMeSection(therapist: therapist),

//             _ReviewsSection(
//               ratingsFuture: _ratingsFuture,
//               onRefresh: _refreshRatings,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom delegate for the tab bar to work with NestedScrollView
// class _TabBarSliverDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;

//   _TabBarSliverDelegate(this.tabBar);

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [const Divider(height: 1), tabBar, const Divider(height: 1)],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => tabBar.preferredSize.height + 2;

//   @override
//   double get minExtent => tabBar.preferredSize.height + 2;

//   @override
//   bool shouldRebuild(_TabBarSliverDelegate oldDelegate) {
//     return tabBar != oldDelegate.tabBar;
//   }
// }

// class _HeaderArea extends StatelessWidget {
//   final UserModel therapist;
//   const _HeaderArea({required this.therapist});

//   List<String> _getExpertiseLabels() {
//     if (therapist.expertise == null || therapist.expertise!.isEmpty) {
//       return ['GENERAL THERAPY'];
//     }

//     return therapist.expertise!
//         .map((e) => e.expertise)
//         .where((label) => label != null && label.isNotEmpty)
//         .map((label) => label!.toUpperCase())
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final name = "${therapist.firstName} ${therapist.lastName}".trim();
//     final theme = Theme.of(context);
//     final expertiseLabels = _getExpertiseLabels();

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _CircleAvatar(therapist: therapist, size: 96),
//           const SizedBox(height: 16),

//           Text(
//             name.isEmpty ? 'Therapist' : name,
//             textAlign: TextAlign.center,
//             style: theme.textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.w700,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 16),

//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             alignment: WrapAlignment.center,
//             children:
//                 expertiseLabels
//                     .map((label) => _SoftChip(label: label))
//                     .toList(),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// class _AboutMeSection extends StatelessWidget {
//   final UserModel therapist;
//   const _AboutMeSection({required this.therapist});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//           sliver: SliverList(
//             delegate: SliverChildListDelegate([
//               Text('About me'),
//               const SizedBox(height: 12),
//               Text(
//                 therapist.bio != null && therapist.bio!.isNotEmpty
//                     ? therapist.bio!
//                     : 'No bio available.',
//                 style: AppTypography.bodyMedium.copyWith(
//                   color: Colors.grey.shade800,
//                   height: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 24),

//               if (therapist.expertise != null &&
//                   therapist.expertise!.isNotEmpty) ...[
//                 Text('Areas of Expertise'),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children:
//                       therapist.expertise!
//                           .map(
//                             (expertise) => Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primary.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Text(
//                                 expertise.expertise ?? '',
//                                 style: AppTypography.bodyMedium.copyWith(
//                                   color: AppColors.primary,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                 ),
//                 const SizedBox(height: 24),
//               ],

//               _QuickInfo(therapist: therapist),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ReviewsSection extends ConsumerWidget {
//   final Future<RatingResponse?> ratingsFuture;
//   final VoidCallback onRefresh;

//   const _ReviewsSection({required this.ratingsFuture, required this.onRefresh});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         onRefresh();
//         await Future.delayed(const Duration(milliseconds: 300));
//       },
//       child: FutureBuilder<RatingResponse?>(
//         future: ratingsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return _ReviewsError(onRetry: onRefresh);
//           }

//           final ratings = snapshot.data?.data ?? [];

//           if (ratings.isEmpty) {
//             return _NoReviewsPlaceholder();
//           }

//           return CustomScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//                 sliver: SliverList.separated(
//                   itemCount: ratings.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 16),
//                   itemBuilder: (context, index) {
//                     final rating = ratings[index];
//                     return _ReviewCard(rating: rating);
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _ReviewsError extends StatelessWidget {
//   final VoidCallback onRetry;
//   const _ReviewsError({required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
//             const SizedBox(height: 12),
//             Text(
//               'Failed to load reviews',
//               textAlign: TextAlign.center,
//               style: AppTypography.bodyMedium.copyWith(
//                 color: Colors.grey.shade700,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NoReviewsPlaceholder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.reviews_outlined, size: 64, color: Colors.grey.shade400),
//             const SizedBox(height: 12),
//             Text(
//               'No reviews yet',
//               textAlign: TextAlign.center,
//               style: AppTypography.bodyMedium.copyWith(
//                 color: Colors.grey.shade700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ReviewCard extends StatelessWidget {
//   final Rating rating;
//   const _ReviewCard({required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     // Colors tuned to resemble the screenshot
//     final bg = const Color(0xFFF4F7F2); // soft green-tinted background
//     final border = const Color(0xFFE1E7DD); // subtle greenish border
//     final quoteColor = const Color(0xFF6BA06F); // green accent for quote
//     final textColor = Colors.black.withOpacity(0.85);

//     final formattedDate = _formatDate(rating.createdAt);
//     final therapistName =
//         '${rating.therapist.firstName} ${rating.therapist.lastName}'
//                 .trim()
//                 .isEmpty
//             ? 'the therapist'
//             : '${rating.therapist.firstName} ${rating.therapist.lastName}'
//                 .trim();

//     // If you have duration/issues in API, plug them in here.
//     // Currently we’ll render a generic trailing sentence if no data available.
//     final issuesSummary = _buildIssuesSummary(rating);
//     final durationSummary = _buildDurationSummary(rating);

//     return Container(
//       decoration: ShapeDecoration(
//         color: bg,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18),
//           side: BorderSide(color: border, width: 1),
//         ),
//         shadows: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top row: opening quote and stars to the right
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(Icons.format_quote, color: quoteColor, size: 32),
//               const Spacer(),
//               _StarRatingCompact(value: rating.value),
//             ],
//           ),
//           // Comment
//           if (rating.comment.trim().isNotEmpty) ...[
//             const SizedBox(height: 6),
//             Text(
//               rating.comment.trim(),
//               style: AppTypography.bodyMedium.copyWith(
//                 color: textColor,
//                 height: 1.45,
//                 fontSize: 32,
//               ),
//             ),
//           ],

//           // Meta text
//           const SizedBox(height: 16),
//           Text(
//             'Written on $formattedDate after therapy with $therapistName'
//             '${durationSummary.isNotEmpty ? " $durationSummary" : ""}'
//             '${issuesSummary.isNotEmpty ? " on issues concerning $issuesSummary" : ""}',
//             style: AppTypography.bodySmall.copyWith(
//               color: Colors.grey.shade700,
//               height: 1.45,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(String dateString) {
//     try {
//       final date = DateTime.parse(dateString).toLocal();
//       // Example: Jul 19, 2024
//       final months = [
//         'Jan',
//         'Feb',
//         'Mar',
//         'Apr',
//         'May',
//         'Jun',
//         'Jul',
//         'Aug',
//         'Sep',
//         'Oct',
//         'Nov',
//         'Dec',
//       ];
//       final m = months[date.month - 1];
//       return '$m ${date.day}, ${date.year}';
//     } catch (_) {
//       return dateString;
//     }
//   }

//   // Stub helpers. Replace with real fields if you have them in your API.
//   String _buildDurationSummary(Rating rating) {
//     // Example if you later have rating.durationWeeks: return 'for ${rating.durationWeeks} weeks';
//     return ''; // empty to omit when unknown
//   }

//   String _buildIssuesSummary(Rating rating) {
//     // If you have a list of issues in your API, join them here.
//     // Example: return rating.issues?.join(', ') ?? '';
//     return '';
//   }
// }

// class _StarRatingCompact extends StatelessWidget {
//   final int value;
//   const _StarRatingCompact({required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final capped = value.clamp(0, 5);
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (i) {
//         final filled = i < capped;
//         return Padding(
//           padding: const EdgeInsets.only(left: 2),
//           child: Icon(
//             filled ? Icons.star : Icons.star_border,
//             color: Colors.amber,
//             size: 18,
//           ),
//         );
//       }),
//     );
//   }
// }
// // Keep your existing _PlaceholderSection, _CircleAvatar, _SoftChip, _QuickInfo, _InfoRow classes...
// // They remain the same as in your original code

// class _PlaceholderSection extends StatelessWidget {
//   final String title;
//   const _PlaceholderSection({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//           sliver: SliverList(
//             delegate: SliverChildListDelegate([
//               Text(title),
//               const SizedBox(height: 12),
//               Text(
//                 'Content coming soon.',
//                 style: AppTypography.bodyMedium.copyWith(
//                   color: Colors.grey.shade700,
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class _CircleAvatar extends StatelessWidget {
// //   final UserModel therapist;
// //   final double size;

// //   const _CircleAvatar({required this.therapist, this.size = 96});

// //   @override
// //   Widget build(BuildContext context) {
// //     final hasNetwork =
// //         therapist.avatar == 7 &&
// //         (therapist.profile != null && therapist.profile!.isNotEmpty);

// //     Widget image;
// //     if (hasNetwork) {
// //       image = Image.network(
// //         '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
// //         width: size,
// //         height: size,
// //         fit: BoxFit.cover,
// //         errorBuilder: (context, error, stackTrace) {
// //           return Image.asset(
// //             getAvatarImage(therapist.avatar ?? 0),
// //             width: size,
// //             height: size,
// //             fit: BoxFit.cover,
// //           );
// //         },
// //       );
// //     } else {
// //       image = Image.asset(
// //         getAvatarImage(therapist.avatar ?? 0),
// //         width: size,
// //         height: size,
// //         fit: BoxFit.cover,
// //       );
// //     }

// //     return Container(
// //       width: size,
// //       height: size,
// //       decoration: BoxDecoration(
// //         shape: BoxShape.circle,
// //         border: Border.all(color: Colors.white, width: 3),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: ClipOval(child: image),
// //     );
// //   }
// // }

// class _CircleAvatar extends StatelessWidget {
//   final UserModel therapist;
//   final double size;

//   const _CircleAvatar({required this.therapist, this.size = 96});

//   @override
//   Widget build(BuildContext context) {
//     final hasNetwork =
//         therapist.avatar == 7 &&
//         (therapist.profile != null && therapist.profile!.isNotEmpty);

//     Widget image;
//     if (hasNetwork) {
//       image = Image.network(
//         '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
//         width: size,
//         height: size,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           return Image.asset(
//             getAvatarImage(therapist.avatar ?? 0),
//             width: size,
//             height: size,
//             fit: BoxFit.cover,
//           );
//         },
//       );
//     } else {
//       image = Image.asset(
//         getAvatarImage(therapist.avatar ?? 0),
//         width: size,
//         height: size,
//         fit: BoxFit.cover,
//       );
//     }

//     return GestureDetector(
//       onTap:
//           hasNetwork
//               ? () {
//                 final imageUrl =
//                     '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}';
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder:
//                         (context) => FullScreenImageViewer(
//                           imageUrl: imageUrl,
//                           heroTag: 'therapist-avatar-${therapist.id}',
//                         ),
//                   ),
//                 );
//               }
//               : null,
//       child: Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white, width: 3),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: ClipOval(
//           child: Hero(tag: 'therapist-avatar-${therapist.id}', child: image),
//         ),
//       ),
//     );
//   }
// }

// class _SoftChip extends StatelessWidget {
//   final String label;
//   const _SoftChip({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(color: Colors.black12),
//       ),
//       child: Text(
//         label,
//         style: AppTypography.bodySmall.copyWith(
//           color: Colors.black87,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.2,
//         ),
//       ),
//     );
//   }
// }

// class _QuickInfo extends StatelessWidget {
//   final UserModel therapist;
//   const _QuickInfo({required this.therapist});

//   @override
//   Widget build(BuildContext context) {
//     final items = <Widget>[];

//     if ((therapist.gender ?? '').isNotEmpty) {
//       items.add(
//         _InfoRow(
//           icon: Icons.person_outline,
//           text:
//               '${therapist.gender![0].toUpperCase()}${therapist.gender!.substring(1)}',
//         ),
//       );
//     }
//     // if ((therapist.email).isNotEmpty) {
//     //   items.add(_InfoRow(icon: Icons.mail_outline, text: therapist.email));
//     // }

//     if (items.isEmpty) return const SizedBox.shrink();

//     return Container(
//       margin: const EdgeInsets.only(top: 4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           for (int i = 0; i < items.length; i++) ...[
//             if (i != 0) Divider(height: 1, color: Colors.grey.shade200),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               child: items[i],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   const _InfoRow({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: Colors.grey.shade700),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             text,
//             style: AppTypography.bodyMedium.copyWith(
//               color: Colors.grey.shade800,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/theme/app_typography.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/core/util/photo_viewer.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Add to your auth_models.dart or create a new ratings_models.dart

class RatingResponse {
  final List<Rating> data;
  final String message;
  final int statusCode;
  final String method;
  final String path;
  final String timestamp;

  RatingResponse({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      data:
          (json['data'] as List).map((item) => Rating.fromJson(item)).toList(),
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      method: json['method'] ?? '',
      path: json['path'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}

class Rating {
  final String id;
  final String updatedAt;
  final String createdAt;
  final int value;
  final String comment;
  final UserModel client;
  final UserModel therapist;

  Rating({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.value,
    required this.comment,
    required this.client,
    required this.therapist,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      value: json['value'] ?? 0,
      comment: json['comment'] ?? '',
      client: UserModel.fromJson(json['client']),
      therapist: UserModel.fromJson(json['therapist']),
    );
  }
}

// Add this to your providers file or create a new service

final therapistRatingsServiceProvider = Provider<TherapistRatingsService>((
  ref,
) {
  return TherapistRatingsService();
});

class TherapistRatingsService {
  final Dio _dio = Dio();

  TherapistRatingsService() {
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

  Future<RatingResponse?> fetchTherapistRatings(String therapistId) async {
    try {
      await _attachAuthHeader();

      final response = await _dio.get(
        '${base_url_dev}/ratings?filters=therapist.id=$therapistId',
      );

      print("responseyyyyyy: ${therapistId}");
      print("responseyyyyyy: ${response}");

      if (response.statusCode == 200) {
        return RatingResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      log("Error fetching therapist ratings: $e");
      return null;
    }
  }
}

class TherapistProfileScreen extends ConsumerStatefulWidget {
  final UserModel therapist;

  const TherapistProfileScreen({super.key, required this.therapist});

  @override
  ConsumerState<TherapistProfileScreen> createState() =>
      _TherapistProfileScreenState();
}

class _TherapistProfileScreenState
    extends ConsumerState<TherapistProfileScreen> {
  late Future<RatingResponse?> _ratingsFuture;

  @override
  void initState() {
    super.initState();
    _ratingsFuture = _loadRatings();
  }

  Future<RatingResponse?> _loadRatings() async {
    final ratingsService = ref.read(therapistRatingsServiceProvider);
    return await ratingsService.fetchTherapistRatings(widget.therapist.id);
  }

  void _refreshRatings() {
    setState(() {
      _ratingsFuture = _loadRatings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapist;
    log("right here and heretherapist: ${therapist.expertise}");

    return Scaffold(
      appBar: AppBar(
        title: Text('About ${therapist.firstName}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshRatings();
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(child: _HeaderArea(therapist: therapist)),

            // About Me Section
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              sliver: SliverToBoxAdapter(
                child: _AboutMeSection(therapist: therapist),
              ),
            ),

            // Reviews Section Header
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              sliver: SliverToBoxAdapter(child: Text('Reviews')),
            ),

            // Reviews List
            _ReviewsList(
              ratingsFuture: _ratingsFuture,
              onRefresh: _refreshRatings,
            ),

            // Bottom padding
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _HeaderArea extends StatelessWidget {
  final UserModel therapist;
  const _HeaderArea({required this.therapist});

  List<String> _getExpertiseLabels() {
    print("ssjj ${therapist.expertise}");
    if (therapist.expertise == null || therapist.expertise!.isEmpty) {
      return ['GENERAL THERAPY'];
    }

    return therapist.expertise!
        .map((e) => e.expertise)
        .where((label) => label != null && label.isNotEmpty)
        .map((label) => label!.toUpperCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final name = "${therapist.firstName} ${therapist.lastName}".trim();
    print("ssjj therapist name $therapist");
    final theme = Theme.of(context);
    final expertiseLabels = _getExpertiseLabels();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CircleAvatar(therapist: therapist, size: 96),
          const SizedBox(height: 16),

          Text(
            name.isEmpty ? 'Therapist' : name,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          if (therapist.gender != null && therapist.gender!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '${therapist.gender![0].toUpperCase()}${therapist.gender!.substring(1)} Therapist',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children:
                expertiseLabels
                    .map((label) => _SoftChip(label: label))
                    .toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AboutMeSection extends StatelessWidget {
  final UserModel therapist;
  const _AboutMeSection({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          // style: AppTypography.headlineSmall?.copyWith(
          //   fontWeight: FontWeight.w700,
          // ),
        ),
        const SizedBox(height: 16),
        Text(
          therapist.bio != null && therapist.bio!.isNotEmpty
              ? therapist.bio!
              : 'No bio available.',
          style: AppTypography.bodyMedium.copyWith(
            color: Colors.grey.shade800,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        if (therapist.expertise != null && therapist.expertise!.isNotEmpty) ...[
          Text('Areas of Expertise'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                therapist.expertise!
                    .map(
                      (expertise) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          expertise.expertise ?? '',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 24),
        ],

        _QuickInfo(therapist: therapist),
      ],
    );
  }
}

class _ReviewsList extends ConsumerWidget {
  final Future<RatingResponse?> ratingsFuture;
  final VoidCallback onRefresh;

  const _ReviewsList({required this.ratingsFuture, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<RatingResponse?>(
      future: ratingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(child: _ReviewsError(onRetry: onRefresh));
        }

        final ratings = snapshot.data?.data ?? [];

        if (ratings.isEmpty) {
          return SliverToBoxAdapter(child: _NoReviewsPlaceholder());
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          sliver: SliverList.separated(
            itemCount: ratings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final rating = ratings[index];
              return _ReviewCard(rating: rating);
            },
          ),
        );
      },
    );
  }
}

class _ReviewsError extends StatelessWidget {
  final VoidCallback onRetry;
  const _ReviewsError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'Failed to load reviews',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
        ],
      ),
    );
  }
}

class _NoReviewsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.reviews_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'No reviews yet',
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share your experience',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Rating rating;
  const _ReviewCard({required this.rating});

  @override
  Widget build(BuildContext context) {
    // Colors tuned to resemble the screenshot
    final bg = const Color(0xFFF4F7F2); // soft green-tinted background
    final border = const Color(0xFFE1E7DD); // subtle greenish border
    final quoteColor = const Color(0xFF6BA06F); // green accent for quote
    final textColor = Colors.black.withOpacity(0.85);

    final formattedDate = _formatDate(rating.createdAt);
    final therapistName =
        '${rating.therapist.firstName} ${rating.therapist.lastName}'
                .trim()
                .isEmpty
            ? 'the therapist'
            : '${rating.therapist.firstName} ${rating.therapist.lastName}'
                .trim();

    // If you have duration/issues in API, plug them in here.
    // Currently we'll render a generic trailing sentence if no data available.
    final issuesSummary = _buildIssuesSummary(rating);
    final durationSummary = _buildDurationSummary(rating);

    return Container(
      decoration: ShapeDecoration(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: border, width: 1),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: opening quote and stars to the right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.format_quote, color: quoteColor, size: 32),
              const Spacer(),
              _StarRatingCompact(value: rating.value),
            ],
          ),
          // Comment
          if (rating.comment.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              rating.comment.trim(),
              style: AppTypography.bodyMedium.copyWith(
                color: textColor,
                height: 1.45,
                fontSize: 16,
              ),
            ),
          ],

          // Meta text
          const SizedBox(height: 16),
          Text(
            'Written on $formattedDate after therapy with $therapistName'
            '${durationSummary.isNotEmpty ? " $durationSummary" : ""}'
            '${issuesSummary.isNotEmpty ? " on issues concerning $issuesSummary" : ""}',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.grey.shade700,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      // Example: Jul 19, 2024
      final months = [
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
      final m = months[date.month - 1];
      return '$m ${date.day}, ${date.year}';
    } catch (_) {
      return dateString;
    }
  }

  // Stub helpers. Replace with real fields if you have them in your API.
  String _buildDurationSummary(Rating rating) {
    // Example if you later have rating.durationWeeks: return 'for ${rating.durationWeeks} weeks';
    return ''; // empty to omit when unknown
  }

  String _buildIssuesSummary(Rating rating) {
    // If you have a list of issues in your API, join them here.
    // Example: return rating.issues?.join(', ') ?? '';
    return '';
  }
}

class _StarRatingCompact extends StatelessWidget {
  final int value;
  const _StarRatingCompact({required this.value});

  @override
  Widget build(BuildContext context) {
    final capped = value.clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < capped;
        return Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 18,
          ),
        );
      }),
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  final UserModel therapist;
  final double size;

  const _CircleAvatar({required this.therapist, this.size = 96});

  @override
  Widget build(BuildContext context) {
    final hasNetwork =
        therapist.avatar == 7 &&
        (therapist.profile != null && therapist.profile!.isNotEmpty);

    Widget image;
    if (hasNetwork) {
      image = Image.network(
        '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            getAvatarImage(therapist.avatar ?? 0),
            width: size,
            height: size,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      image = Image.asset(
        getAvatarImage(therapist.avatar ?? 0),
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () {
        if (hasNetwork) {
          final imageUrl = '${base_url_for_image}${therapist.profile}?v=${DateTime.now().millisecondsSinceEpoch}';
          Navigator.of(context).push(
            MaterialPageRoute(
               builder: (context) => FullScreenImageViewer(
                 imageUrl: imageUrl,
                 heroTag: 'therapist-avatar-${therapist.id}',
                 isAsset: false,
               ),
            ),
          );
        } else {
          final assetUrl = getAvatarImage(therapist.avatar ?? 0);
          Navigator.of(context).push(
            MaterialPageRoute(
               builder: (context) => FullScreenImageViewer(
                 imageUrl: assetUrl,
                 heroTag: 'therapist-avatar-${therapist.id}',
                 isAsset: true,
               ),
            ),
          );
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: Hero(tag: 'therapist-avatar-${therapist.id}', child: image),
        ),
      ),
    );
  }
}

class _SoftChip extends StatelessWidget {
  final String label;
  const _SoftChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _QuickInfo extends StatelessWidget {
  final UserModel therapist;
  const _QuickInfo({required this.therapist});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    // if ((therapist.gender ?? '').isNotEmpty) {
    //   items.add(
    //     _InfoRow(
    //       icon: Icons.person_outline,
    //       text:
    //           '${therapist.gender![0].toUpperCase()}${therapist.gender!.substring(1)}',
    //     ),
    //   );
    // }

    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      //margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i != 0) Divider(height: 1, color: Colors.grey.shade200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: items[i],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }
}
