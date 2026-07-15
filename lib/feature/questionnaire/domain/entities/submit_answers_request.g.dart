// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_answers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubmitAnswersRequestImpl _$$SubmitAnswersRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SubmitAnswersRequestImpl(
      modalId: json['modalId'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SubmitAnswersRequestImplToJson(
        _$SubmitAnswersRequestImpl instance) =>
    <String, dynamic>{
      'modalId': instance.modalId,
      'answers': instance.answers,
    };

_$AnswerRequestImpl _$$AnswerRequestImplFromJson(Map<String, dynamic> json) =>
    _$AnswerRequestImpl(
      questionId: json['questionId'] as String,
      singleOptionId: json['singleOptionId'] as String?,
      multiOptionIds: (json['multiOptionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$AnswerRequestImplToJson(_$AnswerRequestImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'singleOptionId': instance.singleOptionId,
      'multiOptionIds': instance.multiOptionIds,
      'text': instance.text,
    };
