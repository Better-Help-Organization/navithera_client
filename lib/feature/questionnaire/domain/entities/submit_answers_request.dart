import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_answers_request.freezed.dart';
part 'submit_answers_request.g.dart';

@freezed
class SubmitAnswersRequest with _$SubmitAnswersRequest {
  const factory SubmitAnswersRequest({
    required String modalId,
    required List<AnswerRequest> answers,
  }) = _SubmitAnswersRequest;

  factory SubmitAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitAnswersRequestFromJson(json);
}

@freezed
class AnswerRequest with _$AnswerRequest {
  const factory AnswerRequest({
    required String questionId,
    String? singleOptionId,
    List<String>? multiOptionIds,
    String? text,
  }) = _AnswerRequest;

  factory AnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$AnswerRequestFromJson(json);
}
