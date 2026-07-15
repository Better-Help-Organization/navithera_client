// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_session_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionListResponse _$SessionListResponseFromJson(Map<String, dynamic> json) {
  return _SessionListResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionListResponse {
  List<SessionItem> get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionListResponseCopyWith<SessionListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionListResponseCopyWith<$Res> {
  factory $SessionListResponseCopyWith(
          SessionListResponse value, $Res Function(SessionListResponse) then) =
      _$SessionListResponseCopyWithImpl<$Res, SessionListResponse>;
  @useResult
  $Res call(
      {List<SessionItem> data,
      Pagination? pagination,
      String? message,
      int? statusCode,
      String? method,
      String? path,
      DateTime? timestamp});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$SessionListResponseCopyWithImpl<$Res, $Val extends SessionListResponse>
    implements $SessionListResponseCopyWith<$Res> {
  _$SessionListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SessionItem>,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

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
abstract class _$$SessionListResponseImplCopyWith<$Res>
    implements $SessionListResponseCopyWith<$Res> {
  factory _$$SessionListResponseImplCopyWith(_$SessionListResponseImpl value,
          $Res Function(_$SessionListResponseImpl) then) =
      __$$SessionListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SessionItem> data,
      Pagination? pagination,
      String? message,
      int? statusCode,
      String? method,
      String? path,
      DateTime? timestamp});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$SessionListResponseImplCopyWithImpl<$Res>
    extends _$SessionListResponseCopyWithImpl<$Res, _$SessionListResponseImpl>
    implements _$$SessionListResponseImplCopyWith<$Res> {
  __$$SessionListResponseImplCopyWithImpl(_$SessionListResponseImpl _value,
      $Res Function(_$SessionListResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$SessionListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SessionItem>,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionListResponseImpl implements _SessionListResponse {
  const _$SessionListResponseImpl(
      {required final List<SessionItem> data,
      this.pagination,
      this.message,
      this.statusCode,
      this.method,
      this.path,
      this.timestamp})
      : _data = data;

  factory _$SessionListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionListResponseImplFromJson(json);

  final List<SessionItem> _data;
  @override
  List<SessionItem> get data {
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
    return 'SessionListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionListResponseImpl &&
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
  _$$SessionListResponseImplCopyWith<_$SessionListResponseImpl> get copyWith =>
      __$$SessionListResponseImplCopyWithImpl<_$SessionListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionListResponseImplToJson(
      this,
    );
  }
}

abstract class _SessionListResponse implements SessionListResponse {
  const factory _SessionListResponse(
      {required final List<SessionItem> data,
      final Pagination? pagination,
      final String? message,
      final int? statusCode,
      final String? method,
      final String? path,
      final DateTime? timestamp}) = _$SessionListResponseImpl;

  factory _SessionListResponse.fromJson(Map<String, dynamic> json) =
      _$SessionListResponseImpl.fromJson;

  @override
  List<SessionItem> get data;
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
  @override
  @JsonKey(ignore: true)
  _$$SessionListResponseImplCopyWith<_$SessionListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionItem _$SessionItemFromJson(Map<String, dynamic> json) {
  return _SessionItem.fromJson(json);
}

/// @nodoc
mixin _$SessionItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get schedule => throw _privateConstructorUsedError;
  String? get approvalStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
  bool? get hasTherapistAttended => throw _privateConstructorUsedError;
  @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
  bool? get hasClientAttended => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  UserModel? get client =>
      throw _privateConstructorUsedError; // Add therapist field
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  UserModel? get therapist =>
      throw _privateConstructorUsedError; // Add any other therapist-related fields you need
  List<dynamic>? get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionItemCopyWith<SessionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionItemCopyWith<$Res> {
  factory $SessionItemCopyWith(
          SessionItem value, $Res Function(SessionItem) then) =
      _$SessionItemCopyWithImpl<$Res, SessionItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      DateTime schedule,
      String? approvalStatus,
      @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
      bool? hasTherapistAttended,
      @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
      bool? hasClientAttended,
      int? duration,
      String? type,
      String? note,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson) UserModel? client,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
      UserModel? therapist,
      List<dynamic>? group});

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res>? get therapist;
}

/// @nodoc
class _$SessionItemCopyWithImpl<$Res, $Val extends SessionItem>
    implements $SessionItemCopyWith<$Res> {
  _$SessionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? schedule = null,
    Object? approvalStatus = freezed,
    Object? hasTherapistAttended = freezed,
    Object? hasClientAttended = freezed,
    Object? duration = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? group = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as DateTime,
      approvalStatus: freezed == approvalStatus
          ? _value.approvalStatus
          : approvalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      hasTherapistAttended: freezed == hasTherapistAttended
          ? _value.hasTherapistAttended
          : hasTherapistAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasClientAttended: freezed == hasClientAttended
          ? _value.hasClientAttended
          : hasClientAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      therapist: freezed == therapist
          ? _value.therapist
          : therapist // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
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
abstract class _$$SessionItemImplCopyWith<$Res>
    implements $SessionItemCopyWith<$Res> {
  factory _$$SessionItemImplCopyWith(
          _$SessionItemImpl value, $Res Function(_$SessionItemImpl) then) =
      __$$SessionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      DateTime schedule,
      String? approvalStatus,
      @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
      bool? hasTherapistAttended,
      @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
      bool? hasClientAttended,
      int? duration,
      String? type,
      String? note,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson) UserModel? client,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
      UserModel? therapist,
      List<dynamic>? group});

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res>? get therapist;
}

/// @nodoc
class __$$SessionItemImplCopyWithImpl<$Res>
    extends _$SessionItemCopyWithImpl<$Res, _$SessionItemImpl>
    implements _$$SessionItemImplCopyWith<$Res> {
  __$$SessionItemImplCopyWithImpl(
      _$SessionItemImpl _value, $Res Function(_$SessionItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? schedule = null,
    Object? approvalStatus = freezed,
    Object? hasTherapistAttended = freezed,
    Object? hasClientAttended = freezed,
    Object? duration = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? group = freezed,
  }) {
    return _then(_$SessionItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as DateTime,
      approvalStatus: freezed == approvalStatus
          ? _value.approvalStatus
          : approvalStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      hasTherapistAttended: freezed == hasTherapistAttended
          ? _value.hasTherapistAttended
          : hasTherapistAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasClientAttended: freezed == hasClientAttended
          ? _value.hasClientAttended
          : hasClientAttended // ignore: cast_nullable_to_non_nullable
              as bool?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      therapist: freezed == therapist
          ? _value.therapist
          : therapist // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      group: freezed == group
          ? _value._group
          : group // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionItemImpl implements _SessionItem {
  const _$SessionItemImpl(
      {required this.id,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      required this.schedule,
      this.approvalStatus,
      @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
      this.hasTherapistAttended,
      @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
      this.hasClientAttended,
      this.duration,
      this.type,
      this.note,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson) this.client,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson) this.therapist,
      final List<dynamic>? group})
      : _group = group;

  factory _$SessionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime schedule;
  @override
  final String? approvalStatus;
  @override
  @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
  final bool? hasTherapistAttended;
  @override
  @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
  final bool? hasClientAttended;
  @override
  final int? duration;
  @override
  final String? type;
  @override
  final String? note;
  @override
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  final UserModel? client;
// Add therapist field
  @override
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  final UserModel? therapist;
// Add any other therapist-related fields you need
  final List<dynamic>? _group;
// Add any other therapist-related fields you need
  @override
  List<dynamic>? get group {
    final value = _group;
    if (value == null) return null;
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SessionItem(id: $id, schedule: $schedule, approvalStatus: $approvalStatus, hasTherapistAttended: $hasTherapistAttended, hasClientAttended: $hasClientAttended, duration: $duration, type: $type, note: $note, client: $client, therapist: $therapist, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.approvalStatus, approvalStatus) ||
                other.approvalStatus == approvalStatus) &&
            (identical(other.hasTherapistAttended, hasTherapistAttended) ||
                other.hasTherapistAttended == hasTherapistAttended) &&
            (identical(other.hasClientAttended, hasClientAttended) ||
                other.hasClientAttended == hasClientAttended) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            const DeepCollectionEquality().equals(other._group, _group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      schedule,
      approvalStatus,
      hasTherapistAttended,
      hasClientAttended,
      duration,
      type,
      note,
      client,
      therapist,
      const DeepCollectionEquality().hash(_group));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionItemImplCopyWith<_$SessionItemImpl> get copyWith =>
      __$$SessionItemImplCopyWithImpl<_$SessionItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionItemImplToJson(
      this,
    );
  }
}

abstract class _SessionItem implements SessionItem {
  const factory _SessionItem(
      {required final String id,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      required final DateTime schedule,
      final String? approvalStatus,
      @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
      final bool? hasTherapistAttended,
      @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
      final bool? hasClientAttended,
      final int? duration,
      final String? type,
      final String? note,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
      final UserModel? client,
      @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
      final UserModel? therapist,
      final List<dynamic>? group}) = _$SessionItemImpl;

  factory _SessionItem.fromJson(Map<String, dynamic> json) =
      _$SessionItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime get schedule;
  @override
  String? get approvalStatus;
  @override
  @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
  bool? get hasTherapistAttended;
  @override
  @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
  bool? get hasClientAttended;
  @override
  int? get duration;
  @override
  String? get type;
  @override
  String? get note;
  @override
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  UserModel? get client;
  @override // Add therapist field
  @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
  UserModel? get therapist;
  @override // Add any other therapist-related fields you need
  List<dynamic>? get group;
  @override
  @JsonKey(ignore: true)
  _$$SessionItemImplCopyWith<_$SessionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
