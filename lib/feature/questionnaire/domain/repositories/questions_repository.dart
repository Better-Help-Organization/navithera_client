import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';

import '../entities/questions_response.dart';

abstract class QuestionsRepository {
  Future<QuestionsResponse> getQuestions({
    String? modalId,
  }); // Add optional parameter

  Future<void> submitAnswers(String modalId, List<UserAnswer> answers);
}
