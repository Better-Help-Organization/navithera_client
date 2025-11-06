// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      text: json['text'] as String,
      type: json['type'] as String,
      order: (json['order'] as num?)?.toInt(),
      option:
          (json['option'] as List<dynamic>)
              .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
              .toList(),
      modal: json['modal'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'text': instance.text,
      'type': instance.type,
      'order': instance.order,
      'option': instance.option,
      'modal': instance.modal,
    };
