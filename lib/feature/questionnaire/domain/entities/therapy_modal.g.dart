// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapy_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TherapyModalImpl _$$TherapyModalImplFromJson(Map<String, dynamic> json) =>
    _$TherapyModalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$TherapyModalImplToJson(_$TherapyModalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
