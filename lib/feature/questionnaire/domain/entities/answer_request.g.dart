// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerRequestImpl _$$AnswerRequestImplFromJson(Map<String, dynamic> json) =>
    _$AnswerRequestImpl(
      questionId: json['questionId'] as String,
      singleOptionId: json['singleOptionId'] as String?,
      multiOptionIds:
          (json['multiOptionIds'] as List<dynamic>?)
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
