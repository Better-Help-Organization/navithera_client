// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionListResponseImpl _$$SessionListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      method: json['method'] as String?,
      path: json['path'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$SessionListResponseImplToJson(
        _$SessionListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$SessionItemImpl _$$SessionItemImplFromJson(Map<String, dynamic> json) =>
    _$SessionItemImpl(
      id: json['id'] as String,
      schedule: _dateTimeFromJson(json['schedule']),
      approvalStatus: json['approvalStatus'] as String?,
      hasTherapistAttended: _boolFromJson(json['hasTherapistAttended']),
      hasClientAttended: _boolFromJson(json['hasclientAttended']),
      duration: (json['duration'] as num?)?.toInt(),
      type: json['type'] as String?,
      note: json['note'] as String?,
      client: _userFromJson(json['client']),
      therapist: _userFromJson(json['therapist']),
      group: json['group'] as List<dynamic>?,
    );

Map<String, dynamic> _$$SessionItemImplToJson(_$SessionItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schedule': _dateTimeToJson(instance.schedule),
      'approvalStatus': instance.approvalStatus,
      'hasTherapistAttended': instance.hasTherapistAttended,
      'hasclientAttended': instance.hasClientAttended,
      'duration': instance.duration,
      'type': instance.type,
      'note': instance.note,
      'client': _userToJson(instance.client),
      'therapist': _userToJson(instance.therapist),
      'group': instance.group,
    };
