// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationListResponse _$NotificationListResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationListResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationListResponse {
  List<NotificationItem> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationListResponseCopyWith<NotificationListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationListResponseCopyWith<$Res> {
  factory $NotificationListResponseCopyWith(NotificationListResponse value,
          $Res Function(NotificationListResponse) then) =
      _$NotificationListResponseCopyWithImpl<$Res, NotificationListResponse>;
  @useResult
  $Res call(
      {List<NotificationItem> data,
      Pagination pagination,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$NotificationListResponseCopyWithImpl<$Res,
        $Val extends NotificationListResponse>
    implements $NotificationListResponseCopyWith<$Res> {
  _$NotificationListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NotificationItem>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationListResponseImplCopyWith<$Res>
    implements $NotificationListResponseCopyWith<$Res> {
  factory _$$NotificationListResponseImplCopyWith(
          _$NotificationListResponseImpl value,
          $Res Function(_$NotificationListResponseImpl) then) =
      __$$NotificationListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NotificationItem> data,
      Pagination pagination,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$NotificationListResponseImplCopyWithImpl<$Res>
    extends _$NotificationListResponseCopyWithImpl<$Res,
        _$NotificationListResponseImpl>
    implements _$$NotificationListResponseImplCopyWith<$Res> {
  __$$NotificationListResponseImplCopyWithImpl(
      _$NotificationListResponseImpl _value,
      $Res Function(_$NotificationListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(_$NotificationListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NotificationItem>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationListResponseImpl implements _NotificationListResponse {
  const _$NotificationListResponseImpl(
      {required final List<NotificationItem> data,
      required this.pagination,
      required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp})
      : _data = data;

  factory _$NotificationListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationListResponseImplFromJson(json);

  final List<NotificationItem> _data;
  @override
  List<NotificationItem> get data {
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
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'NotificationListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationListResponseImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      pagination,
      message,
      statusCode,
      method,
      path,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationListResponseImplCopyWith<_$NotificationListResponseImpl>
      get copyWith => __$$NotificationListResponseImplCopyWithImpl<
          _$NotificationListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationListResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationListResponse implements NotificationListResponse {
  const factory _NotificationListResponse(
      {required final List<NotificationItem> data,
      required final Pagination pagination,
      required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$NotificationListResponseImpl;

  factory _NotificationListResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationListResponseImpl.fromJson;

  @override
  List<NotificationItem> get data;
  @override
  Pagination get pagination;
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
  @override
  @JsonKey(ignore: true)
  _$$NotificationListResponseImplCopyWith<_$NotificationListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) {
  return _NotificationItem.fromJson(json);
}

/// @nodoc
mixin _$NotificationItem {
  String get id => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isExpanded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationItemCopyWith<NotificationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationItemCopyWith<$Res> {
  factory $NotificationItemCopyWith(
          NotificationItem value, $Res Function(NotificationItem) then) =
      _$NotificationItemCopyWithImpl<$Res, NotificationItem>;
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      String title,
      String body,
      String? message,
      String code,
      UserModel? client,
      String? profile,
      @JsonKey(ignore: true) bool isRead,
      @JsonKey(ignore: true) bool isExpanded});

  $UserModelCopyWith<$Res>? get client;
}

/// @nodoc
class _$NotificationItemCopyWithImpl<$Res, $Val extends NotificationItem>
    implements $NotificationItemCopyWith<$Res> {
  _$NotificationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? title = null,
    Object? body = null,
    Object? message = freezed,
    Object? code = null,
    Object? client = freezed,
    Object? profile = freezed,
    Object? isRead = null,
    Object? isExpanded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

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
}

/// @nodoc
abstract class _$$NotificationItemImplCopyWith<$Res>
    implements $NotificationItemCopyWith<$Res> {
  factory _$$NotificationItemImplCopyWith(_$NotificationItemImpl value,
          $Res Function(_$NotificationItemImpl) then) =
      __$$NotificationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      String title,
      String body,
      String? message,
      String code,
      UserModel? client,
      String? profile,
      @JsonKey(ignore: true) bool isRead,
      @JsonKey(ignore: true) bool isExpanded});

  @override
  $UserModelCopyWith<$Res>? get client;
}

/// @nodoc
class __$$NotificationItemImplCopyWithImpl<$Res>
    extends _$NotificationItemCopyWithImpl<$Res, _$NotificationItemImpl>
    implements _$$NotificationItemImplCopyWith<$Res> {
  __$$NotificationItemImplCopyWithImpl(_$NotificationItemImpl _value,
      $Res Function(_$NotificationItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? title = null,
    Object? body = null,
    Object? message = freezed,
    Object? code = null,
    Object? client = freezed,
    Object? profile = freezed,
    Object? isRead = null,
    Object? isExpanded = null,
  }) {
    return _then(_$NotificationItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationItemImpl implements _NotificationItem {
  const _$NotificationItemImpl(
      {required this.id,
      required this.updatedAt,
      required this.createdAt,
      required this.title,
      required this.body,
      required this.message,
      required this.code,
      this.client,
      this.profile,
      @JsonKey(ignore: true) this.isRead = false,
      @JsonKey(ignore: true) this.isExpanded = false});

  factory _$NotificationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationItemImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime updatedAt;
  @override
  final DateTime createdAt;
  @override
  final String title;
  @override
  final String body;
  @override
  final String? message;
  @override
  final String code;
  @override
  final UserModel? client;
  @override
  final String? profile;
  @override
  @JsonKey(ignore: true)
  final bool isRead;
  @override
  @JsonKey(ignore: true)
  final bool isExpanded;

  @override
  String toString() {
    return 'NotificationItem(id: $id, updatedAt: $updatedAt, createdAt: $createdAt, title: $title, body: $body, message: $message, code: $code, client: $client, profile: $profile, isRead: $isRead, isExpanded: $isExpanded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, updatedAt, createdAt, title,
      body, message, code, client, profile, isRead, isExpanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      __$$NotificationItemImplCopyWithImpl<_$NotificationItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationItemImplToJson(
      this,
    );
  }
}

abstract class _NotificationItem implements NotificationItem {
  const factory _NotificationItem(
      {required final String id,
      required final DateTime updatedAt,
      required final DateTime createdAt,
      required final String title,
      required final String body,
      required final String? message,
      required final String code,
      final UserModel? client,
      final String? profile,
      @JsonKey(ignore: true) final bool isRead,
      @JsonKey(ignore: true) final bool isExpanded}) = _$NotificationItemImpl;

  factory _NotificationItem.fromJson(Map<String, dynamic> json) =
      _$NotificationItemImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get updatedAt;
  @override
  DateTime get createdAt;
  @override
  String get title;
  @override
  String get body;
  @override
  String? get message;
  @override
  String get code;
  @override
  UserModel? get client;
  @override
  String? get profile;
  @override
  @JsonKey(ignore: true)
  bool get isRead;
  @override
  @JsonKey(ignore: true)
  bool get isExpanded;
  @override
  @JsonKey(ignore: true)
  _$$NotificationItemImplCopyWith<_$NotificationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
