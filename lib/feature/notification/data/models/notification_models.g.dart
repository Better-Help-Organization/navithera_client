// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationListResponseImpl _$$NotificationListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$NotificationListResponseImplToJson(
        _$NotificationListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$NotificationItemImpl _$$NotificationItemImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationItemImpl(
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      message: json['message'] as String?,
      code: json['code'] as String,
      client: json['client'] == null
          ? null
          : UserModel.fromJson(json['client'] as Map<String, dynamic>),
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$NotificationItemImplToJson(
        _$NotificationItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'message': instance.message,
      'code': instance.code,
      'client': instance.client,
      'profile': instance.profile,
    };
