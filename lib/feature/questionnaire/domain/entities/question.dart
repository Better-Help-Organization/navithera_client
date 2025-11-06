import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_option.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required DateTime createdAt, // Add this
    required String text,
    required String type, // "single" or "open"
    required int? order, // Add this
    required List<QuestionOption> option, // Changed from 'option' to 'options'
    required Map<String, dynamic>? modal,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
