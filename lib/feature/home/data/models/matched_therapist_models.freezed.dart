// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matched_therapist_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MatchListResponse _$MatchListResponseFromJson(Map<String, dynamic> json) {
  return _MatchListResponse.fromJson(json);
}

/// @nodoc
mixin _$MatchListResponse {
  List<MatchItem> get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MatchListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchListResponseCopyWith<MatchListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchListResponseCopyWith<$Res> {
  factory $MatchListResponseCopyWith(
    MatchListResponse value,
    $Res Function(MatchListResponse) then,
  ) = _$MatchListResponseCopyWithImpl<$Res, MatchListResponse>;
  @useResult
  $Res call({
    List<MatchItem> data,
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
class _$MatchListResponseCopyWithImpl<$Res, $Val extends MatchListResponse>
    implements $MatchListResponseCopyWith<$Res> {
  _$MatchListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchListResponse
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
                        as List<MatchItem>,
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

  /// Create a copy of MatchListResponse
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
abstract class _$$MatchListResponseImplCopyWith<$Res>
    implements $MatchListResponseCopyWith<$Res> {
  factory _$$MatchListResponseImplCopyWith(
    _$MatchListResponseImpl value,
    $Res Function(_$MatchListResponseImpl) then,
  ) = __$$MatchListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MatchItem> data,
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
class __$$MatchListResponseImplCopyWithImpl<$Res>
    extends _$MatchListResponseCopyWithImpl<$Res, _$MatchListResponseImpl>
    implements _$$MatchListResponseImplCopyWith<$Res> {
  __$$MatchListResponseImplCopyWithImpl(
    _$MatchListResponseImpl _value,
    $Res Function(_$MatchListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchListResponse
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
      _$MatchListResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<MatchItem>,
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
class _$MatchListResponseImpl implements _MatchListResponse {
  const _$MatchListResponseImpl({
    required final List<MatchItem> data,
    this.pagination,
    this.message,
    this.statusCode,
    this.method,
    this.path,
    this.timestamp,
  }) : _data = data;

  factory _$MatchListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchListResponseImplFromJson(json);

  final List<MatchItem> _data;
  @override
  List<MatchItem> get data {
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
    return 'MatchListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchListResponseImpl &&
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

  /// Create a copy of MatchListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchListResponseImplCopyWith<_$MatchListResponseImpl> get copyWith =>
      __$$MatchListResponseImplCopyWithImpl<_$MatchListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchListResponseImplToJson(this);
  }
}

abstract class _MatchListResponse implements MatchListResponse {
  const factory _MatchListResponse({
    required final List<MatchItem> data,
    final Pagination? pagination,
    final String? message,
    final int? statusCode,
    final String? method,
    final String? path,
    final DateTime? timestamp,
  }) = _$MatchListResponseImpl;

  factory _MatchListResponse.fromJson(Map<String, dynamic> json) =
      _$MatchListResponseImpl.fromJson;

  @override
  List<MatchItem> get data;
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

  /// Create a copy of MatchListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchListResponseImplCopyWith<_$MatchListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchItem _$MatchItemFromJson(Map<String, dynamic> json) {
  return _MatchItem.fromJson(json);
}

/// @nodoc
mixin _$MatchItem {
  String get id => throw _privateConstructorUsedError;
  UserModel? get accepted => throw _privateConstructorUsedError;
  dynamic get client => throw _privateConstructorUsedError; // keep flexible
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MatchItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchItemCopyWith<MatchItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchItemCopyWith<$Res> {
  factory $MatchItemCopyWith(MatchItem value, $Res Function(MatchItem) then) =
      _$MatchItemCopyWithImpl<$Res, MatchItem>;
  @useResult
  $Res call({
    String id,
    UserModel? accepted,
    dynamic client,
    DateTime? createdAt,
  });

  $UserModelCopyWith<$Res>? get accepted;
}

/// @nodoc
class _$MatchItemCopyWithImpl<$Res, $Val extends MatchItem>
    implements $MatchItemCopyWith<$Res> {
  _$MatchItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accepted = freezed,
    Object? client = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            accepted:
                freezed == accepted
                    ? _value.accepted
                    : accepted // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as dynamic,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get accepted {
    if (_value.accepted == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.accepted!, (value) {
      return _then(_value.copyWith(accepted: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchItemImplCopyWith<$Res>
    implements $MatchItemCopyWith<$Res> {
  factory _$$MatchItemImplCopyWith(
    _$MatchItemImpl value,
    $Res Function(_$MatchItemImpl) then,
  ) = __$$MatchItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    UserModel? accepted,
    dynamic client,
    DateTime? createdAt,
  });

  @override
  $UserModelCopyWith<$Res>? get accepted;
}

/// @nodoc
class __$$MatchItemImplCopyWithImpl<$Res>
    extends _$MatchItemCopyWithImpl<$Res, _$MatchItemImpl>
    implements _$$MatchItemImplCopyWith<$Res> {
  __$$MatchItemImplCopyWithImpl(
    _$MatchItemImpl _value,
    $Res Function(_$MatchItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accepted = freezed,
    Object? client = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$MatchItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        accepted:
            freezed == accepted
                ? _value.accepted
                : accepted // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchItemImpl implements _MatchItem {
  const _$MatchItemImpl({
    required this.id,
    this.accepted,
    this.client = null,
    this.createdAt,
  });

  factory _$MatchItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchItemImplFromJson(json);

  @override
  final String id;
  @override
  final UserModel? accepted;
  @override
  @JsonKey()
  final dynamic client;
  // keep flexible
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MatchItem(id: $id, accepted: $accepted, client: $client, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted) &&
            const DeepCollectionEquality().equals(other.client, client) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accepted,
    const DeepCollectionEquality().hash(client),
    createdAt,
  );

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchItemImplCopyWith<_$MatchItemImpl> get copyWith =>
      __$$MatchItemImplCopyWithImpl<_$MatchItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchItemImplToJson(this);
  }
}

abstract class _MatchItem implements MatchItem {
  const factory _MatchItem({
    required final String id,
    final UserModel? accepted,
    final dynamic client,
    final DateTime? createdAt,
  }) = _$MatchItemImpl;

  factory _MatchItem.fromJson(Map<String, dynamic> json) =
      _$MatchItemImpl.fromJson;

  @override
  String get id;
  @override
  UserModel? get accepted;
  @override
  dynamic get client; // keep flexible
  @override
  DateTime? get createdAt;

  /// Create a copy of MatchItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchItemImplCopyWith<_$MatchItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
