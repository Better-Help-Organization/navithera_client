// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modals_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModalsResponseImpl _$$ModalsResponseImplFromJson(Map<String, dynamic> json) =>
    _$ModalsResponseImpl(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => TherapyModal.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$ModalsResponseImplToJson(
  _$ModalsResponseImpl instance,
) => <String, dynamic>{'data': instance.data};
