// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      questionId: json['questionId'] as String,
      selectedOptionId: json['selectedOptionId'] as String?,
      selectedOptionIds: (json['selectedOptionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedOptionId': instance.selectedOptionId,
      'selectedOptionIds': instance.selectedOptionIds,
      'text': instance.text,
    };
