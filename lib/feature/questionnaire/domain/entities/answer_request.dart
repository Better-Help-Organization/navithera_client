// answer_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_request.freezed.dart';
part 'answer_request.g.dart';

@freezed
class AnswerRequest with _$AnswerRequest {
  const factory AnswerRequest({
    required String questionId,
    String? singleOptionId, // For single choice
    List<String>? multiOptionIds, // For multiple choice
    String? text, // For open-ended
  }) = _AnswerRequest;

  factory AnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$AnswerRequestFromJson(json);
}
