import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'questions_response.freezed.dart';
part 'questions_response.g.dart';

@freezed
class QuestionsResponse with _$QuestionsResponse {
  const factory QuestionsResponse({
    required List<Question> data,
  }) = _QuestionsResponse;

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);
}
