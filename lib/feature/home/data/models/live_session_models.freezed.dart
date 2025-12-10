// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_session_models.dart';

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
  List<ChatItem> get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

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
    List<ChatItem> data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  $PaginationCopyWith<$Res>? get pagination;
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
    Object? pagination = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<ChatItem>,
            pagination:
                freezed == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            statusCode:
                freezed == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int?,
            method:
                freezed == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String?,
            path:
                freezed == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String?,
            timestamp:
                freezed == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationCopyWith<$Res>(_value.pagination!, (value) {
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
    List<ChatItem> data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  @override
  $PaginationCopyWith<$Res>? get pagination;
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
    Object? pagination = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$ChatListResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<ChatItem>,
        pagination:
            freezed == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
        method:
            freezed == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String?,
        path:
            freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String?,
        timestamp:
            freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListResponseImpl implements _ChatListResponse {
  const _$ChatListResponseImpl({
    required final List<ChatItem> data,
    this.pagination,
    this.message,
    this.statusCode,
    this.method,
    this.path,
    this.timestamp,
  }) : _data = data;

  factory _$ChatListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListResponseImplFromJson(json);

  final List<ChatItem> _data;
  @override
  List<ChatItem> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Pagination? pagination;
  @override
  final String? message;
  @override
  final int? statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ChatListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
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
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
    method,
    path,
    timestamp,
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
    required final List<ChatItem> data,
    final Pagination? pagination,
    final String? message,
    final int? statusCode,
    final String? method,
    final String? path,
    final DateTime? timestamp,
  }) = _$ChatListResponseImpl;

  factory _ChatListResponse.fromJson(Map<String, dynamic> json) =
      _$ChatListResponseImpl.fromJson;

  @override
  List<ChatItem> get data;
  @override
  Pagination? get pagination;
  @override
  String? get message;
  @override
  int? get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  DateTime? get timestamp;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListResponseImplCopyWith<_$ChatListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatItem _$ChatItemFromJson(Map<String, dynamic> json) {
  return _ChatItem.fromJson(json);
}

/// @nodoc
mixin _$ChatItem {
  String get id => throw _privateConstructorUsedError;
  String? get activeCallRoom => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<UserModel>? get group => throw _privateConstructorUsedError;
  LastMessage? get lastMessage => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this ChatItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatItemCopyWith<ChatItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatItemCopyWith<$Res> {
  factory $ChatItemCopyWith(ChatItem value, $Res Function(ChatItem) then) =
      _$ChatItemCopyWithImpl<$Res, ChatItem>;
  @useResult
  $Res call({
    String id,
    String? activeCallRoom,
    String? groupName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<UserModel>? group,
    LastMessage? lastMessage,
    int unreadCount,
  });

  $LastMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatItemCopyWithImpl<$Res, $Val extends ChatItem>
    implements $ChatItemCopyWith<$Res> {
  _$ChatItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activeCallRoom = freezed,
    Object? groupName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? group = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            activeCallRoom:
                freezed == activeCallRoom
                    ? _value.activeCallRoom
                    : activeCallRoom // ignore: cast_nullable_to_non_nullable
                        as String?,
            groupName:
                freezed == groupName
                    ? _value.groupName
                    : groupName // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            group:
                freezed == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as List<UserModel>?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as LastMessage?,
            unreadCount:
                null == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $LastMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatItemImplCopyWith<$Res>
    implements $ChatItemCopyWith<$Res> {
  factory _$$ChatItemImplCopyWith(
    _$ChatItemImpl value,
    $Res Function(_$ChatItemImpl) then,
  ) = __$$ChatItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? activeCallRoom,
    String? groupName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<UserModel>? group,
    LastMessage? lastMessage,
    int unreadCount,
  });

  @override
  $LastMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatItemImplCopyWithImpl<$Res>
    extends _$ChatItemCopyWithImpl<$Res, _$ChatItemImpl>
    implements _$$ChatItemImplCopyWith<$Res> {
  __$$ChatItemImplCopyWithImpl(
    _$ChatItemImpl _value,
    $Res Function(_$ChatItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activeCallRoom = freezed,
    Object? groupName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? group = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
  }) {
    return _then(
      _$ChatItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        activeCallRoom:
            freezed == activeCallRoom
                ? _value.activeCallRoom
                : activeCallRoom // ignore: cast_nullable_to_non_nullable
                    as String?,
        groupName:
            freezed == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        group:
            freezed == group
                ? _value._group
                : group // ignore: cast_nullable_to_non_nullable
                    as List<UserModel>?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as LastMessage?,
        unreadCount:
            null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatItemImpl implements _ChatItem {
  const _$ChatItemImpl({
    required this.id,
    this.activeCallRoom,
    this.groupName,
    this.createdAt,
    this.updatedAt,
    final List<UserModel>? group,
    this.lastMessage,
    this.unreadCount = 0,
  }) : _group = group;

  factory _$ChatItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatItemImplFromJson(json);

  @override
  final String id;
  @override
  final String? activeCallRoom;
  @override
  final String? groupName;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
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
  final LastMessage? lastMessage;
  @override
  @JsonKey()
  final int unreadCount;

  @override
  String toString() {
    return 'ChatItem(id: $id, activeCallRoom: $activeCallRoom, groupName: $groupName, createdAt: $createdAt, updatedAt: $updatedAt, group: $group, lastMessage: $lastMessage, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activeCallRoom, activeCallRoom) ||
                other.activeCallRoom == activeCallRoom) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    activeCallRoom,
    groupName,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_group),
    lastMessage,
    unreadCount,
  );

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatItemImplCopyWith<_$ChatItemImpl> get copyWith =>
      __$$ChatItemImplCopyWithImpl<_$ChatItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatItemImplToJson(this);
  }
}

abstract class _ChatItem implements ChatItem {
  const factory _ChatItem({
    required final String id,
    final String? activeCallRoom,
    final String? groupName,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final List<UserModel>? group,
    final LastMessage? lastMessage,
    final int unreadCount,
  }) = _$ChatItemImpl;

  factory _ChatItem.fromJson(Map<String, dynamic> json) =
      _$ChatItemImpl.fromJson;

  @override
  String get id;
  @override
  String? get activeCallRoom;
  @override
  String? get groupName;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<UserModel>? get group;
  @override
  LastMessage? get lastMessage;
  @override
  int get unreadCount;

  /// Create a copy of ChatItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatItemImplCopyWith<_$ChatItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMessage _$LastMessageFromJson(Map<String, dynamic> json) {
  return _LastMessage.fromJson(json);
}

/// @nodoc
mixin _$LastMessage {
  String? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  bool? get isRead => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  UserModel? get therapist => throw _privateConstructorUsedError;

  /// Serializes this LastMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageCopyWith<LastMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageCopyWith<$Res> {
  factory $LastMessageCopyWith(
    LastMessage value,
    $Res Function(LastMessage) then,
  ) = _$LastMessageCopyWithImpl<$Res, LastMessage>;
  @useResult
  $Res call({
    String? id,
    String? content,
    bool? isRead,
    UserModel? client,
    UserModel? therapist,
  });

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res>? get therapist;
}

/// @nodoc
class _$LastMessageCopyWithImpl<$Res, $Val extends LastMessage>
    implements $LastMessageCopyWith<$Res> {
  _$LastMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            content:
                freezed == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String?,
            isRead:
                freezed == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool?,
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
          )
          as $Val,
    );
  }

  /// Create a copy of LastMessage
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

  /// Create a copy of LastMessage
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
}

