import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/questions_provider.dart';
import 'package:navithera_client/feature/questionnaire/presentation/widgets/progress_indicator.dart';

const Set<String> specialModalIds = {
  'c372808e-7d34-43f9-97d5-57adfd7ba5bc', // Group Therapy
  '8a08b922-60c1-4189-b243-e480ecbf1243'
};

final numQuestionsProvider = StateProvider<int>((ref) => 0);

class ExtraQuestionsScreen extends ConsumerStatefulWidget {
  final String? preferenceId;

  const ExtraQuestionsScreen({
    super.key,
    this.preferenceId, // Make it optional
  });

  @override
  ConsumerState<ExtraQuestionsScreen> createState() =>
      _ExtraQuestionsScreenState();
}

class _ExtraQuestionsScreenState extends ConsumerState<ExtraQuestionsScreen> {
  // static const int maxAvailabilitySlots = 5;
  final List<String> sessionFormats = ['Video', 'Phone', 'Text'];
  final List<String> genders = ['Male', 'Female'];

  final List<String> workingDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final List<String> workingHours = [];
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController _otherLangController = TextEditingController();

  late final PageController _pageController;
  int _currentIndex = 0;
  bool _isLoading = false; // for Complete button loading state

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(currentUserProvider);
      print('Initial user state in ExtraQuestionsScreen: $user');
      ref.read(languagesProvider.notifier).loadLanguages();

