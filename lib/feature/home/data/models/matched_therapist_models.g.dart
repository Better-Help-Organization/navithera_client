// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_therapist_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchListResponseImpl _$$MatchListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MatchListResponseImpl(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => MatchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  method: json['method'] as String?,
  path: json['path'] as String?,
  timestamp:
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$MatchListResponseImplToJson(
  _$MatchListResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp?.toIso8601String(),
};

_$MatchItemImpl _$$MatchItemImplFromJson(Map<String, dynamic> json) =>
    _$MatchItemImpl(
      id: json['id'] as String,
      accepted:
          json['accepted'] == null
              ? null
              : UserModel.fromJson(json['accepted'] as Map<String, dynamic>),
      client: json['client'] ?? null,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MatchItemImplToJson(_$MatchItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accepted': instance.accepted,
      'client': instance.client,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
