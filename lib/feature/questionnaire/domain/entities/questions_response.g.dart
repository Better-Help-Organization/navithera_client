// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionsResponseImpl _$$QuestionsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$QuestionsResponseImpl(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$QuestionsResponseImplToJson(
  _$QuestionsResponseImpl instance,
) => <String, dynamic>{'data': instance.data};
