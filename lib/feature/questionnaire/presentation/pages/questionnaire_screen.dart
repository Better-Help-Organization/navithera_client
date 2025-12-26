import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/question.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/question_option.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';
import 'package:navithera_client/feature/questionnaire/presentation/pages/extra_question_screen.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import '../../../../core/routes/app_router.dart';
import '../providers/questions_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/progress_indicator.dart';

class QuestionnaireScreen extends ConsumerStatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  ConsumerState<QuestionnaireScreen> createState() =>
      _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends ConsumerState<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  bool _isLoading = false;

  void _resetQuestionnaire() {
    ref.read(currentQuestionIndexProvider.notifier).state = 0;
    _pageController.jumpToPage(0);
  }

  @override
  void initState() {
    super.initState();
    // Load questions when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get category from URL query parameters
      final state = GoRouterState.of(context);
      final category = state.uri.queryParameters['category'];
      ref.read(questionsProvider.notifier).loadQuestions(category: category);
      _resetQuestionnaire();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // ref.read(userAnswersProvider.notifier).clearAnswers();
    super.dispose();
  }

  bool _hasAnswer(Question question, List<UserAnswer> userAnswers) {
    final answer =
        userAnswers
            .where((answer) => answer.questionId == question.id)
            .firstOrNull;

    if (answer == null) return false;

    switch (question.type) {
      case 'single':
        if (answer.selectedOptionId != null) {
          // Check if "Other" is selected and has text
          final otherOption = question.option.firstWhere(
            (option) => option.text.toLowerCase().contains('other'),
            orElse:
                () => QuestionOption(
                  id: '',
                  text: '',
                  createdAt: DateTime(2025),
                  order: 0,
                ),
          );

          if (otherOption.id.isNotEmpty &&
              answer.selectedOptionId == otherOption.id) {
            return answer.text != null && answer.text!.trim().isNotEmpty;
          }
          return true;
        }
        return false;

      case 'multiple':
        if (answer.selectedOptionIds != null &&
            answer.selectedOptionIds!.isNotEmpty) {
          // Check if "Other" is selected and has text
          final otherOption = question.option.firstWhere(
            (option) => option.text.toLowerCase().contains('other'),
            orElse:
                () => QuestionOption(
                  id: '',
                  text: '',
                  createdAt: DateTime(2025),
                  order: 0,
                ),
          );

          if (otherOption.id.isNotEmpty &&
              answer.selectedOptionIds!.contains(otherOption.id)) {
            return answer.text != null && answer.text!.trim().isNotEmpty;
          }
          return true;
        }
        return false;

      case 'open':
        return answer.text != null && answer.text!.trim().isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(questionsProvider);
    final currentIndex = ref.watch(currentQuestionIndexProvider);
    final userAnswers = ref.watch(userAnswersProvider);
    final modalId = ref.read(modalIdProvider);
    bool fullQuestion = true;
    int fullQuestionNumber = 5;
    print("userAnswers: ${modalId}");
    print("modalId: ${modalId}");
    if (modalId == "d724ce6f-4f28-4406-8e67-d8f52afab561" ||
        modalId == "f5e00c19-e5ac-4f58-84d5-dec34371a6f9" ||
        modalId == "e56f7498-869a-424d-9d26-9a99d8079faf" ||
        modalId == "aa4c9839-e031-417a-b319-2da4bf1092c3") {
      fullQuestion = false;
      // fullQuestionNumber = 5;
    } else if (modalId == "d49cc9bc-261c-49f1-8f97-1344a551f498" ||
        modalId == "c37e045d-811b-4fb2-bca4-d3595e41ef91") {
      print("userAnswers: d49cc9bc-261c-49f1-8f97-1344a551f498");
      //fullQuestion = true;
      fullQuestionNumber = 4;
    }

    print("userAnswers: ${fullQuestionNumber}");

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: questionsAsync.when(
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
                        'Failed to load questions',
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
                          final state = GoRouterState.of(context);
                          final category =
                              state.uri.queryParameters['category'];
                          ref
                              .read(questionsProvider.notifier)
                              .loadQuestions(category: category);
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
            data: (questionsResponse) {
              final questions = questionsResponse.data;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(numQuestionsProvider.notifier).state =
                    questions.length;
              });
              if (questions.isEmpty) {
                return const Center(
                  child: Text(
                    'No questions available',
                    style: TextStyle(fontSize: 18, color: Color(0xFF718096)),
                  ),
                );
              }

              return Column(
                children: [
                  QuestionnaireProgressIndicator(
                    currentIndex: currentIndex,
                    totalQuestions:
                        fullQuestion
                            ? questions.length + fullQuestionNumber
                            : questions.length,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics:
                          const NeverScrollableScrollPhysics(), // disables swiping
                      onPageChanged: (index) {
                        ref.read(currentQuestionIndexProvider.notifier).state =
                            index;
                      },
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: QuestionCard(
                            question: questions[index],
                            onAnswered: () {
                              if (questions[index].type == 'single') {
                                Future.delayed(
                                  const Duration(milliseconds: 300),
                                  () => _nextQuestion(),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: questionsAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (_, __) => const SizedBox.shrink(),
        data: (questionsResponse) {
          final questions = questionsResponse.data;
          if (questions.isEmpty) return const SizedBox.shrink();

          final currentQuestion = questions[currentIndex];
          final hasAnswer = _hasAnswer(currentQuestion, userAnswers);

          return Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _previousQuestion,
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
                if (currentIndex > 0) const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed:
                        _isLoading ? null : (hasAnswer ? _nextQuestion : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          hasAnswer
                              ? const Color(0xFF7EB09B)
                              : const Color(0xFFE2E8F0),
                      foregroundColor:
                          hasAnswer ? Colors.white : const Color(0xFFA0AEC0),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: hasAnswer ? 2 : 0,
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
                              // currentIndex == questions.length - 1
                              //     ? 'Complete'
                              //     :
                              'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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

  void _previousQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    if (currentIndex > 0) {
      final newIndex = currentIndex - 1;
      ref.read(currentQuestionIndexProvider.notifier).state = newIndex;
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextQuestion() async {
    final questionsAsync = ref.read(questionsProvider);
    if (!questionsAsync.hasValue) return;

    final questions = questionsAsync.value!.data;
    final currentIndex = ref.read(currentQuestionIndexProvider);

    if (currentIndex < questions.length - 1) {
      final newIndex = currentIndex + 1;
      ref.read(currentQuestionIndexProvider.notifier).state = newIndex;
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Complete questionnaire
      await _completeQuestionnaire();
    }
  }

  Future<void> _completeQuestionnaire() async {
    setState(() => _isLoading = true);

    try {
      final modalId = ref.read(modalIdProvider);
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      if (modalId == "d724ce6f-4f28-4406-8e67-d8f52afab561" ||
          modalId == "f5e00c19-e5ac-4f58-84d5-dec34371a6f9" ||
          modalId == "e56f7498-869a-424d-9d26-9a99d8079faf" ||
          modalId == "aa4c9839-e031-417a-b319-2da4bf1092c3") {
        final questionsAsync = ref.read(questionsProvider);
        final userAnswers = ref.read(userAnswersProvider);
        print("userAnswers: ${modalId}");
        if (questionsAsync.hasValue && modalId != null) {
          await ref
              .read(questionsProvider.notifier)
              .submitAnswers(modalId, userAnswers);
        }

        final request = PreferenceRequestModalOnly(
          modalId: modalId ?? '', // Handle null case
        );

        final repository = ref.read(extraQuestionsRepositoryProvider);

        // Make the API call
        final prefResult = await repository.createPreferenceForGroup(request);

        print('Preference created: $prefResult');
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
            // ref.read(selectedPrefProvider.notifier).state = prefResponse.data.id;
            // ref.read(routerProvider).go('/subscription');
            final router = ref.read(routerProvider);
            router.push('/subscription');
            return;
          },
        );
      } // Make sure you have this provider
      // Navigate to next screen
      if (mounted) {
        //ref.read(numQuestion.notifier).state = questions.length;

        final router = ref.read(routerProvider);
        router.push('/language-selection');
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to complete questionnaire: $e'),
            backgroundColor: const Color(0xFFE53E3E),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
