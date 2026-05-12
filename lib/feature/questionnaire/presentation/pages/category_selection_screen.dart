import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/questions_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../providers/modals_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategorySelectionScreen extends ConsumerStatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  ConsumerState<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState
    extends ConsumerState<CategorySelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Load modals when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(modalsProvider.notifier).loadModals();
    });
  }

  // Helper method to get icon based on category name
  IconData _getCategoryIcon(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('teen')) return Icons.school;
    if (lowerName.contains('individual')) return Icons.person;
    if (lowerName.contains('couple')) return Icons.favorite;
    if (lowerName.contains('group')) return Icons.group;
    return Icons.psychology; // Default icon
  }

  // Helper method to get color based on category name
  Color _getCategoryColor(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('teen')) return const Color(0xFF7EB09B);
    if (lowerName.contains('individual')) return const Color(0xFF4A90E2);
    if (lowerName.contains('couple')) return const Color(0xFFE91E63);
    if (lowerName.contains('group')) return const Color(0xFF9B59B6);
    return const Color(0xFFE67E22); // Default color
  }

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  @override
  Widget build(BuildContext context) {
    final modalsAsync = ref.watch(modalsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose Your Category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 56),
                child: Text(
                  'Select the category that best describes you to get personalized questions.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Categories Grid
              Expanded(
                child: modalsAsync.when(
                  loading:
                      () => const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF7EB09B),
                          ),
                        ),
                      ),
                  error:
                      (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Color(0xFFE53E3E),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Failed to load categories',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF718096),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(modalsProvider.notifier).loadModals();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7EB09B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                  data: (modalsResponse) {
                    final user = ref.watch(currentUserProvider);
                    final categories = modalsResponse.data;

                    if (categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'No categories available',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF718096),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CategoryListCard(
                            category: {
                              'id': category.id,
                              'name': category.name,
                              'description': category.description,
                              'icon': _getCategoryIcon(category.name),
                              'color': _getCategoryColor(category.name),
                              //'color': Colors.white,
                            },
                            onTap: () {
                              Future<void> _checkIfPrefFilled() async {
                                final accessToken = await _secureStorage.read(key: 
                                  'access_token',
                                );

                                try {
                                  final dio = Dio();
                                  dio.options.headers['Authorization'] =
                                      'Bearer $accessToken';

                                  final response = await dio.get(
                                    '${base_url_dev}/client/me/preferences?fields=modal.*&filters=modal.id=${category.id}',
                                  );

                                  // print("responsexoxo: ${response.data}");

                                  if (response.statusCode == 200) {
                                    ref
                                        .read(userAnswersProvider.notifier)
                                        .clearAnswers();
                                    ref.read(modalIdProvider.notifier).state =
                                        category.id;
                                    ref
                                        .read(
                                          selectedLanguagesProvider.notifier,
                                        )
                                        .state = [];
                                    ref
                                        .read(
                                          showOtherLanguageInputProvider
                                              .notifier,
                                        )
                                        .state = false;

                                    // Reset level provider
                                    ref
                                        .read(selectedLevelProvider.notifier)
                                        .state = null;

                                    // Reset gender provider
                                    ref
                                        .read(selectedGenderProvider.notifier)
                                        .state = null;

                                    // Reset availability provider
                                    ref
                                        .read(
                                          selectedAvailabilityProvider.notifier,
                                        )
                                        .state = [];

                                    ref.read(goalsProvider.notifier).state = '';
                                    // print("responsexoxo ${category.name}");
                                    // Check if data array is not empty
                                    final responseData = response.data;
                                    if (responseData['data'] != null &&
                                        responseData['data'].isNotEmpty) {
                                      print("responseXoxo here 1");
                                      // print(
                                      //   "preference exists: ${responseData['data'][0]['id']}",
                                      // );

                                      if (category.name == 'Group Therapy') {
                                        final router = ref.read(routerProvider);
                                        router.go('/subscription');
                                        return;
                                      }
                                      final router = ref.read(routerProvider);
                                      // router.push(
                                      //   '/language-selection?prefId=${responseData['data'][0]['id']}',
                                      // );
                                      router.push(
                                        '/language-selection?prefId=${responseData['data'][0]['id']}',
                                      );

                                      // print("hello");
                                    } else {
                                      final router = ref.read(routerProvider);
                                      router.push(
                                        '/questionnaire?category=${category.id}',
                                      );
                                    }

                                    if (!mounted) return;
                                    // Your existing navigation code here...
                                  } else {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('an error occured'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } on DioException catch (e) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Error: ${e.response?.data['message'] ?? e.message}',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } catch (e) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'An unexpected error occurred',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }

                              _checkIfPrefFilled();

                              // print("perfect user: ${user?.preferences}");
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryListCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onTap;

  const CategoryListCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //color: AppColors.primary.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  size: 28,
                  color: category['color'] as Color,
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['name'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                        //color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['description'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2D3748),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Keep the original CategoryCard for backward compatibility if needed
class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  size: 32,
                  color: category['color'] as Color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                category['name'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                category['description'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF718096),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
