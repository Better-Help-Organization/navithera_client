// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiChatRequestImpl _$$AiChatRequestImplFromJson(Map<String, dynamic> json) =>
    _$AiChatRequestImpl(
      query: json['query'] as String,
    );

Map<String, dynamic> _$$AiChatRequestImplToJson(_$AiChatRequestImpl instance) =>
    <String, dynamic>{
      'query': instance.query,
    };

_$AiChatResponseImpl _$$AiChatResponseImplFromJson(Map<String, dynamic> json) =>
    _$AiChatResponseImpl(
      success: json['success'] as bool,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      result: AiChatResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AiChatResponseImplToJson(
        _$AiChatResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errors': instance.errors,
      'messages': instance.messages,
      'result': instance.result,
    };

_$AiChatResultImpl _$$AiChatResultImplFromJson(Map<String, dynamic> json) =>
    _$AiChatResultImpl(
      response: json['response'] as String,
    );

Map<String, dynamic> _$$AiChatResultImplToJson(_$AiChatResultImpl instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isUser': instance.isUser,
      'timestamp': instance.timestamp.toIso8601String(),
      'isLoading': instance.isLoading,
      'error': instance.error,
    };

_$UsageInfoImpl _$$UsageInfoImplFromJson(Map<String, dynamic> json) =>
    _$UsageInfoImpl(
      remaining: (json['remaining'] as num).toInt(),
      used: (json['used'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      isApproachingLimit: json['isApproachingLimit'] as bool,
      timeUntilReset:
          Duration(microseconds: (json['timeUntilReset'] as num).toInt()),
    );

Map<String, dynamic> _$$UsageInfoImplToJson(_$UsageInfoImpl instance) =>
    <String, dynamic>{
      'remaining': instance.remaining,
      'used': instance.used,
      'total': instance.total,
      'isApproachingLimit': instance.isApproachingLimit,
      'timeUntilReset': instance.timeUntilReset.inMicroseconds,
    };