/// @nodoc
abstract class _$$LastMessageImplCopyWith<$Res>
    implements $LastMessageCopyWith<$Res> {
  factory _$$LastMessageImplCopyWith(
    _$LastMessageImpl value,
    $Res Function(_$LastMessageImpl) then,
  ) = __$$LastMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? content,
    bool? isRead,
    UserModel? client,
    UserModel? therapist,
  });

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res>? get therapist;
}

/// @nodoc
class __$$LastMessageImplCopyWithImpl<$Res>
    extends _$LastMessageCopyWithImpl<$Res, _$LastMessageImpl>
    implements _$$LastMessageImplCopyWith<$Res> {
  __$$LastMessageImplCopyWithImpl(
    _$LastMessageImpl _value,
    $Res Function(_$LastMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
  }) {
    return _then(
      _$LastMessageImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        content:
            freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String?,
        isRead:
            freezed == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool?,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageImpl implements _LastMessage {
  const _$LastMessageImpl({
    this.id,
    this.content,
    this.isRead,
    this.client,
    this.therapist,
  });

  factory _$LastMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageImplFromJson(json);

  @override
  final String? id;
  @override
  final String? content;
  @override
  final bool? isRead;
  @override
  final UserModel? client;
  @override
  final UserModel? therapist;

  @override
  String toString() {
    return 'LastMessage(id: $id, content: $content, isRead: $isRead, client: $client, therapist: $therapist)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, isRead, client, therapist);

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageImplCopyWith<_$LastMessageImpl> get copyWith =>
      __$$LastMessageImplCopyWithImpl<_$LastMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageImplToJson(this);
  }
}

abstract class _LastMessage implements LastMessage {
  const factory _LastMessage({
    final String? id,
    final String? content,
    final bool? isRead,
    final UserModel? client,
    final UserModel? therapist,
  }) = _$LastMessageImpl;

  factory _LastMessage.fromJson(Map<String, dynamic> json) =
      _$LastMessageImpl.fromJson;

  @override
  String? get id;
  @override
  String? get content;
  @override
  bool? get isRead;
  @override
  UserModel? get client;
  @override
  UserModel? get therapist;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageImplCopyWith<_$LastMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  int? get totalItems => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  int? get currentPage => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
    Pagination value,
    $Res Function(Pagination) then,
  ) = _$PaginationCopyWithImpl<$Res, Pagination>;
  @useResult
  $Res call({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    int? pageSize,
  });
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res, $Val extends Pagination>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = freezed,
    Object? totalPages = freezed,
    Object? currentPage = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalItems:
                freezed == totalItems
                    ? _value.totalItems
                    : totalItems // ignore: cast_nullable_to_non_nullable
                        as int?,
            totalPages:
                freezed == totalPages
                    ? _value.totalPages
                    : totalPages // ignore: cast_nullable_to_non_nullable
                        as int?,
            currentPage:
                freezed == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int?,
            pageSize:
                freezed == pageSize
                    ? _value.pageSize
                    : pageSize // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationImplCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$PaginationImplCopyWith(
    _$PaginationImpl value,
    $Res Function(_$PaginationImpl) then,
  ) = __$$PaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    int? pageSize,
  });
}

