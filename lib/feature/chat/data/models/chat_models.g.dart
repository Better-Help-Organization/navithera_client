// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatListResponseImpl _$$ChatListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatThread.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatListResponseImplToJson(
        _$ChatListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$ChatThreadImpl _$$ChatThreadImplFromJson(Map<String, dynamic> json) =>
    _$ChatThreadImpl(
      id: json['id'] as String,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      client: json['client'] == null
          ? null
          : UserModel.fromJson(json['client'] as Map<String, dynamic>),
      group: (json['group'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      therapist: UserModel.fromJson(json['therapist'] as Map<String, dynamic>),
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCount: (json['unreadCount'] as num?)?.toInt(),
      groupName: json['groupName'] as String?,
    );

Map<String, dynamic> _$$ChatThreadImplToJson(_$ChatThreadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'client': instance.client,
      'group': instance.group,
      'therapist': instance.therapist,
      'message': instance.message,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
      'groupName': instance.groupName,
    };

_$ChatMessageResponseImpl _$$ChatMessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => ChatMessageDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatMessageResponseImplToJson(
        _$ChatMessageResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$ChatMessageDetailImpl _$$ChatMessageDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageDetailImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      therapist: json['therapist'] == null
          ? null
          : UserModel.fromJson(json['therapist'] as Map<String, dynamic>),
      client: json['client'] == null
          ? null
          : UserModel.fromJson(json['client'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$$ChatMessageDetailImplToJson(
        _$ChatMessageDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'therapist': instance.therapist,
      'client': instance.client,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastMessage': instance.lastMessage,
      'isRead': instance.isRead,
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
    };

_$MessageSendResponseImpl _$$MessageSendResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageSendResponseImpl(
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageSendResponseImplToJson(
        _$MessageSendResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$GroupChatCreateResponseImpl _$$GroupChatCreateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupChatCreateResponseImpl(
      data: GroupChatData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$GroupChatCreateResponseImplToJson(
        _$GroupChatCreateResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$GroupChatDataImpl _$$GroupChatDataImplFromJson(Map<String, dynamic> json) =>
    _$GroupChatDataImpl(
      group: (json['group'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: json['client'] == null
          ? null
          : UserModel.fromJson(json['client'] as Map<String, dynamic>),
      therapist: json['therapist'] == null
          ? null
          : UserModel.fromJson(json['therapist'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GroupChatDataImplToJson(_$GroupChatDataImpl instance) =>
    <String, dynamic>{
      'group': instance.group,
      'client': instance.client,
      'therapist': instance.therapist,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'lastMessage': instance.lastMessage,
    };

_$TherapistInfoResponseImpl _$$TherapistInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TherapistInfoResponseImpl(
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$TherapistInfoResponseImplToJson(
        _$TherapistInfoResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$MarkAsReadResponseImpl _$$MarkAsReadResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MarkAsReadResponseImpl(
      data: MarkAsReadData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String,
      path: json['path'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MarkAsReadResponseImplToJson(
        _$MarkAsReadResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$MarkAsReadDataImpl _$$MarkAsReadDataImplFromJson(Map<String, dynamic> json) =>
    _$MarkAsReadDataImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$MarkAsReadDataImplToJson(
        _$MarkAsReadDataImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