      ///ref.read(languagesProvider.notifier).loadlevels();
      ref.read(levelsProvider.notifier).loadLevels();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _otherLangController.dispose();
    goalsController.dispose();
    super.dispose();
  }

  int get totalPages {
    final modalId = ref.read(modalIdProvider);
    return (modalId != null && specialModalIds.contains(modalId)) ? 4 : 5;
  }

  List<Widget> get pages {
    final modalId = ref.read(modalIdProvider);
    final isSpecial = modalId != null && specialModalIds.contains(modalId);

    if (isSpecial) {
      // Skip levels page (4 pages total)
      return [
        wrapWithContainer(_buildLanguagesContent()),
        _buildAvailabilityContent(),
        wrapWithContainer(_buildGoalsContent()),
        wrapWithContainer(_buildGenderContent()),
      ];
    } else {
      // Include all pages (5 pages total)
      return [
        wrapWithContainer(_buildLanguagesContent()),
        wrapWithContainer(_buildLevelsContent()),
        _buildAvailabilityContent(),
        wrapWithContainer(_buildGoalsContent()),
        wrapWithContainer(_buildGenderContent()),
      ];
    }
  }

  bool _isPageValid(int index) {
    final modalId = ref.read(modalIdProvider);
    final isSpecialModal = modalId != null && specialModalIds.contains(modalId);

    switch (index) {
      case 0: // languages (always first)
        final selected = ref.read(selectedLanguagesProvider);
        if (selected.isEmpty) return false;

        final hasOther = selected.contains('other');
        if (hasOther) {
          final otherLangText = ref.read(otherLanguageProvider).trim();
          return otherLangText.isNotEmpty;
        }
        return true;

      case 1: // levels OR availability (depending on modal)
        if (!isSpecialModal) {
          return ref.read(selectedLevelProvider) != null;
        } else {
          return ref.read(selectedAvailabilityProvider).isNotEmpty;
        }

      case 2: // availability OR goals (depending on modal)
        if (!isSpecialModal) {
          return ref.read(selectedAvailabilityProvider).isNotEmpty;
        } else {
          return ref.read(goalsProvider).trim().isNotEmpty;
        }

      case 3: // goals OR gender (depending on modal)
        if (!isSpecialModal) {
          return ref.read(goalsProvider).trim().isNotEmpty;
        } else {
          return ref.read(selectedGenderProvider) != null;
        }

      case 4: // gender (only in normal flow)
        return ref.read(selectedGenderProvider) != null;

      default:
        return false;
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      final newIndex = _currentIndex - 1;
      setState(() => _currentIndex = newIndex);
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If on the first page, navigate back
      Navigator.of(context).pop();
    }
  }

  Future<void> _nextQuestion() async {
    final totalPagesCount = totalPages;

    if (_currentIndex < totalPagesCount - 1) {
      final newIndex = _currentIndex + 1;
      setState(() => _currentIndex = newIndex);
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() => _isLoading = true);
      await _handleSubmit();
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSubmit() async {
    final cleanedSelectedLanguages = ref.read(cleanedLanguageIdsProvider);
    final selectedLevel = ref.read(selectedLevelProvider);
    final selectedGender = ref.read(selectedGenderProvider);
    final selectedAvailability = ref.read(selectedAvailabilityProvider);
    final goals = ref.read(goalsProvider);
    final modalId = ref.read(modalIdProvider);
    final otherLangText =
        ref.read(otherLanguageProvider).trim(); // Get the other language text

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    print("responsexoj: ${widget.preferenceId}");

    try {
      final questionsAsync = ref.read(questionsProvider);
      final userAnswers = ref.read(userAnswersProvider);

      if (questionsAsync.hasValue && modalId != null) {
        await ref
            .read(questionsProvider.notifier)
            .submitAnswers(modalId, userAnswers);
      }

      final formattedAvailability =
          selectedAvailability.map((slot) {
            return AvailabilitySlot(
              day: slot['day'] as String,
              day_period: (slot['day_period'] as String).toLowerCase(),
            );
          }).toList();

      final isSpecialModal =
          modalId != null && specialModalIds.contains(modalId);
      final isUpdate = widget.preferenceId != null;

      if (isUpdate) {
        if (isSpecialModal) {
          final request = PreferenceUpdateWithoutLevelRequest(
            modalId: modalId,
            gender: selectedGender?.toLowerCase() ?? "",
            languageIds: cleanedSelectedLanguages,
            goal: goals.isNotEmpty ? goals : null,
            availability: formattedAvailability,
            otherLang:
                otherLangText.isNotEmpty
                    ? otherLangText
                    : null, // Add otherLang
          );
          final repository = ref.read(extraQuestionsRepositoryProvider);
          final prefResult = await repository.updatePreferenceWithoutLevel(
            widget.preferenceId!,
            request,
          );

          return prefResult.fold(
            (failure) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to save preferences: ${failure.toString()}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            (prefResponse) async {
              ref.read(selectedPrefProvider.notifier).state =
                  prefResponse.data.id;
              ref.read(routerProvider).go('/subscription');
            },
          );
        } else {
          final request = PreferenceUpdateRequest(
            modalId: modalId,
            gender: selectedGender?.toLowerCase(),
            languageIds:
                cleanedSelectedLanguages.isNotEmpty
                    ? cleanedSelectedLanguages
                    : null,
            goal: goals.isNotEmpty ? goals : null,
            levelId: isSpecialModal ? null : selectedLevel,
            availability:
                formattedAvailability.isNotEmpty ? formattedAvailability : null,
            otherLang:
                otherLangText.isNotEmpty
                    ? otherLangText
                    : null, // Add otherLang
          );

          final repository = ref.read(extraQuestionsRepositoryProvider);
          final updateResult = await repository.updatePreference(
            widget.preferenceId!,
            request,
          );

          return updateResult.fold(
            (failure) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to update preferences: ${failure.toString()}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            (prefResponse) async {
              ref.read(selectedPrefProvider.notifier).state =
                  prefResponse.data.id;
              ref.read(routerProvider).go('/subscription');
            },
          );
        }
      } else {
        if (isSpecialModal) {
          final request = PreferenceRequestWithoutLevel(
            modalId: modalId ?? '15712652-72bc-400e-8f51-784bef64d09a',
            gender: selectedGender?.toLowerCase() ?? "",
            languageIds: cleanedSelectedLanguages,
            goal: goals.isNotEmpty ? goals : null,
            availability: formattedAvailability,
            otherLang:
                otherLangText.isNotEmpty
                    ? otherLangText
                    : null, // Add otherLang
          );
          final repository = ref.read(extraQuestionsRepositoryProvider);
          final prefResult = await repository.createPreferenceWithoutLevel(
            request,
          );

          return prefResult.fold(
            (failure) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to save preferences: ${failure.toString()}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            (prefResponse) async {
              ref.read(selectedPrefProvider.notifier).state =
                  prefResponse.data.id;
              ref.read(routerProvider).go('/subscription');
            },
          );
        } else {
          // For the special modal, levelId can be null/empty
          final request = PreferenceRequest(
            modalId: modalId ?? '15712652-72bc-400e-8f51-784bef64d09a',
            gender: selectedGender?.toLowerCase() ?? "",
            languageIds: cleanedSelectedLanguages,
            goal: goals.isNotEmpty ? goals : null,
            levelId:
                selectedLevel ?? '', // This will be empty for special modal
            availability: formattedAvailability,
            otherLang:
                otherLangText.isNotEmpty
                    ? otherLangText
                    : null, // Add otherLang
          );

          final repository = ref.read(extraQuestionsRepositoryProvider);
          final prefResult = await repository.createPreference(request);

          return prefResult.fold(
            (failure) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to save preferences: ${failure.toString()}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            (prefResponse) async {
              ref.read(selectedPrefProvider.notifier).state =
                  prefResponse.data.id;
              ref.read(routerProvider).go('/subscription');
            },
          );
        }
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildLevelsContent() {
    final levelsAsync = ref.watch(levelsProvider);
    final selectedLevel = ref.watch(selectedLevelProvider);

    Color getPrimary() => const Color(0xFF7EB09B);
    Color getBg() => const Color(0xFFF7FAFC);
    Color getTextPrimary() => const Color(0xFF2D3748);
    Color getTextSecondary() => const Color(0xFF718096);
    Color getBorderNeutral() => const Color(0xFFCBD5E0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your therapist's experience level (XP).",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: levelsAsync.when(
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
                        'Failed to load levels',
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
                        onPressed:
                            () =>
                                ref.read(levelsProvider.notifier).loadLevels(),
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
            data: (levelsResponse) {
              final levels = levelsResponse.data;

              if (levels.isEmpty) {
                return const Center(
                  child: Text(
                    'No levels available',
                    style: TextStyle(fontSize: 18, color: Color(0xFF718096)),
                  ),
                );
              }

              return ListView.separated(
                itemCount: levels.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                padding: const EdgeInsets.only(bottom: 8),
                itemBuilder: (context, index) {
                  print("levels to this shit: $levels");
                  final level = levels[index];
                  final isSelected = selectedLevel == level.id;

                  String? xpText;
                  if (level.minXP != null && level.maxXP != null) {
                    xpText = '${level.minXP}-${level.maxXP} XP';
                  } else if (level.minXP != null) {
                    xpText = '${level.minXP}+ XP';
                  }

                  String? priceText;
                  if (level.price != null) {
                    priceText = ' • ${level.price} ETB/session';
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ref.read(selectedLevelProvider.notifier).state =
                              level.id;
                          ref.read(selectedLevelPriceProvider.notifier).state =
                              level.price?.toString();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? getPrimary().withOpacity(0.1)
                                    : getBg(),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? getPrimary()
                                      : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isSelected
                                          ? getPrimary()
                                          : Colors.transparent,
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? getPrimary()
                                            : getBorderNeutral(),
                                    width: 2,
                                  ),
                                ),
                                child:
                                    isSelected
                                        ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                        : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      level.type,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            isSelected
                                                ? getPrimary()
                                                : getTextPrimary(),
                                      ),
                                    ),
                                    if (xpText != null &&
                                        priceText != null) ...[
                                      const SizedBox(height: 4),
                                      // if (xpText != null)
                                      Text(
                                        xpText + priceText,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: getTextSecondary(),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLanguagesContent() {
    final languagesAsync = ref.watch(languagesProvider);
    final selectedLanguages = ref.watch(selectedLanguagesProvider);
    final showOtherInput = ref.watch(showOtherLanguageInputProvider);
    final otherLanguageText = ref.watch(otherLanguageProvider);
    // final otherLanguage = ref.watch(otherLanguageProvider);

    const primary = Color(0xFF7EB09B);
    const bg = Color(0xFFF7FAFC);
    const textPrimary = Color(0xFF2D3748);
    const textSecondary = Color(0xFF718096);
    const borderNeutral = Color(0xFFCBD5E0);

    const otherLanguageId = 'other';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select the language you speak.",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Select multiple options that apply',
          style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: languagesAsync.when(
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
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
                        'Failed to load languages',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed:
                            () =>
                                ref
                                    .read(languagesProvider.notifier)
                                    .loadLanguages(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
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
            data: (languagesResponse) {
              // Filter out the "Other" language from backend data
              final languages =
                  languagesResponse.data
                      .where(
                        (language) => language.name.toLowerCase() != 'other',
                      )
                      .toList();

              return ListView.separated(
                itemCount: languages.length + 1 + (showOtherInput ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  // "Other" option (manually added)
                  if (index == languages.length) {
                    final isSelected = selectedLanguages.contains(
                      otherLanguageId,
                    );

                    return InkWell(
                      onTap: () {
                        final isSelected = selectedLanguages.contains(
                          otherLanguageId,
                        );

                        if (isSelected) {
                          // Remove only 'other' and hide input
                          final updated = List<String>.from(selectedLanguages)
                            ..remove(otherLanguageId);
                          ref.read(selectedLanguagesProvider.notifier).state =
                              updated;
                          ref
                              .read(showOtherLanguageInputProvider.notifier)
                              .state = false;
                          _otherLangController.clear();
                          ref.read(otherLanguageProvider.notifier).state =
                              ''; // Clear the text field
                        } else {
                          // Add 'other' alongside existing selections
                          final updated =
                              {...selectedLanguages, otherLanguageId}.toList();
                          ref.read(selectedLanguagesProvider.notifier).state =
                              updated;
                          ref
                              .read(showOtherLanguageInputProvider.notifier)
                              .state = true;
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? primary.withOpacity(0.1) : bg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? primary : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected ? primary : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? primary : borderNeutral,
                                  width: 2,
                                ),
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      )
                                      : null,
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Other',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (showOtherInput && index == languages.length + 1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (value) {
                            // Update the provider when text changes
                            ref.read(otherLanguageProvider.notifier).state =
                                value;
                            // Also update the controller for UI
                            _otherLangController.text = value;
                            // Trigger validation update
                            setState(() {});
                          },
                          controller: _otherLangController,
                          decoration: InputDecoration(
                            hintText: 'Please specify (e.g., Somalian)',
                            hintStyle: TextStyle(
                              color: Color(0xFFA0AEC0),
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: primary),
                            ),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }

                  // Regular language options (filtered)
                  final language = languages[index];
                  final isSelected = selectedLanguages.contains(language.id);

                  void toggle() {
                    if (isSelected) {
                      ref.read(selectedLanguagesProvider.notifier).state =
                          selectedLanguages
                              .where((id) => id != language.id)
                              .toList();
                    } else {
                      ref.read(selectedLanguagesProvider.notifier).state = [
                        ...selectedLanguages,
                        language.id,
                      ];
                    }
                  }

                  return InkWell(
                    onTap: toggle,
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? primary.withOpacity(0.1) : bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primary : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? primary : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? primary : borderNeutral,
                                width: 2,
                              ),
                            ),
                            child:
                                isSelected
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                    : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  language.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? primary : textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  language.code.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderContent() {
    final gender = ref.watch(selectedGenderProvider);

    const primary = Color(0xFF7EB09B);
    const bg = Color(0xFFF7FAFC);
    const textPrimary = Color(0xFF2D3748);
    //const textSecondary = Color(0xFF718096);
    const borderNeutral = Color(0xFFCBD5E0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your therapist gender you like to work with",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: genders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final selectedGender = genders[index];
              final isSelected = gender == selectedGender;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap:
                      () =>
                          ref.read(selectedGenderProvider.notifier).state =
                              selectedGender,
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? primary.withOpacity(0.1) : bg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? primary : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? primary : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? primary : borderNeutral,
                              width: 2,
                            ),
                          ),
                          child:
                              isSelected
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            selectedGender,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? primary : textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityContent() {
    final selectedAvailability = ref.watch(selectedAvailabilityProvider);
    const availabilityLimit = 5;

    const primary = Color(0xFF7EB09B);
    const bg = Color(0xFFF7FAFC);
    const textPrimary = Color(0xFF2D3748);
    const textSecondary = Color(0xFF718096);
    const borderNeutral = Color(0xFFCBD5E0);

    final periods = const [
      {'label': 'Morning', 'value': 'morning'},
      {'label': 'Afternoon', 'value': 'afternoon'},
      {'label': 'Evening', 'value': 'evening'},
    ];

    bool isSelected(String day, String dayPeriod) {
      return selectedAvailability.any(
        (a) => a['day'] == day && a['day_period'] == dayPeriod,
      );
    }

    void removeSlot(Map<String, dynamic> slot) {
      final updated = List<Map<String, dynamic>>.from(
        selectedAvailability,
      )..removeWhere(
        (a) => a['day'] == slot['day'] && a['day_period'] == slot['day_period'],
      );
      ref.read(selectedAvailabilityProvider.notifier).state = updated;
    }

    void toggle(String day, String dayPeriod) {
      final alreadySelected = isSelected(day, dayPeriod);
      final reachedLimit = selectedAvailability.length >= availabilityLimit;

      if (!alreadySelected && reachedLimit) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You can select up to $availabilityLimit timeslots only.',
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final updated = List<Map<String, dynamic>>.from(selectedAvailability);
      if (alreadySelected) {
        updated.removeWhere(
          (a) => a['day'] == day && a['day_period'] == dayPeriod,
        );
      } else {
        updated.add({'day': day, 'day_period': dayPeriod});
      }
      ref.read(selectedAvailabilityProvider.notifier).state = updated;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hint + counter
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Select up to 5 periods (Morning, Afternoon, Evening) across the week.',
                  style: TextStyle(fontSize: 14, color: textSecondary),
                ),
              ),
              Text(
                '${selectedAvailability.length}/$availabilityLimit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                      selectedAvailability.length >= availabilityLimit
                          ? const Color(0xFFE53E3E)
                          : textPrimary,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: workingDays.length,
            itemBuilder: (context, index) {
              final day = workingDays[index];

              final countForDay =
                  selectedAvailability.where((s) => s['day'] == day).length;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      childrenPadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                          ),
                          if (countForDay > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$countForDay',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              periods.map((p) {
                                final label = p['label'] as String;
                                final value = p['value'] as String;
                                final selected = isSelected(day, value);

                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => toggle(day, value),
                                    borderRadius: BorderRadius.circular(10),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 180,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            selected
                                                ? primary.withOpacity(0.1)
                                                : bg,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              selected
                                                  ? primary
                                                  : borderNeutral,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 180,
                                            ),
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  selected
                                                      ? primary
                                                      : Colors.transparent,
                                              border: Border.all(
                                                color:
                                                    selected
                                                        ? primary
                                                        : borderNeutral,
                                                width: 2,
                                              ),
                                            ),
                                            child:
                                                selected
                                                    ? const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 12,
                                                    )
                                                    : null,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  selected
                                                      ? primary
                                                      : textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (selectedAvailability.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedAvailability.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final slot = selectedAvailability[index];
                      final label =
                          '${slot['day']} • ${(slot['day_period'] as String).substring(0, 1).toUpperCase()}${(slot['day_period'] as String).substring(1)}';
                      return InputChip(
                        label: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            color: textPrimary,
                          ),
                        ),
                        onDeleted: () => removeSlot(slot),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 18,
                          color: textSecondary,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: -2,
                          vertical: -2,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildGoalsContent() {
    final goals = ref.watch(goalsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "what is your main goal for this therapy",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
            height: 1.3,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged:
                (value) => ref.read(goalsProvider.notifier).state = value,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe your cou goals...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF7EB09B)),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  int stepToIndex(ExtraQuestionStep step) {
    switch (step) {
      case ExtraQuestionStep.languages:
        return 0;
      case ExtraQuestionStep.levels:
        return 1;
      // case ExtraQuestionStep.sessionFormat:
      //   return 2;
      case ExtraQuestionStep.availability:
        return 2;
      case ExtraQuestionStep.goals:
        return 3;
      case ExtraQuestionStep.gender:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(extraQuestionsStepProvider);
    final router = ref.read(routerProvider);
    final numQuestions = ref.watch(numQuestionsProvider);
    final modalId = ref.read(modalIdProvider);

    final totalPagesCount = totalPages;
    final currentPages = pages;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          router.go("/categories");
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20.0,
                    right: 20.0,
                  ),
                  child:
                      widget.preferenceId != null
                          ? QuestionnaireProgressIndicator(
                            currentIndex: _currentIndex,
                            totalQuestions:
                                totalPagesCount, // Use dynamic total
                          )
                          : QuestionnaireProgressIndicator(
                            currentIndex: _currentIndex + numQuestions,
                            totalQuestions:
                                numQuestions +
                                totalPagesCount, // Use dynamic total
                          ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged:
                        (index) => setState(() => _currentIndex = index),
                    children: currentPages, // Use dynamic pages
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        _isLoading
                            ? null
                            : () {
                              if (_currentIndex > 0) {
                                _previousQuestion();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF7EB09B),
                      side: const BorderSide(color: Color(0xFF7EB09B)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: _currentIndex == 0 ? 1 : 2,
                  child: ElevatedButton(
                    onPressed:
                        _isLoading
                            ? null
                            : (_isPageValid(_currentIndex)
                                ? _nextQuestion
                                : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isPageValid(_currentIndex)
                              ? const Color(0xFF7EB09B)
                              : const Color(0xFFE2E8F0),
                      foregroundColor:
                          _isPageValid(_currentIndex)
                              ? Colors.white
                              : const Color(0xFFA0AEC0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: _isPageValid(_currentIndex) ? 2 : 0,
                    ),
                    child:
                        _isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : Text(
                              _currentIndex == totalPagesCount - 1
                                  ? 'Complete'
                                  : 'Next', // Dynamic button text
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget wrapWithContainer(Widget child) {
  return Container(
    margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
    padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
    // padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}