/// @nodoc
class __$$PaginationImplCopyWithImpl<$Res>
    extends _$PaginationCopyWithImpl<$Res, _$PaginationImpl>
    implements _$$PaginationImplCopyWith<$Res> {
  __$$PaginationImplCopyWithImpl(
    _$PaginationImpl _value,
    $Res Function(_$PaginationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = freezed,
    Object? totalPages = freezed,
    Object? currentPage = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(
      _$PaginationImpl(
        totalItems:
            freezed == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                    as int?,
        totalPages:
            freezed == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                    as int?,
        currentPage:
            freezed == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int?,
        pageSize:
            freezed == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationImpl implements _Pagination {
  const _$PaginationImpl({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.pageSize,
  });

  factory _$PaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationImplFromJson(json);

  @override
  final int? totalItems;
  @override
  final int? totalPages;
  @override
  final int? currentPage;
  @override
  final int? pageSize;

  @override
  String toString() {
    return 'Pagination(totalItems: $totalItems, totalPages: $totalPages, currentPage: $currentPage, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationImpl &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalItems, totalPages, currentPage, pageSize);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      __$$PaginationImplCopyWithImpl<_$PaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationImplToJson(this);
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination({
    final int? totalItems,
    final int? totalPages,
    final int? currentPage,
    final int? pageSize,
  }) = _$PaginationImpl;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$PaginationImpl.fromJson;

  @override
  int? get totalItems;
  @override
  int? get totalPages;
  @override
  int? get currentPage;
  @override
  int? get pageSize;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JoinCallResponse _$JoinCallResponseFromJson(Map<String, dynamic> json) {
  return _JoinCallResponse.fromJson(json);
}

/// @nodoc
mixin _$JoinCallResponse {
  JoinCallData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this JoinCallResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinCallResponseCopyWith<JoinCallResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinCallResponseCopyWith<$Res> {
  factory $JoinCallResponseCopyWith(
    JoinCallResponse value,
    $Res Function(JoinCallResponse) then,
  ) = _$JoinCallResponseCopyWithImpl<$Res, JoinCallResponse>;
  @useResult
  $Res call({
    JoinCallData? data,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  $JoinCallDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$JoinCallResponseCopyWithImpl<$Res, $Val extends JoinCallResponse>
    implements $JoinCallResponseCopyWith<$Res> {
  _$JoinCallResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as JoinCallData?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            statusCode:
                freezed == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int?,
            method:
                freezed == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String?,
            path:
                freezed == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String?,
            timestamp:
                freezed == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JoinCallDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $JoinCallDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JoinCallResponseImplCopyWith<$Res>
    implements $JoinCallResponseCopyWith<$Res> {
  factory _$$JoinCallResponseImplCopyWith(
    _$JoinCallResponseImpl value,
    $Res Function(_$JoinCallResponseImpl) then,
  ) = __$$JoinCallResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    JoinCallData? data,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  @override
  $JoinCallDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$JoinCallResponseImplCopyWithImpl<$Res>
    extends _$JoinCallResponseCopyWithImpl<$Res, _$JoinCallResponseImpl>
    implements _$$JoinCallResponseImplCopyWith<$Res> {
  __$$JoinCallResponseImplCopyWithImpl(
    _$JoinCallResponseImpl _value,
    $Res Function(_$JoinCallResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$JoinCallResponseImpl(
        data:
            freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as JoinCallData?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
        method:
            freezed == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String?,
        path:
            freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String?,
        timestamp:
            freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinCallResponseImpl implements _JoinCallResponse {
  const _$JoinCallResponseImpl({
    this.data,
    this.message,
    this.statusCode,
    this.method,
    this.path,
    this.timestamp,
  });

  factory _$JoinCallResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinCallResponseImplFromJson(json);

  @override
  final JoinCallData? data;
  @override
  final String? message;
  @override
  final int? statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'JoinCallResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinCallResponseImpl &&
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

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinCallResponseImplCopyWith<_$JoinCallResponseImpl> get copyWith =>
      __$$JoinCallResponseImplCopyWithImpl<_$JoinCallResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinCallResponseImplToJson(this);
  }
}

abstract class _JoinCallResponse implements JoinCallResponse {
  const factory _JoinCallResponse({
    final JoinCallData? data,
    final String? message,
    final int? statusCode,
    final String? method,
    final String? path,
    final DateTime? timestamp,
  }) = _$JoinCallResponseImpl;

  factory _JoinCallResponse.fromJson(Map<String, dynamic> json) =
      _$JoinCallResponseImpl.fromJson;

  @override
  JoinCallData? get data;
  @override
  String? get message;
  @override
  int? get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  DateTime? get timestamp;

  /// Create a copy of JoinCallResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinCallResponseImplCopyWith<_$JoinCallResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JoinCallData _$JoinCallDataFromJson(Map<String, dynamic> json) {
  return _JoinCallData.fromJson(json);
}

/// @nodoc
mixin _$JoinCallData {
  String get token => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;

  /// Serializes this JoinCallData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinCallData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinCallDataCopyWith<JoinCallData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinCallDataCopyWith<$Res> {
  factory $JoinCallDataCopyWith(
    JoinCallData value,
    $Res Function(JoinCallData) then,
  ) = _$JoinCallDataCopyWithImpl<$Res, JoinCallData>;
  @useResult
  $Res call({String token, String room});
}

/// @nodoc
class _$JoinCallDataCopyWithImpl<$Res, $Val extends JoinCallData>
    implements $JoinCallDataCopyWith<$Res> {
  _$JoinCallDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinCallData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? room = null}) {
    return _then(
      _value.copyWith(
            token:
                null == token
                    ? _value.token
                    : token // ignore: cast_nullable_to_non_nullable
                        as String,
            room:
                null == room
                    ? _value.room
                    : room // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JoinCallDataImplCopyWith<$Res>
    implements $JoinCallDataCopyWith<$Res> {
  factory _$$JoinCallDataImplCopyWith(
    _$JoinCallDataImpl value,
    $Res Function(_$JoinCallDataImpl) then,
  ) = __$$JoinCallDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String room});
}

/// @nodoc
class __$$JoinCallDataImplCopyWithImpl<$Res>
    extends _$JoinCallDataCopyWithImpl<$Res, _$JoinCallDataImpl>
    implements _$$JoinCallDataImplCopyWith<$Res> {
  __$$JoinCallDataImplCopyWithImpl(
    _$JoinCallDataImpl _value,
    $Res Function(_$JoinCallDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JoinCallData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null, Object? room = null}) {
    return _then(
      _$JoinCallDataImpl(
        token:
            null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                    as String,
        room:
            null == room
                ? _value.room
                : room // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinCallDataImpl implements _JoinCallData {
  const _$JoinCallDataImpl({required this.token, required this.room});

  factory _$JoinCallDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinCallDataImplFromJson(json);

  @override
  final String token;
  @override
  final String room;

  @override
  String toString() {
    return 'JoinCallData(token: $token, room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinCallDataImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.room, room) || other.room == room));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, room);

  /// Create a copy of JoinCallData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinCallDataImplCopyWith<_$JoinCallDataImpl> get copyWith =>
      __$$JoinCallDataImplCopyWithImpl<_$JoinCallDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinCallDataImplToJson(this);
  }
}

abstract class _JoinCallData implements JoinCallData {
  const factory _JoinCallData({
    required final String token,
    required final String room,
  }) = _$JoinCallDataImpl;

  factory _JoinCallData.fromJson(Map<String, dynamic> json) =
      _$JoinCallDataImpl.fromJson;

  @override
  String get token;
  @override
  String get room;

  /// Create a copy of JoinCallData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinCallDataImplCopyWith<_$JoinCallDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
