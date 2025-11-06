import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/questions_remote_data_source.dart';
import '../../data/repositories/questions_repository_impl.dart';
import '../../domain/entities/questions_response.dart';
import '../../domain/entities/user_answer.dart';
import '../../domain/repositories/questions_repository.dart';

// Repository provider
final questionsRepositoryProvider = Provider<QuestionsRepository>((ref) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = QuestionsRemoteDataSource(dio);
  return QuestionsRepositoryImpl(remoteDataSource);
});

// Questions state provider
final questionsProvider =
    StateNotifierProvider<QuestionsNotifier, AsyncValue<QuestionsResponse>>((
      ref,
    ) {
      final repository = ref.read(questionsRepositoryProvider);
      return QuestionsNotifier(repository);
    });

// User answers provider
final userAnswersProvider =
    StateNotifierProvider<UserAnswersNotifier, List<UserAnswer>>((ref) {
      return UserAnswersNotifier();
    });

// Current question index provider
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

class QuestionsNotifier extends StateNotifier<AsyncValue<QuestionsResponse>> {
  final QuestionsRepository _repository;

  QuestionsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadQuestions({String? category}) async {
    state = const AsyncValue.loading();
    try {
      // Pass the category (modalId) directly to the repository
      final questions = await _repository.getQuestions(modalId: category);
      state = AsyncValue.data(questions);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> submitAnswers(String modalId, List<UserAnswer> answers) async {
    try {
      await _repository.submitAnswers(modalId, answers);
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  // Remove the _filterQuestionsByCategory method since filtering is now done on backend
}

class UserAnswersNotifier extends StateNotifier<List<UserAnswer>> {
  UserAnswersNotifier() : super([]);

  void addAnswer(UserAnswer answer) {
    // Remove existing answer for the same question if it exists
    state = [...state.where((a) => a.questionId != answer.questionId), answer];
  }

  void updateAnswer(
    String questionId, {
    String? selectedOptionId,
    List<String>? selectedOptionIds,
    String? text,
  }) {
    final answer = UserAnswer(
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      selectedOptionIds: selectedOptionIds,
      text: text,
    );
    addAnswer(answer);
  }

  void toggleMultipleOption(String questionId, String optionId) {
    final existingAnswer = getAnswerForQuestion(questionId);
    final currentIds = existingAnswer?.selectedOptionIds ?? [];

    final newIds =
        currentIds.contains(optionId)
            ? currentIds.where((id) => id != optionId).toList()
            : [...currentIds, optionId];

    updateAnswer(
      questionId,
      selectedOptionIds: newIds.isNotEmpty ? newIds : null,
    );
  }

  UserAnswer? getAnswerForQuestion(String questionId) {
    try {
      return state.firstWhere((answer) => answer.questionId == questionId);
    } catch (e) {
      return null;
    }
  }

  void clearAnswers() {
    state = [];
  }
}
