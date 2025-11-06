// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiChatRequest _$AiChatRequestFromJson(Map<String, dynamic> json) {
  return _AiChatRequest.fromJson(json);
}

/// @nodoc
mixin _$AiChatRequest {
  String get prompt => throw _privateConstructorUsedError;

  /// Serializes this AiChatRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatRequestCopyWith<AiChatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatRequestCopyWith<$Res> {
  factory $AiChatRequestCopyWith(
    AiChatRequest value,
    $Res Function(AiChatRequest) then,
  ) = _$AiChatRequestCopyWithImpl<$Res, AiChatRequest>;
  @useResult
  $Res call({String prompt});
}

/// @nodoc
class _$AiChatRequestCopyWithImpl<$Res, $Val extends AiChatRequest>
    implements $AiChatRequestCopyWith<$Res> {
  _$AiChatRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? prompt = null}) {
    return _then(
      _value.copyWith(
            prompt:
                null == prompt
                    ? _value.prompt
                    : prompt // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChatRequestImplCopyWith<$Res>
    implements $AiChatRequestCopyWith<$Res> {
  factory _$$AiChatRequestImplCopyWith(
    _$AiChatRequestImpl value,
    $Res Function(_$AiChatRequestImpl) then,
  ) = __$$AiChatRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String prompt});
}

/// @nodoc
class __$$AiChatRequestImplCopyWithImpl<$Res>
    extends _$AiChatRequestCopyWithImpl<$Res, _$AiChatRequestImpl>
    implements _$$AiChatRequestImplCopyWith<$Res> {
  __$$AiChatRequestImplCopyWithImpl(
    _$AiChatRequestImpl _value,
    $Res Function(_$AiChatRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? prompt = null}) {
    return _then(
      _$AiChatRequestImpl(
        prompt:
            null == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatRequestImpl implements _AiChatRequest {
  const _$AiChatRequestImpl({required this.prompt});

  factory _$AiChatRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatRequestImplFromJson(json);

  @override
  final String prompt;

  @override
  String toString() {
    return 'AiChatRequest(prompt: $prompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatRequestImpl &&
            (identical(other.prompt, prompt) || other.prompt == prompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, prompt);

  /// Create a copy of AiChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatRequestImplCopyWith<_$AiChatRequestImpl> get copyWith =>
      __$$AiChatRequestImplCopyWithImpl<_$AiChatRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatRequestImplToJson(this);
  }
}

abstract class _AiChatRequest implements AiChatRequest {
  const factory _AiChatRequest({required final String prompt}) =
      _$AiChatRequestImpl;

  factory _AiChatRequest.fromJson(Map<String, dynamic> json) =
      _$AiChatRequestImpl.fromJson;

  @override
  String get prompt;

  /// Create a copy of AiChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatRequestImplCopyWith<_$AiChatRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiChatResponse _$AiChatResponseFromJson(Map<String, dynamic> json) {
  return _AiChatResponse.fromJson(json);
}

/// @nodoc
mixin _$AiChatResponse {
  bool get success => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;
  List<String> get messages => throw _privateConstructorUsedError;
  AiChatResult get result => throw _privateConstructorUsedError;

  /// Serializes this AiChatResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatResponseCopyWith<AiChatResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatResponseCopyWith<$Res> {
  factory $AiChatResponseCopyWith(
    AiChatResponse value,
    $Res Function(AiChatResponse) then,
  ) = _$AiChatResponseCopyWithImpl<$Res, AiChatResponse>;
  @useResult
  $Res call({
    bool success,
    List<String> errors,
    List<String> messages,
    AiChatResult result,
  });

  $AiChatResultCopyWith<$Res> get result;
}

/// @nodoc
class _$AiChatResponseCopyWithImpl<$Res, $Val extends AiChatResponse>
    implements $AiChatResponseCopyWith<$Res> {
  _$AiChatResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errors = null,
    Object? messages = null,
    Object? result = null,
  }) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            errors:
                null == errors
                    ? _value.errors
                    : errors // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            messages:
                null == messages
                    ? _value.messages
                    : messages // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            result:
                null == result
                    ? _value.result
                    : result // ignore: cast_nullable_to_non_nullable
                        as AiChatResult,
          )
          as $Val,
    );
  }

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiChatResultCopyWith<$Res> get result {
    return $AiChatResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiChatResponseImplCopyWith<$Res>
    implements $AiChatResponseCopyWith<$Res> {
  factory _$$AiChatResponseImplCopyWith(
    _$AiChatResponseImpl value,
    $Res Function(_$AiChatResponseImpl) then,
  ) = __$$AiChatResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<String> errors,
    List<String> messages,
    AiChatResult result,
  });

  @override
  $AiChatResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$AiChatResponseImplCopyWithImpl<$Res>
    extends _$AiChatResponseCopyWithImpl<$Res, _$AiChatResponseImpl>
    implements _$$AiChatResponseImplCopyWith<$Res> {
  __$$AiChatResponseImplCopyWithImpl(
    _$AiChatResponseImpl _value,
    $Res Function(_$AiChatResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errors = null,
    Object? messages = null,
    Object? result = null,
  }) {
    return _then(
      _$AiChatResponseImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        errors:
            null == errors
                ? _value._errors
                : errors // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        messages:
            null == messages
                ? _value._messages
                : messages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        result:
            null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                    as AiChatResult,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatResponseImpl implements _AiChatResponse {
  const _$AiChatResponseImpl({
    required this.success,
    required final List<String> errors,
    required final List<String> messages,
    required this.result,
  }) : _errors = errors,
       _messages = messages;

  factory _$AiChatResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatResponseImplFromJson(json);

  @override
  final bool success;
  final List<String> _errors;
  @override
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  final List<String> _messages;
  @override
  List<String> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final AiChatResult result;

  @override
  String toString() {
    return 'AiChatResponse(success: $success, errors: $errors, messages: $messages, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_errors),
    const DeepCollectionEquality().hash(_messages),
    result,
  );

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatResponseImplCopyWith<_$AiChatResponseImpl> get copyWith =>
      __$$AiChatResponseImplCopyWithImpl<_$AiChatResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatResponseImplToJson(this);
  }
}

abstract class _AiChatResponse implements AiChatResponse {
  const factory _AiChatResponse({
    required final bool success,
    required final List<String> errors,
    required final List<String> messages,
    required final AiChatResult result,
  }) = _$AiChatResponseImpl;

  factory _AiChatResponse.fromJson(Map<String, dynamic> json) =
      _$AiChatResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<String> get errors;
  @override
  List<String> get messages;
  @override
  AiChatResult get result;

  /// Create a copy of AiChatResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatResponseImplCopyWith<_$AiChatResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiChatResult _$AiChatResultFromJson(Map<String, dynamic> json) {
  return _AiChatResult.fromJson(json);
}

/// @nodoc
mixin _$AiChatResult {
  String get response => throw _privateConstructorUsedError;

  /// Serializes this AiChatResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatResultCopyWith<AiChatResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatResultCopyWith<$Res> {
  factory $AiChatResultCopyWith(
    AiChatResult value,
    $Res Function(AiChatResult) then,
  ) = _$AiChatResultCopyWithImpl<$Res, AiChatResult>;
  @useResult
  $Res call({String response});
}

/// @nodoc
class _$AiChatResultCopyWithImpl<$Res, $Val extends AiChatResult>
    implements $AiChatResultCopyWith<$Res> {
  _$AiChatResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null}) {
    return _then(
      _value.copyWith(
            response:
                null == response
                    ? _value.response
                    : response // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiChatResultImplCopyWith<$Res>
    implements $AiChatResultCopyWith<$Res> {
  factory _$$AiChatResultImplCopyWith(
    _$AiChatResultImpl value,
    $Res Function(_$AiChatResultImpl) then,
  ) = __$$AiChatResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String response});
}

/// @nodoc
class __$$AiChatResultImplCopyWithImpl<$Res>
    extends _$AiChatResultCopyWithImpl<$Res, _$AiChatResultImpl>
    implements _$$AiChatResultImplCopyWith<$Res> {
  __$$AiChatResultImplCopyWithImpl(
    _$AiChatResultImpl _value,
    $Res Function(_$AiChatResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null}) {
    return _then(
      _$AiChatResultImpl(
        response:
            null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatResultImpl implements _AiChatResult {
  const _$AiChatResultImpl({required this.response});

  factory _$AiChatResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatResultImplFromJson(json);

  @override
  final String response;

  @override
  String toString() {
    return 'AiChatResult(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatResultImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of AiChatResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatResultImplCopyWith<_$AiChatResultImpl> get copyWith =>
      __$$AiChatResultImplCopyWithImpl<_$AiChatResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatResultImplToJson(this);
  }
}

abstract class _AiChatResult implements AiChatResult {
  const factory _AiChatResult({required final String response}) =
      _$AiChatResultImpl;

  factory _AiChatResult.fromJson(Map<String, dynamic> json) =
      _$AiChatResultImpl.fromJson;

  @override
  String get response;

  /// Create a copy of AiChatResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatResultImplCopyWith<_$AiChatResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isUser => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String id,
    String content,
    bool isUser,
    DateTime timestamp,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            isUser:
                null == isUser
                    ? _value.isUser
                    : isUser // ignore: cast_nullable_to_non_nullable
                        as bool,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    bool isUser,
    DateTime timestamp,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        isUser:
            null == isUser
                ? _value.isUser
                : isUser // ignore: cast_nullable_to_non_nullable
                    as bool,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.isLoading = false,
    this.error,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'ChatMessage(id: $id, content: $content, isUser: $isUser, timestamp: $timestamp, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    isUser,
    timestamp,
    isLoading,
    error,
  );

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String content,
    required final bool isUser,
    required final DateTime timestamp,
    final bool isLoading,
    final String? error,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  bool get isUser;
  @override
  DateTime get timestamp;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageInfo _$UsageInfoFromJson(Map<String, dynamic> json) {
  return _UsageInfo.fromJson(json);
}

/// @nodoc
mixin _$UsageInfo {
  int get remaining => throw _privateConstructorUsedError;
  int get used => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  bool get isApproachingLimit => throw _privateConstructorUsedError;
  Duration get timeUntilReset => throw _privateConstructorUsedError;

  /// Serializes this UsageInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageInfoCopyWith<UsageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageInfoCopyWith<$Res> {
  factory $UsageInfoCopyWith(UsageInfo value, $Res Function(UsageInfo) then) =
      _$UsageInfoCopyWithImpl<$Res, UsageInfo>;
  @useResult
  $Res call({
    int remaining,
    int used,
    int total,
    bool isApproachingLimit,
    Duration timeUntilReset,
  });
}

/// @nodoc
class _$UsageInfoCopyWithImpl<$Res, $Val extends UsageInfo>
    implements $UsageInfoCopyWith<$Res> {
  _$UsageInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remaining = null,
    Object? used = null,
    Object? total = null,
    Object? isApproachingLimit = null,
    Object? timeUntilReset = null,
  }) {
    return _then(
      _value.copyWith(
            remaining:
                null == remaining
                    ? _value.remaining
                    : remaining // ignore: cast_nullable_to_non_nullable
                        as int,
            used:
                null == used
                    ? _value.used
                    : used // ignore: cast_nullable_to_non_nullable
                        as int,
            total:
                null == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int,
            isApproachingLimit:
                null == isApproachingLimit
                    ? _value.isApproachingLimit
                    : isApproachingLimit // ignore: cast_nullable_to_non_nullable
                        as bool,
            timeUntilReset:
                null == timeUntilReset
                    ? _value.timeUntilReset
                    : timeUntilReset // ignore: cast_nullable_to_non_nullable
                        as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsageInfoImplCopyWith<$Res>
    implements $UsageInfoCopyWith<$Res> {
  factory _$$UsageInfoImplCopyWith(
    _$UsageInfoImpl value,
    $Res Function(_$UsageInfoImpl) then,
  ) = __$$UsageInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int remaining,
    int used,
    int total,
    bool isApproachingLimit,
    Duration timeUntilReset,
  });
}

/// @nodoc
class __$$UsageInfoImplCopyWithImpl<$Res>
    extends _$UsageInfoCopyWithImpl<$Res, _$UsageInfoImpl>
    implements _$$UsageInfoImplCopyWith<$Res> {
  __$$UsageInfoImplCopyWithImpl(
    _$UsageInfoImpl _value,
    $Res Function(_$UsageInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remaining = null,
    Object? used = null,
    Object? total = null,
    Object? isApproachingLimit = null,
    Object? timeUntilReset = null,
  }) {
    return _then(
      _$UsageInfoImpl(
        remaining:
            null == remaining
                ? _value.remaining
                : remaining // ignore: cast_nullable_to_non_nullable
                    as int,
        used:
            null == used
                ? _value.used
                : used // ignore: cast_nullable_to_non_nullable
                    as int,
        total:
            null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int,
        isApproachingLimit:
            null == isApproachingLimit
                ? _value.isApproachingLimit
                : isApproachingLimit // ignore: cast_nullable_to_non_nullable
                    as bool,
        timeUntilReset:
            null == timeUntilReset
                ? _value.timeUntilReset
                : timeUntilReset // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageInfoImpl implements _UsageInfo {
  const _$UsageInfoImpl({
    required this.remaining,
    required this.used,
    required this.total,
    required this.isApproachingLimit,
    required this.timeUntilReset,
  });

  factory _$UsageInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageInfoImplFromJson(json);

  @override
  final int remaining;
  @override
  final int used;
  @override
  final int total;
  @override
  final bool isApproachingLimit;
  @override
  final Duration timeUntilReset;

  @override
  String toString() {
    return 'UsageInfo(remaining: $remaining, used: $used, total: $total, isApproachingLimit: $isApproachingLimit, timeUntilReset: $timeUntilReset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageInfoImpl &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isApproachingLimit, isApproachingLimit) ||
                other.isApproachingLimit == isApproachingLimit) &&
            (identical(other.timeUntilReset, timeUntilReset) ||
                other.timeUntilReset == timeUntilReset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    remaining,
    used,
    total,
    isApproachingLimit,
    timeUntilReset,
  );

  /// Create a copy of UsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageInfoImplCopyWith<_$UsageInfoImpl> get copyWith =>
      __$$UsageInfoImplCopyWithImpl<_$UsageInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageInfoImplToJson(this);
  }
}

abstract class _UsageInfo implements UsageInfo {
  const factory _UsageInfo({
    required final int remaining,
    required final int used,
    required final int total,
    required final bool isApproachingLimit,
    required final Duration timeUntilReset,
  }) = _$UsageInfoImpl;

  factory _UsageInfo.fromJson(Map<String, dynamic> json) =
      _$UsageInfoImpl.fromJson;

  @override
  int get remaining;
  @override
  int get used;
  @override
  int get total;
  @override
  bool get isApproachingLimit;
  @override
  Duration get timeUntilReset;

  /// Create a copy of UsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageInfoImplCopyWith<_$UsageInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
