// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguagesResponseImpl _$$LanguagesResponseImplFromJson(
  Map<String, dynamic> json,
) => _$LanguagesResponseImpl(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$LanguagesResponseImplToJson(
  _$LanguagesResponseImpl instance,
) => <String, dynamic>{'data': instance.data};
