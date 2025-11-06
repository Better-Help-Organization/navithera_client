// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelModelImpl _$$LevelModelImplFromJson(Map<String, dynamic> json) =>
    _$LevelModelImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: json['type'] as String,
      minXP: (json['minXP'] as num?)?.toInt(),
      maxXP: (json['maxXP'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LevelModelImplToJson(_$LevelModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'type': instance.type,
      'minXP': instance.minXP,
      'maxXP': instance.maxXP,
      'price': instance.price,
    };
