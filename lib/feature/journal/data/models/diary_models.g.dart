// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryListResponseImpl _$$DiaryListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DiaryListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => DiaryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DiaryListResponseImplToJson(
        _$DiaryListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$DiaryEntryImpl _$$DiaryEntryImplFromJson(Map<String, dynamic> json) =>
    _$DiaryEntryImpl(
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      content: json['content'] as String,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$DiaryEntryImplToJson(_$DiaryEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

_$DiaryCreateResponseImpl _$$DiaryCreateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DiaryCreateResponseImpl(
      data: DiaryEntry.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DiaryCreateResponseImplToJson(
        _$DiaryCreateResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$DiaryUpdateResponseImpl _$$DiaryUpdateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DiaryUpdateResponseImpl(
      data: DiaryEntry.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DiaryUpdateResponseImplToJson(
        _$DiaryUpdateResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$DiaryEditResponseImpl _$$DiaryEditResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DiaryEditResponseImpl(
      data: DiaryEntry.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DiaryEditResponseImplToJson(
        _$DiaryEditResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$DiaryDeleteResponseImpl _$$DiaryDeleteResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DiaryDeleteResponseImpl(
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$DiaryDeleteResponseImplToJson(
        _$DiaryDeleteResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };
