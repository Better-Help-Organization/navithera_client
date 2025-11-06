import 'package:navithera_client/feature/questionnaire/domain/entities/submit_answers_request.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';

import '../../domain/entities/questions_response.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/questions_remote_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource _remoteDataSource;

  QuestionsRepositoryImpl(this._remoteDataSource);

  @override
  Future<QuestionsResponse> getQuestions({String? modalId}) async {
    // Add optional modalId parameter
    try {
      String? filters;
      if (modalId != null && modalId.isNotEmpty) {
        filters = 'modal.id=$modalId'; // Create filter string
      }

      return await _remoteDataSource.getQuestions(filters: filters);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> submitAnswers(String modalId, List<UserAnswer> answers) async {
    try {
      final answerRequests =
          answers.map((userAnswer) {
            // Create AnswerRequest based on the question type and available data
            return AnswerRequest(
              questionId: userAnswer.questionId,
              singleOptionId: userAnswer.selectedOptionId,
              multiOptionIds: userAnswer.selectedOptionIds,
              text: userAnswer.text,
            );
          }).toList();

      print("userAnswers2: ${answerRequests}");

      final request = SubmitAnswersRequest(
        modalId: modalId,
        answers: answerRequests,
      );

      await _remoteDataSource.submitAnswers(request: request);
    } catch (e) {
      rethrow;
    }
  }
}
