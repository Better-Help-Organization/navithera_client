// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelsResponseImpl _$$LevelsResponseImplFromJson(Map<String, dynamic> json) =>
    _$LevelsResponseImpl(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => LevelModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$LevelsResponseImplToJson(
  _$LevelsResponseImpl instance,
) => <String, dynamic>{'data': instance.data};
