// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatListResponse _$ChatListResponseFromJson(Map<String, dynamic> json) {
  return _ChatListResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatListResponse {
  List<ChatThread> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ChatListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatListResponseCopyWith<ChatListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListResponseCopyWith<$Res> {
  factory $ChatListResponseCopyWith(
    ChatListResponse value,
    $Res Function(ChatListResponse) then,
  ) = _$ChatListResponseCopyWithImpl<$Res, ChatListResponse>;
  @useResult
  $Res call({
    List<ChatThread> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ChatListResponseCopyWithImpl<$Res, $Val extends ChatListResponse>
    implements $ChatListResponseCopyWith<$Res> {
  _$ChatListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<ChatThread>,
            pagination:
                null == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatListResponseImplCopyWith<$Res>
    implements $ChatListResponseCopyWith<$Res> {
  factory _$$ChatListResponseImplCopyWith(
    _$ChatListResponseImpl value,
    $Res Function(_$ChatListResponseImpl) then,
  ) = __$$ChatListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatThread> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ChatListResponseImplCopyWithImpl<$Res>
    extends _$ChatListResponseCopyWithImpl<$Res, _$ChatListResponseImpl>
    implements _$$ChatListResponseImplCopyWith<$Res> {
  __$$ChatListResponseImplCopyWithImpl(
    _$ChatListResponseImpl _value,
    $Res Function(_$ChatListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ChatListResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<ChatThread>,
        pagination:
            null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListResponseImpl implements _ChatListResponse {
  const _$ChatListResponseImpl({
    required final List<ChatThread> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
  }) : _data = data;

  factory _$ChatListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListResponseImplFromJson(json);

  final List<ChatThread> _data;
  @override
  List<ChatThread> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Pagination pagination;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ChatListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
  );

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListResponseImplCopyWith<_$ChatListResponseImpl> get copyWith =>
      __$$ChatListResponseImplCopyWithImpl<_$ChatListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatListResponseImplToJson(this);
  }
}

abstract class _ChatListResponse implements ChatListResponse {
  const factory _ChatListResponse({
    required final List<ChatThread> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
  }) = _$ChatListResponseImpl;

  factory _ChatListResponse.fromJson(Map<String, dynamic> json) =
      _$ChatListResponseImpl.fromJson;

  @override
  List<ChatThread> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListResponseImplCopyWith<_$ChatListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatThread _$ChatThreadFromJson(Map<String, dynamic> json) {
  return _ChatThread.fromJson(json);
}

/// @nodoc
mixin _$ChatThread {
  String get id =>
      throw _privateConstructorUsedError; // required DateTime createdAt,
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel? get client =>
      throw _privateConstructorUsedError; // Make client nullable
  List<UserModel> get group =>
      throw _privateConstructorUsedError; // Add group list
  UserModel get therapist =>
      throw _privateConstructorUsedError; // required List<ChatMessage> message,
  List<ChatMessage>? get message => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  int? get unreadCount => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;

  /// Serializes this ChatThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThreadCopyWith<ChatThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThreadCopyWith<$Res> {
  factory $ChatThreadCopyWith(
    ChatThread value,
    $Res Function(ChatThread) then,
  ) = _$ChatThreadCopyWithImpl<$Res, ChatThread>;
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    UserModel? client,
    List<UserModel> group,
    UserModel therapist,
    List<ChatMessage>? message,
    ChatMessage? lastMessage,
    int? unreadCount,
    String? groupName,
  });

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res> get therapist;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatThreadCopyWithImpl<$Res, $Val extends ChatThread>
    implements $ChatThreadCopyWith<$Res> {
  _$ChatThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? client = freezed,
    Object? group = null,
    Object? therapist = null,
    Object? message = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = freezed,
    Object? groupName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            group:
                null == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as List<UserModel>,
            therapist:
                null == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessage>?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
            unreadCount:
                freezed == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            groupName:
                freezed == groupName
                    ? _value.groupName
                    : groupName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get therapist {
    return $UserModelCopyWith<$Res>(_value.therapist, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatThreadImplCopyWith<$Res>
    implements $ChatThreadCopyWith<$Res> {
  factory _$$ChatThreadImplCopyWith(
    _$ChatThreadImpl value,
    $Res Function(_$ChatThreadImpl) then,
  ) = __$$ChatThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    UserModel? client,
    List<UserModel> group,
    UserModel therapist,
    List<ChatMessage>? message,
    ChatMessage? lastMessage,
    int? unreadCount,
    String? groupName,
  });

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res> get therapist;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatThreadImplCopyWithImpl<$Res>
    extends _$ChatThreadCopyWithImpl<$Res, _$ChatThreadImpl>
    implements _$$ChatThreadImplCopyWith<$Res> {
  __$$ChatThreadImplCopyWithImpl(
    _$ChatThreadImpl _value,
    $Res Function(_$ChatThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? client = freezed,
    Object? group = null,
    Object? therapist = null,
    Object? message = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = freezed,
    Object? groupName = freezed,
  }) {
    return _then(
      _$ChatThreadImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        group:
            null == group
                ? _value._group
                : group // ignore: cast_nullable_to_non_nullable
                    as List<UserModel>,
        therapist:
            null == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        message:
            freezed == message
                ? _value._message
                : message // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessage>?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
        unreadCount:
            freezed == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        groupName:
            freezed == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatThreadImpl implements _ChatThread {
  const _$ChatThreadImpl({
    required this.id,
    this.updatedAt,
    this.client,
    required final List<UserModel> group,
    required this.therapist,
    final List<ChatMessage>? message,
    this.lastMessage,
    this.unreadCount,
    this.groupName,
  }) : _group = group,
       _message = message;

  factory _$ChatThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatThreadImplFromJson(json);

  @override
  final String id;
  // required DateTime createdAt,
  @override
  final DateTime? updatedAt;
  @override
  final UserModel? client;
  // Make client nullable
  final List<UserModel> _group;
  // Make client nullable
  @override
  List<UserModel> get group {
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  // Add group list
  @override
  final UserModel therapist;
  // required List<ChatMessage> message,
  final List<ChatMessage>? _message;
  // required List<ChatMessage> message,
  @override
  List<ChatMessage>? get message {
    final value = _message;
    if (value == null) return null;
    if (_message is EqualUnmodifiableListView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ChatMessage? lastMessage;
  @override
  final int? unreadCount;
  @override
  final String? groupName;

  @override
  String toString() {
    return 'ChatThread(id: $id, updatedAt: $updatedAt, client: $client, group: $group, therapist: $therapist, message: $message, lastMessage: $lastMessage, unreadCount: $unreadCount, groupName: $groupName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.client, client) || other.client == client) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            const DeepCollectionEquality().equals(other._message, _message) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    updatedAt,
    client,
    const DeepCollectionEquality().hash(_group),
    therapist,
    const DeepCollectionEquality().hash(_message),
    lastMessage,
    unreadCount,
    groupName,
  );

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThreadImplCopyWith<_$ChatThreadImpl> get copyWith =>
      __$$ChatThreadImplCopyWithImpl<_$ChatThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatThreadImplToJson(this);
  }
}

abstract class _ChatThread implements ChatThread {
  const factory _ChatThread({
    required final String id,
    final DateTime? updatedAt,
    final UserModel? client,
    required final List<UserModel> group,
    required final UserModel therapist,
    final List<ChatMessage>? message,
    final ChatMessage? lastMessage,
    final int? unreadCount,
    final String? groupName,
  }) = _$ChatThreadImpl;

  factory _ChatThread.fromJson(Map<String, dynamic> json) =
      _$ChatThreadImpl.fromJson;

  @override
  String get id; // required DateTime createdAt,
  @override
  DateTime? get updatedAt;
  @override
  UserModel? get client; // Make client nullable
  @override
  List<UserModel> get group; // Add group list
  @override
  UserModel get therapist; // required List<ChatMessage> message,
  @override
  List<ChatMessage>? get message;
  @override
  ChatMessage? get lastMessage;
  @override
  int? get unreadCount;
  @override
  String? get groupName;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThreadImplCopyWith<_$ChatThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageResponse _$ChatMessageResponseFromJson(Map<String, dynamic> json) {
  return _ChatMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageResponse {
  List<ChatMessageDetail> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageResponseCopyWith<ChatMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageResponseCopyWith<$Res> {
  factory $ChatMessageResponseCopyWith(
    ChatMessageResponse value,
    $Res Function(ChatMessageResponse) then,
  ) = _$ChatMessageResponseCopyWithImpl<$Res, ChatMessageResponse>;
  @useResult
  $Res call({
    List<ChatMessageDetail> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ChatMessageResponseCopyWithImpl<$Res, $Val extends ChatMessageResponse>
    implements $ChatMessageResponseCopyWith<$Res> {
  _$ChatMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessageDetail>,
            pagination:
                null == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageResponseImplCopyWith<$Res>
    implements $ChatMessageResponseCopyWith<$Res> {
  factory _$$ChatMessageResponseImplCopyWith(
    _$ChatMessageResponseImpl value,
    $Res Function(_$ChatMessageResponseImpl) then,
  ) = __$$ChatMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatMessageDetail> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ChatMessageResponseImplCopyWithImpl<$Res>
    extends _$ChatMessageResponseCopyWithImpl<$Res, _$ChatMessageResponseImpl>
    implements _$$ChatMessageResponseImplCopyWith<$Res> {
  __$$ChatMessageResponseImplCopyWithImpl(
    _$ChatMessageResponseImpl _value,
    $Res Function(_$ChatMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ChatMessageResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessageDetail>,
        pagination:
            null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageResponseImpl implements _ChatMessageResponse {
  const _$ChatMessageResponseImpl({
    required final List<ChatMessageDetail> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
  }) : _data = data;

  factory _$ChatMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageResponseImplFromJson(json);

  final List<ChatMessageDetail> _data;
  @override
  List<ChatMessageDetail> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Pagination pagination;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ChatMessageResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
  );

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageResponseImplCopyWith<_$ChatMessageResponseImpl> get copyWith =>
      __$$ChatMessageResponseImplCopyWithImpl<_$ChatMessageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageResponseImplToJson(this);
  }
}

abstract class _ChatMessageResponse implements ChatMessageResponse {
  const factory _ChatMessageResponse({
    required final List<ChatMessageDetail> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
  }) = _$ChatMessageResponseImpl;

  factory _ChatMessageResponse.fromJson(Map<String, dynamic> json) =
      _$ChatMessageResponseImpl.fromJson;

  @override
  List<ChatMessageDetail> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageResponseImplCopyWith<_$ChatMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageDetail _$ChatMessageDetailFromJson(Map<String, dynamic> json) {
  return _ChatMessageDetail.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageDetail {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  UserModel? get therapist => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  bool? get isRead =>
      throw _privateConstructorUsedError; // UI-only fields (ignored by JSON)
  @JsonKey(ignore: true)
  bool get isPending => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFailed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get localId => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageDetailCopyWith<ChatMessageDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDetailCopyWith<$Res> {
  factory $ChatMessageDetailCopyWith(
    ChatMessageDetail value,
    $Res Function(ChatMessageDetail) then,
  ) = _$ChatMessageDetailCopyWithImpl<$Res, ChatMessageDetail>;
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    UserModel? therapist,
    UserModel? client,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    bool? isRead,
    @JsonKey(ignore: true) bool isPending,
    @JsonKey(ignore: true) bool isFailed,
    @JsonKey(ignore: true) String? localId,
  });

  $UserModelCopyWith<$Res>? get therapist;
  $UserModelCopyWith<$Res>? get client;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatMessageDetailCopyWithImpl<$Res, $Val extends ChatMessageDetail>
    implements $ChatMessageDetailCopyWith<$Res> {
  _$ChatMessageDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? therapist = freezed,
    Object? client = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? isRead = freezed,
    Object? isPending = null,
    Object? isFailed = null,
    Object? localId = freezed,
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
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            therapist:
                freezed == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
            isRead:
                freezed == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isPending:
                null == isPending
                    ? _value.isPending
                    : isPending // ignore: cast_nullable_to_non_nullable
                        as bool,
            isFailed:
                null == isFailed
                    ? _value.isFailed
                    : isFailed // ignore: cast_nullable_to_non_nullable
                        as bool,
            localId:
                freezed == localId
                    ? _value.localId
                    : localId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get therapist {
    if (_value.therapist == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.therapist!, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageDetailImplCopyWith<$Res>
    implements $ChatMessageDetailCopyWith<$Res> {
  factory _$$ChatMessageDetailImplCopyWith(
    _$ChatMessageDetailImpl value,
    $Res Function(_$ChatMessageDetailImpl) then,
  ) = __$$ChatMessageDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    UserModel? therapist,
    UserModel? client,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    bool? isRead,
    @JsonKey(ignore: true) bool isPending,
    @JsonKey(ignore: true) bool isFailed,
    @JsonKey(ignore: true) String? localId,
  });

  @override
  $UserModelCopyWith<$Res>? get therapist;
  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatMessageDetailImplCopyWithImpl<$Res>
    extends _$ChatMessageDetailCopyWithImpl<$Res, _$ChatMessageDetailImpl>
    implements _$$ChatMessageDetailImplCopyWith<$Res> {
  __$$ChatMessageDetailImplCopyWithImpl(
    _$ChatMessageDetailImpl _value,
    $Res Function(_$ChatMessageDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? therapist = freezed,
    Object? client = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? isRead = freezed,
    Object? isPending = null,
    Object? isFailed = null,
    Object? localId = freezed,
  }) {
    return _then(
      _$ChatMessageDetailImpl(
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
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        therapist:
            freezed == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
        isRead:
            freezed == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isPending:
            null == isPending
                ? _value.isPending
                : isPending // ignore: cast_nullable_to_non_nullable
                    as bool,
        isFailed:
            null == isFailed
                ? _value.isFailed
                : isFailed // ignore: cast_nullable_to_non_nullable
                    as bool,
        localId:
            freezed == localId
                ? _value.localId
                : localId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageDetailImpl implements _ChatMessageDetail {
  const _$ChatMessageDetailImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.therapist,
    required this.client,
    this.updatedAt,
    this.lastMessage,
    this.isRead,
    @JsonKey(ignore: true) this.isPending = false,
    @JsonKey(ignore: true) this.isFailed = false,
    @JsonKey(ignore: true) this.localId,
  });

  factory _$ChatMessageDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final UserModel? therapist;
  @override
  final UserModel? client;
  @override
  final DateTime? updatedAt;
  @override
  final ChatMessage? lastMessage;
  @override
  final bool? isRead;
  // UI-only fields (ignored by JSON)
  @override
  @JsonKey(ignore: true)
  final bool isPending;
  @override
  @JsonKey(ignore: true)
  final bool isFailed;
  @override
  @JsonKey(ignore: true)
  final String? localId;

  @override
  String toString() {
    return 'ChatMessageDetail(id: $id, content: $content, createdAt: $createdAt, therapist: $therapist, client: $client, updatedAt: $updatedAt, lastMessage: $lastMessage, isRead: $isRead, isPending: $isPending, isFailed: $isFailed, localId: $localId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isPending, isPending) ||
                other.isPending == isPending) &&
            (identical(other.isFailed, isFailed) ||
                other.isFailed == isFailed) &&
            (identical(other.localId, localId) || other.localId == localId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    createdAt,
    therapist,
    client,
    updatedAt,
    lastMessage,
    isRead,
    isPending,
    isFailed,
    localId,
  );

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDetailImplCopyWith<_$ChatMessageDetailImpl> get copyWith =>
      __$$ChatMessageDetailImplCopyWithImpl<_$ChatMessageDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDetailImplToJson(this);
  }
}

abstract class _ChatMessageDetail implements ChatMessageDetail {
  const factory _ChatMessageDetail({
    required final String id,
    required final String content,
    required final DateTime createdAt,
    required final UserModel? therapist,
    required final UserModel? client,
    final DateTime? updatedAt,
    final ChatMessage? lastMessage,
    final bool? isRead,
    @JsonKey(ignore: true) final bool isPending,
    @JsonKey(ignore: true) final bool isFailed,
    @JsonKey(ignore: true) final String? localId,
  }) = _$ChatMessageDetailImpl;

  factory _ChatMessageDetail.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  UserModel? get therapist;
  @override
  UserModel? get client;
  @override
  DateTime? get updatedAt;
  @override
  ChatMessage? get lastMessage;
  @override
  bool? get isRead; // UI-only fields (ignored by JSON)
  @override
  @JsonKey(ignore: true)
  bool get isPending;
  @override
  @JsonKey(ignore: true)
  bool get isFailed;
  @override
  @JsonKey(ignore: true)
  String? get localId;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageDetailImplCopyWith<_$ChatMessageDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // required String senderId,
  bool? get isRead => throw _privateConstructorUsedError;

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
  $Res call({String id, String content, DateTime createdAt, bool? isRead});
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
    Object? createdAt = null,
    Object? isRead = freezed,
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
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isRead:
                freezed == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool?,
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
  $Res call({String id, String content, DateTime createdAt, bool? isRead});
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
    Object? createdAt = null,
    Object? isRead = freezed,
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
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isRead:
            freezed == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool?,
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
    required this.createdAt,
    this.isRead,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  // required String senderId,
  @override
  final bool? isRead;

  @override
  String toString() {
    return 'ChatMessage(id: $id, content: $content, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt, isRead);

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
    required final DateTime createdAt,
    final bool? isRead,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt; // required String senderId,
  @override
  bool? get isRead;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageSendResponse _$MessageSendResponseFromJson(Map<String, dynamic> json) {
  return _MessageSendResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageSendResponse {
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MessageSendResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageSendResponseCopyWith<MessageSendResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSendResponseCopyWith<$Res> {
  factory $MessageSendResponseCopyWith(
    MessageSendResponse value,
    $Res Function(MessageSendResponse) then,
  ) = _$MessageSendResponseCopyWithImpl<$Res, MessageSendResponse>;
  @useResult
  $Res call({
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class _$MessageSendResponseCopyWithImpl<$Res, $Val extends MessageSendResponse>
    implements $MessageSendResponseCopyWith<$Res> {
  _$MessageSendResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
            method:
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageSendResponseImplCopyWith<$Res>
    implements $MessageSendResponseCopyWith<$Res> {
  factory _$$MessageSendResponseImplCopyWith(
    _$MessageSendResponseImpl value,
    $Res Function(_$MessageSendResponseImpl) then,
  ) = __$$MessageSendResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$MessageSendResponseImplCopyWithImpl<$Res>
    extends _$MessageSendResponseCopyWithImpl<$Res, _$MessageSendResponseImpl>
    implements _$$MessageSendResponseImplCopyWith<$Res> {
  __$$MessageSendResponseImplCopyWithImpl(
    _$MessageSendResponseImpl _value,
    $Res Function(_$MessageSendResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$MessageSendResponseImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
        method:
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageSendResponseImpl implements _MessageSendResponse {
  const _$MessageSendResponseImpl({
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$MessageSendResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageSendResponseImplFromJson(json);

  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MessageSendResponse(message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSendResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, message, statusCode, method, path, timestamp);

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageSendResponseImplCopyWith<_$MessageSendResponseImpl> get copyWith =>
      __$$MessageSendResponseImplCopyWithImpl<_$MessageSendResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageSendResponseImplToJson(this);
  }
}

abstract class _MessageSendResponse implements MessageSendResponse {
  const factory _MessageSendResponse({
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$MessageSendResponseImpl;

  factory _MessageSendResponse.fromJson(Map<String, dynamic> json) =
      _$MessageSendResponseImpl.fromJson;

  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageSendResponseImplCopyWith<_$MessageSendResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupChatCreateResponse _$GroupChatCreateResponseFromJson(
  Map<String, dynamic> json,
) {
  return _GroupChatCreateResponse.fromJson(json);
}

/// @nodoc
mixin _$GroupChatCreateResponse {
  GroupChatData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this GroupChatCreateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupChatCreateResponseCopyWith<GroupChatCreateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupChatCreateResponseCopyWith<$Res> {
  factory $GroupChatCreateResponseCopyWith(
    GroupChatCreateResponse value,
    $Res Function(GroupChatCreateResponse) then,
  ) = _$GroupChatCreateResponseCopyWithImpl<$Res, GroupChatCreateResponse>;
  @useResult
  $Res call({
    GroupChatData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $GroupChatDataCopyWith<$Res> get data;
}

/// @nodoc
class _$GroupChatCreateResponseCopyWithImpl<
  $Res,
  $Val extends GroupChatCreateResponse
>
    implements $GroupChatCreateResponseCopyWith<$Res> {
  _$GroupChatCreateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as GroupChatData,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
            method:
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupChatDataCopyWith<$Res> get data {
    return $GroupChatDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupChatCreateResponseImplCopyWith<$Res>
    implements $GroupChatCreateResponseCopyWith<$Res> {
  factory _$$GroupChatCreateResponseImplCopyWith(
    _$GroupChatCreateResponseImpl value,
    $Res Function(_$GroupChatCreateResponseImpl) then,
  ) = __$$GroupChatCreateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupChatData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $GroupChatDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$GroupChatCreateResponseImplCopyWithImpl<$Res>
    extends
        _$GroupChatCreateResponseCopyWithImpl<
          $Res,
          _$GroupChatCreateResponseImpl
        >
    implements _$$GroupChatCreateResponseImplCopyWith<$Res> {
  __$$GroupChatCreateResponseImplCopyWithImpl(
    _$GroupChatCreateResponseImpl _value,
    $Res Function(_$GroupChatCreateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$GroupChatCreateResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as GroupChatData,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
        method:
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupChatCreateResponseImpl implements _GroupChatCreateResponse {
  const _$GroupChatCreateResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$GroupChatCreateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupChatCreateResponseImplFromJson(json);

  @override
  final GroupChatData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'GroupChatCreateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupChatCreateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    data,
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupChatCreateResponseImplCopyWith<_$GroupChatCreateResponseImpl>
  get copyWith => __$$GroupChatCreateResponseImplCopyWithImpl<
    _$GroupChatCreateResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupChatCreateResponseImplToJson(this);
  }
}

abstract class _GroupChatCreateResponse implements GroupChatCreateResponse {
  const factory _GroupChatCreateResponse({
    required final GroupChatData data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$GroupChatCreateResponseImpl;

  factory _GroupChatCreateResponse.fromJson(Map<String, dynamic> json) =
      _$GroupChatCreateResponseImpl.fromJson;

  @override
  GroupChatData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupChatCreateResponseImplCopyWith<_$GroupChatCreateResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupChatData _$GroupChatDataFromJson(Map<String, dynamic> json) {
  return _GroupChatData.fromJson(json);
}

/// @nodoc
mixin _$GroupChatData {
  List<UserModel>? get group => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  UserModel? get therapist => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;

  /// Serializes this GroupChatData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupChatDataCopyWith<GroupChatData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupChatDataCopyWith<$Res> {
  factory $GroupChatDataCopyWith(
    GroupChatData value,
    $Res Function(GroupChatData) then,
  ) = _$GroupChatDataCopyWithImpl<$Res, GroupChatData>;
  @useResult
  $Res call({
    List<UserModel>? group,
    UserModel? client,
    UserModel? therapist,
    DateTime? updatedAt,
    String id,
    DateTime createdAt,
    DateTime? deletedAt,
    ChatMessage? lastMessage,
  });

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res>? get therapist;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$GroupChatDataCopyWithImpl<$Res, $Val extends GroupChatData>
    implements $GroupChatDataCopyWith<$Res> {
  _$GroupChatDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? updatedAt = freezed,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            group:
                freezed == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as List<UserModel>?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            therapist:
                freezed == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get therapist {
    if (_value.therapist == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.therapist!, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupChatDataImplCopyWith<$Res>
    implements $GroupChatDataCopyWith<$Res> {
  factory _$$GroupChatDataImplCopyWith(
    _$GroupChatDataImpl value,
    $Res Function(_$GroupChatDataImpl) then,
  ) = __$$GroupChatDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<UserModel>? group,
    UserModel? client,
    UserModel? therapist,
    DateTime? updatedAt,
    String id,
    DateTime createdAt,
    DateTime? deletedAt,
    ChatMessage? lastMessage,
  });

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res>? get therapist;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$GroupChatDataImplCopyWithImpl<$Res>
    extends _$GroupChatDataCopyWithImpl<$Res, _$GroupChatDataImpl>
    implements _$$GroupChatDataImplCopyWith<$Res> {
  __$$GroupChatDataImplCopyWithImpl(
    _$GroupChatDataImpl _value,
    $Res Function(_$GroupChatDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? updatedAt = freezed,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _$GroupChatDataImpl(
        group:
            freezed == group
                ? _value._group
                : group // ignore: cast_nullable_to_non_nullable
                    as List<UserModel>?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        therapist:
            freezed == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupChatDataImpl implements _GroupChatData {
  const _$GroupChatDataImpl({
    required final List<UserModel>? group,
    required this.client,
    required this.therapist,
    required this.updatedAt,
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    this.lastMessage,
  }) : _group = group;

  factory _$GroupChatDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupChatDataImplFromJson(json);

  final List<UserModel>? _group;
  @override
  List<UserModel>? get group {
    final value = _group;
    if (value == null) return null;
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserModel? client;
  @override
  final UserModel? therapist;
  @override
  final DateTime? updatedAt;
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? deletedAt;
  @override
  final ChatMessage? lastMessage;

  @override
  String toString() {
    return 'GroupChatData(group: $group, client: $client, therapist: $therapist, updatedAt: $updatedAt, id: $id, createdAt: $createdAt, deletedAt: $deletedAt, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupChatDataImpl &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_group),
    client,
    therapist,
    updatedAt,
    id,
    createdAt,
    deletedAt,
    lastMessage,
  );

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupChatDataImplCopyWith<_$GroupChatDataImpl> get copyWith =>
      __$$GroupChatDataImplCopyWithImpl<_$GroupChatDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupChatDataImplToJson(this);
  }
}

abstract class _GroupChatData implements GroupChatData {
  const factory _GroupChatData({
    required final List<UserModel>? group,
    required final UserModel? client,
    required final UserModel? therapist,
    required final DateTime? updatedAt,
    required final String id,
    required final DateTime createdAt,
    required final DateTime? deletedAt,
    final ChatMessage? lastMessage,
  }) = _$GroupChatDataImpl;

  factory _GroupChatData.fromJson(Map<String, dynamic> json) =
      _$GroupChatDataImpl.fromJson;

  @override
  List<UserModel>? get group;
  @override
  UserModel? get client;
  @override
  UserModel? get therapist;
  @override
  DateTime? get updatedAt;
  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  DateTime? get deletedAt;
  @override
  ChatMessage? get lastMessage;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupChatDataImplCopyWith<_$GroupChatDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TherapistInfoResponse _$TherapistInfoResponseFromJson(
  Map<String, dynamic> json,
) {
  return _TherapistInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$TherapistInfoResponse {
  UserModel get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this TherapistInfoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TherapistInfoResponseCopyWith<TherapistInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TherapistInfoResponseCopyWith<$Res> {
  factory $TherapistInfoResponseCopyWith(
    TherapistInfoResponse value,
    $Res Function(TherapistInfoResponse) then,
  ) = _$TherapistInfoResponseCopyWithImpl<$Res, TherapistInfoResponse>;
  @useResult
  $Res call({
    UserModel data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class _$TherapistInfoResponseCopyWithImpl<
  $Res,
  $Val extends TherapistInfoResponse
>
    implements $TherapistInfoResponseCopyWith<$Res> {
  _$TherapistInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
            method:
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get data {
    return $UserModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TherapistInfoResponseImplCopyWith<$Res>
    implements $TherapistInfoResponseCopyWith<$Res> {
  factory _$$TherapistInfoResponseImplCopyWith(
    _$TherapistInfoResponseImpl value,
    $Res Function(_$TherapistInfoResponseImpl) then,
  ) = __$$TherapistInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserModel data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$TherapistInfoResponseImplCopyWithImpl<$Res>
    extends
        _$TherapistInfoResponseCopyWithImpl<$Res, _$TherapistInfoResponseImpl>
    implements _$$TherapistInfoResponseImplCopyWith<$Res> {
  __$$TherapistInfoResponseImplCopyWithImpl(
    _$TherapistInfoResponseImpl _value,
    $Res Function(_$TherapistInfoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$TherapistInfoResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
        method:
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TherapistInfoResponseImpl implements _TherapistInfoResponse {
  const _$TherapistInfoResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$TherapistInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TherapistInfoResponseImplFromJson(json);

  @override
  final UserModel data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'TherapistInfoResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TherapistInfoResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    data,
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TherapistInfoResponseImplCopyWith<_$TherapistInfoResponseImpl>
  get copyWith =>
      __$$TherapistInfoResponseImplCopyWithImpl<_$TherapistInfoResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TherapistInfoResponseImplToJson(this);
  }
}

abstract class _TherapistInfoResponse implements TherapistInfoResponse {
  const factory _TherapistInfoResponse({
    required final UserModel data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$TherapistInfoResponseImpl;

  factory _TherapistInfoResponse.fromJson(Map<String, dynamic> json) =
      _$TherapistInfoResponseImpl.fromJson;

  @override
  UserModel get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of TherapistInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TherapistInfoResponseImplCopyWith<_$TherapistInfoResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MarkAsReadResponse _$MarkAsReadResponseFromJson(Map<String, dynamic> json) {
  return _MarkAsReadResponse.fromJson(json);
}

/// @nodoc
mixin _$MarkAsReadResponse {
  MarkAsReadData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MarkAsReadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkAsReadResponseCopyWith<MarkAsReadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkAsReadResponseCopyWith<$Res> {
  factory $MarkAsReadResponseCopyWith(
    MarkAsReadResponse value,
    $Res Function(MarkAsReadResponse) then,
  ) = _$MarkAsReadResponseCopyWithImpl<$Res, MarkAsReadResponse>;
  @useResult
  $Res call({
    MarkAsReadData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $MarkAsReadDataCopyWith<$Res> get data;
}

/// @nodoc
class _$MarkAsReadResponseCopyWithImpl<$Res, $Val extends MarkAsReadResponse>
    implements $MarkAsReadResponseCopyWith<$Res> {
  _$MarkAsReadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as MarkAsReadData,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
            method:
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarkAsReadDataCopyWith<$Res> get data {
    return $MarkAsReadDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarkAsReadResponseImplCopyWith<$Res>
    implements $MarkAsReadResponseCopyWith<$Res> {
  factory _$$MarkAsReadResponseImplCopyWith(
    _$MarkAsReadResponseImpl value,
    $Res Function(_$MarkAsReadResponseImpl) then,
  ) = __$$MarkAsReadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MarkAsReadData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $MarkAsReadDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$MarkAsReadResponseImplCopyWithImpl<$Res>
    extends _$MarkAsReadResponseCopyWithImpl<$Res, _$MarkAsReadResponseImpl>
    implements _$$MarkAsReadResponseImplCopyWith<$Res> {
  __$$MarkAsReadResponseImplCopyWithImpl(
    _$MarkAsReadResponseImpl _value,
    $Res Function(_$MarkAsReadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$MarkAsReadResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as MarkAsReadData,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
        method:
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkAsReadResponseImpl implements _MarkAsReadResponse {
  const _$MarkAsReadResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$MarkAsReadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkAsReadResponseImplFromJson(json);

  @override
  final MarkAsReadData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MarkAsReadResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    data,
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadResponseImplCopyWith<_$MarkAsReadResponseImpl> get copyWith =>
      __$$MarkAsReadResponseImplCopyWithImpl<_$MarkAsReadResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkAsReadResponseImplToJson(this);
  }
}

abstract class _MarkAsReadResponse implements MarkAsReadResponse {
  const factory _MarkAsReadResponse({
    required final MarkAsReadData data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$MarkAsReadResponseImpl;

  factory _MarkAsReadResponse.fromJson(Map<String, dynamic> json) =
      _$MarkAsReadResponseImpl.fromJson;

  @override
  MarkAsReadData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadResponseImplCopyWith<_$MarkAsReadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkAsReadData _$MarkAsReadDataFromJson(Map<String, dynamic> json) {
  return _MarkAsReadData.fromJson(json);
}

/// @nodoc
mixin _$MarkAsReadData {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this MarkAsReadData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkAsReadDataCopyWith<MarkAsReadData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkAsReadDataCopyWith<$Res> {
  factory $MarkAsReadDataCopyWith(
    MarkAsReadData value,
    $Res Function(MarkAsReadData) then,
  ) = _$MarkAsReadDataCopyWithImpl<$Res, MarkAsReadData>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$MarkAsReadDataCopyWithImpl<$Res, $Val extends MarkAsReadData>
    implements $MarkAsReadDataCopyWith<$Res> {
  _$MarkAsReadDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarkAsReadDataImplCopyWith<$Res>
    implements $MarkAsReadDataCopyWith<$Res> {
  factory _$$MarkAsReadDataImplCopyWith(
    _$MarkAsReadDataImpl value,
    $Res Function(_$MarkAsReadDataImpl) then,
  ) = __$$MarkAsReadDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$MarkAsReadDataImplCopyWithImpl<$Res>
    extends _$MarkAsReadDataCopyWithImpl<$Res, _$MarkAsReadDataImpl>
    implements _$$MarkAsReadDataImplCopyWith<$Res> {
  __$$MarkAsReadDataImplCopyWithImpl(
    _$MarkAsReadDataImpl _value,
    $Res Function(_$MarkAsReadDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _$MarkAsReadDataImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkAsReadDataImpl implements _MarkAsReadData {
  const _$MarkAsReadDataImpl({required this.success, required this.message});

  factory _$MarkAsReadDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkAsReadDataImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'MarkAsReadData(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadDataImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadDataImplCopyWith<_$MarkAsReadDataImpl> get copyWith =>
      __$$MarkAsReadDataImplCopyWithImpl<_$MarkAsReadDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkAsReadDataImplToJson(this);
  }
}

abstract class _MarkAsReadData implements MarkAsReadData {
  const factory _MarkAsReadData({
    required final bool success,
    required final String message,
  }) = _$MarkAsReadDataImpl;

  factory _MarkAsReadData.fromJson(Map<String, dynamic> json) =
      _$MarkAsReadDataImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadDataImplCopyWith<_$MarkAsReadDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
