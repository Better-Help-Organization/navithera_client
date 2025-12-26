// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatListResponseImpl _$$ChatListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ChatListResponseImpl(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => ChatItem.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$$ChatListResponseImplToJson(
  _$ChatListResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp?.toIso8601String(),
};

_$ChatItemImpl _$$ChatItemImplFromJson(Map<String, dynamic> json) =>
    _$ChatItemImpl(
      id: json['id'] as String,
      activeCallRoom: json['activeCallRoom'] as String?,
      groupName: json['groupName'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      group:
          (json['group'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastMessage:
          json['lastMessage'] == null
              ? null
              : LastMessage.fromJson(
                json['lastMessage'] as Map<String, dynamic>,
              ),
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ChatItemImplToJson(_$ChatItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activeCallRoom': instance.activeCallRoom,
      'groupName': instance.groupName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'group': instance.group,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
    };

_$LastMessageImpl _$$LastMessageImplFromJson(Map<String, dynamic> json) =>
    _$LastMessageImpl(
      id: json['id'] as String?,
      content: json['content'] as String?,
      isRead: json['isRead'] as bool?,
      client:
          json['client'] == null
              ? null
              : UserModel.fromJson(json['client'] as Map<String, dynamic>),
      therapist:
          json['therapist'] == null
              ? null
              : UserModel.fromJson(json['therapist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LastMessageImplToJson(_$LastMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isRead': instance.isRead,
      'client': instance.client,
      'therapist': instance.therapist,
    };

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      totalItems: (json['totalItems'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
    };

_$JoinCallResponseImpl _$$JoinCallResponseImplFromJson(
  Map<String, dynamic> json,
) => _$JoinCallResponseImpl(
  data:
      json['data'] == null
          ? null
          : JoinCallData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  method: json['method'] as String?,
  path: json['path'] as String?,
  timestamp:
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$JoinCallResponseImplToJson(
  _$JoinCallResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp?.toIso8601String(),
};

_$JoinCallDataImpl _$$JoinCallDataImplFromJson(Map<String, dynamic> json) =>
    _$JoinCallDataImpl(
      token: json['token'] as String,
      room: json['room'] as String,
    );

Map<String, dynamic> _$$JoinCallDataImplToJson(_$JoinCallDataImpl instance) =>
    <String, dynamic>{'token': instance.token, 'room': instance.room};
