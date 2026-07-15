// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiaryListResponse _$DiaryListResponseFromJson(Map<String, dynamic> json) {
  return _DiaryListResponse.fromJson(json);
}

/// @nodoc
mixin _$DiaryListResponse {
  List<DiaryEntry> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryListResponseCopyWith<DiaryListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryListResponseCopyWith<$Res> {
  factory $DiaryListResponseCopyWith(
          DiaryListResponse value, $Res Function(DiaryListResponse) then) =
      _$DiaryListResponseCopyWithImpl<$Res, DiaryListResponse>;
  @useResult
  $Res call(
      {List<DiaryEntry> data,
      Pagination pagination,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$DiaryListResponseCopyWithImpl<$Res, $Val extends DiaryListResponse>
    implements $DiaryListResponseCopyWith<$Res> {
  _$DiaryListResponseCopyWithImpl(this._value, this._then);

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
              as List<DiaryEntry>,
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
abstract class _$$DiaryListResponseImplCopyWith<$Res>
    implements $DiaryListResponseCopyWith<$Res> {
  factory _$$DiaryListResponseImplCopyWith(_$DiaryListResponseImpl value,
          $Res Function(_$DiaryListResponseImpl) then) =
      __$$DiaryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DiaryEntry> data,
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
class __$$DiaryListResponseImplCopyWithImpl<$Res>
    extends _$DiaryListResponseCopyWithImpl<$Res, _$DiaryListResponseImpl>
    implements _$$DiaryListResponseImplCopyWith<$Res> {
  __$$DiaryListResponseImplCopyWithImpl(_$DiaryListResponseImpl _value,
      $Res Function(_$DiaryListResponseImpl) _then)
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
    return _then(_$DiaryListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DiaryEntry>,
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
class _$DiaryListResponseImpl implements _DiaryListResponse {
  const _$DiaryListResponseImpl(
      {required final List<DiaryEntry> data,
      required this.pagination,
      required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp})
      : _data = data;

  factory _$DiaryListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryListResponseImplFromJson(json);

  final List<DiaryEntry> _data;
  @override
  List<DiaryEntry> get data {
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
    return 'DiaryListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryListResponseImpl &&
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
  _$$DiaryListResponseImplCopyWith<_$DiaryListResponseImpl> get copyWith =>
      __$$DiaryListResponseImplCopyWithImpl<_$DiaryListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryListResponseImplToJson(
      this,
    );
  }
}

abstract class _DiaryListResponse implements DiaryListResponse {
  const factory _DiaryListResponse(
      {required final List<DiaryEntry> data,
      required final Pagination pagination,
      required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$DiaryListResponseImpl;

  factory _DiaryListResponse.fromJson(Map<String, dynamic> json) =
      _$DiaryListResponseImpl.fromJson;

  @override
  List<DiaryEntry> get data;
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
  _$$DiaryListResponseImplCopyWith<_$DiaryListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return _DiaryEntry.fromJson(json);
}

/// @nodoc
mixin _$DiaryEntry {
  String get id => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryEntryCopyWith<DiaryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryEntryCopyWith<$Res> {
  factory $DiaryEntryCopyWith(
          DiaryEntry value, $Res Function(DiaryEntry) then) =
      _$DiaryEntryCopyWithImpl<$Res, DiaryEntry>;
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      String title,
      String content,
      DateTime? deletedAt});
}

/// @nodoc
class _$DiaryEntryCopyWithImpl<$Res, $Val extends DiaryEntry>
    implements $DiaryEntryCopyWith<$Res> {
  _$DiaryEntryCopyWithImpl(this._value, this._then);

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
    Object? content = null,
    Object? deletedAt = freezed,
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryEntryImplCopyWith<$Res>
    implements $DiaryEntryCopyWith<$Res> {
  factory _$$DiaryEntryImplCopyWith(
          _$DiaryEntryImpl value, $Res Function(_$DiaryEntryImpl) then) =
      __$$DiaryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      String title,
      String content,
      DateTime? deletedAt});
}

/// @nodoc
class __$$DiaryEntryImplCopyWithImpl<$Res>
    extends _$DiaryEntryCopyWithImpl<$Res, _$DiaryEntryImpl>
    implements _$$DiaryEntryImplCopyWith<$Res> {
  __$$DiaryEntryImplCopyWithImpl(
      _$DiaryEntryImpl _value, $Res Function(_$DiaryEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? title = null,
    Object? content = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$DiaryEntryImpl(
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
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiaryEntryImpl implements _DiaryEntry {
  const _$DiaryEntryImpl(
      {required this.id,
      required this.updatedAt,
      required this.createdAt,
      required this.title,
      required this.content,
      this.deletedAt});

  factory _$DiaryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryEntryImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime updatedAt;
  @override
  final DateTime createdAt;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'DiaryEntry(id: $id, updatedAt: $updatedAt, createdAt: $createdAt, title: $title, content: $content, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, updatedAt, createdAt, title, content, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryEntryImplCopyWith<_$DiaryEntryImpl> get copyWith =>
      __$$DiaryEntryImplCopyWithImpl<_$DiaryEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryEntryImplToJson(
      this,
    );
  }
}

abstract class _DiaryEntry implements DiaryEntry {
  const factory _DiaryEntry(
      {required final String id,
      required final DateTime updatedAt,
      required final DateTime createdAt,
      required final String title,
      required final String content,
      final DateTime? deletedAt}) = _$DiaryEntryImpl;

  factory _DiaryEntry.fromJson(Map<String, dynamic> json) =
      _$DiaryEntryImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get updatedAt;
  @override
  DateTime get createdAt;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$DiaryEntryImplCopyWith<_$DiaryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiaryCreateResponse _$DiaryCreateResponseFromJson(Map<String, dynamic> json) {
  return _DiaryCreateResponse.fromJson(json);
}

/// @nodoc
mixin _$DiaryCreateResponse {
  DiaryEntry get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryCreateResponseCopyWith<DiaryCreateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryCreateResponseCopyWith<$Res> {
  factory $DiaryCreateResponseCopyWith(
          DiaryCreateResponse value, $Res Function(DiaryCreateResponse) then) =
      _$DiaryCreateResponseCopyWithImpl<$Res, DiaryCreateResponse>;
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class _$DiaryCreateResponseCopyWithImpl<$Res, $Val extends DiaryCreateResponse>
    implements $DiaryCreateResponseCopyWith<$Res> {
  _$DiaryCreateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
  $DiaryEntryCopyWith<$Res> get data {
    return $DiaryEntryCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiaryCreateResponseImplCopyWith<$Res>
    implements $DiaryCreateResponseCopyWith<$Res> {
  factory _$$DiaryCreateResponseImplCopyWith(_$DiaryCreateResponseImpl value,
          $Res Function(_$DiaryCreateResponseImpl) then) =
      __$$DiaryCreateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  @override
  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class __$$DiaryCreateResponseImplCopyWithImpl<$Res>
    extends _$DiaryCreateResponseCopyWithImpl<$Res, _$DiaryCreateResponseImpl>
    implements _$$DiaryCreateResponseImplCopyWith<$Res> {
  __$$DiaryCreateResponseImplCopyWithImpl(_$DiaryCreateResponseImpl _value,
      $Res Function(_$DiaryCreateResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$DiaryCreateResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
class _$DiaryCreateResponseImpl implements _DiaryCreateResponse {
  const _$DiaryCreateResponseImpl(
      {required this.data,
      required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp});

  factory _$DiaryCreateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryCreateResponseImplFromJson(json);

  @override
  final DiaryEntry data;
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
    return 'DiaryCreateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryCreateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
      runtimeType, data, message, statusCode, method, path, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryCreateResponseImplCopyWith<_$DiaryCreateResponseImpl> get copyWith =>
      __$$DiaryCreateResponseImplCopyWithImpl<_$DiaryCreateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryCreateResponseImplToJson(
      this,
    );
  }
}

abstract class _DiaryCreateResponse implements DiaryCreateResponse {
  const factory _DiaryCreateResponse(
      {required final DiaryEntry data,
      required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$DiaryCreateResponseImpl;

  factory _DiaryCreateResponse.fromJson(Map<String, dynamic> json) =
      _$DiaryCreateResponseImpl.fromJson;

  @override
  DiaryEntry get data;
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
  _$$DiaryCreateResponseImplCopyWith<_$DiaryCreateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiaryUpdateResponse _$DiaryUpdateResponseFromJson(Map<String, dynamic> json) {
  return _DiaryUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$DiaryUpdateResponse {
  DiaryEntry get data =>
      throw _privateConstructorUsedError; // Changed from String to DiaryEntry
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryUpdateResponseCopyWith<DiaryUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryUpdateResponseCopyWith<$Res> {
  factory $DiaryUpdateResponseCopyWith(
          DiaryUpdateResponse value, $Res Function(DiaryUpdateResponse) then) =
      _$DiaryUpdateResponseCopyWithImpl<$Res, DiaryUpdateResponse>;
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class _$DiaryUpdateResponseCopyWithImpl<$Res, $Val extends DiaryUpdateResponse>
    implements $DiaryUpdateResponseCopyWith<$Res> {
  _$DiaryUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
  $DiaryEntryCopyWith<$Res> get data {
    return $DiaryEntryCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiaryUpdateResponseImplCopyWith<$Res>
    implements $DiaryUpdateResponseCopyWith<$Res> {
  factory _$$DiaryUpdateResponseImplCopyWith(_$DiaryUpdateResponseImpl value,
          $Res Function(_$DiaryUpdateResponseImpl) then) =
      __$$DiaryUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  @override
  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class __$$DiaryUpdateResponseImplCopyWithImpl<$Res>
    extends _$DiaryUpdateResponseCopyWithImpl<$Res, _$DiaryUpdateResponseImpl>
    implements _$$DiaryUpdateResponseImplCopyWith<$Res> {
  __$$DiaryUpdateResponseImplCopyWithImpl(_$DiaryUpdateResponseImpl _value,
      $Res Function(_$DiaryUpdateResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$DiaryUpdateResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
class _$DiaryUpdateResponseImpl implements _DiaryUpdateResponse {
  const _$DiaryUpdateResponseImpl(
      {required this.data,
      required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp});

  factory _$DiaryUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryUpdateResponseImplFromJson(json);

  @override
  final DiaryEntry data;
// Changed from String to DiaryEntry
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
    return 'DiaryUpdateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryUpdateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
      runtimeType, data, message, statusCode, method, path, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryUpdateResponseImplCopyWith<_$DiaryUpdateResponseImpl> get copyWith =>
      __$$DiaryUpdateResponseImplCopyWithImpl<_$DiaryUpdateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryUpdateResponseImplToJson(
      this,
    );
  }
}

abstract class _DiaryUpdateResponse implements DiaryUpdateResponse {
  const factory _DiaryUpdateResponse(
      {required final DiaryEntry data,
      required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$DiaryUpdateResponseImpl;

  factory _DiaryUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$DiaryUpdateResponseImpl.fromJson;

  @override
  DiaryEntry get data;
  @override // Changed from String to DiaryEntry
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
  _$$DiaryUpdateResponseImplCopyWith<_$DiaryUpdateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiaryEditResponse _$DiaryEditResponseFromJson(Map<String, dynamic> json) {
  return _DiaryEditResponse.fromJson(json);
}

/// @nodoc
mixin _$DiaryEditResponse {
  DiaryEntry get data =>
      throw _privateConstructorUsedError; // Changed from String to DiaryEntry
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryEditResponseCopyWith<DiaryEditResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryEditResponseCopyWith<$Res> {
  factory $DiaryEditResponseCopyWith(
          DiaryEditResponse value, $Res Function(DiaryEditResponse) then) =
      _$DiaryEditResponseCopyWithImpl<$Res, DiaryEditResponse>;
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class _$DiaryEditResponseCopyWithImpl<$Res, $Val extends DiaryEditResponse>
    implements $DiaryEditResponseCopyWith<$Res> {
  _$DiaryEditResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
  $DiaryEntryCopyWith<$Res> get data {
    return $DiaryEntryCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiaryEditResponseImplCopyWith<$Res>
    implements $DiaryEditResponseCopyWith<$Res> {
  factory _$$DiaryEditResponseImplCopyWith(_$DiaryEditResponseImpl value,
          $Res Function(_$DiaryEditResponseImpl) then) =
      __$$DiaryEditResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DiaryEntry data,
      String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});

  @override
  $DiaryEntryCopyWith<$Res> get data;
}

/// @nodoc
class __$$DiaryEditResponseImplCopyWithImpl<$Res>
    extends _$DiaryEditResponseCopyWithImpl<$Res, _$DiaryEditResponseImpl>
    implements _$$DiaryEditResponseImplCopyWith<$Res> {
  __$$DiaryEditResponseImplCopyWithImpl(_$DiaryEditResponseImpl _value,
      $Res Function(_$DiaryEditResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$DiaryEditResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DiaryEntry,
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
class _$DiaryEditResponseImpl implements _DiaryEditResponse {
  const _$DiaryEditResponseImpl(
      {required this.data,
      required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp});

  factory _$DiaryEditResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryEditResponseImplFromJson(json);

  @override
  final DiaryEntry data;
// Changed from String to DiaryEntry
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
    return 'DiaryEditResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryEditResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
      runtimeType, data, message, statusCode, method, path, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryEditResponseImplCopyWith<_$DiaryEditResponseImpl> get copyWith =>
      __$$DiaryEditResponseImplCopyWithImpl<_$DiaryEditResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryEditResponseImplToJson(
      this,
    );
  }
}

abstract class _DiaryEditResponse implements DiaryEditResponse {
  const factory _DiaryEditResponse(
      {required final DiaryEntry data,
      required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$DiaryEditResponseImpl;

  factory _DiaryEditResponse.fromJson(Map<String, dynamic> json) =
      _$DiaryEditResponseImpl.fromJson;

  @override
  DiaryEntry get data;
  @override // Changed from String to DiaryEntry
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
  _$$DiaryEditResponseImplCopyWith<_$DiaryEditResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiaryDeleteResponse _$DiaryDeleteResponseFromJson(Map<String, dynamic> json) {
  return _DiaryDeleteResponse.fromJson(json);
}

/// @nodoc
mixin _$DiaryDeleteResponse {
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryDeleteResponseCopyWith<DiaryDeleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryDeleteResponseCopyWith<$Res> {
  factory $DiaryDeleteResponseCopyWith(
          DiaryDeleteResponse value, $Res Function(DiaryDeleteResponse) then) =
      _$DiaryDeleteResponseCopyWithImpl<$Res, DiaryDeleteResponse>;
  @useResult
  $Res call(
      {String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});
}

/// @nodoc
class _$DiaryDeleteResponseCopyWithImpl<$Res, $Val extends DiaryDeleteResponse>
    implements $DiaryDeleteResponseCopyWith<$Res> {
  _$DiaryDeleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
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
}

/// @nodoc
abstract class _$$DiaryDeleteResponseImplCopyWith<$Res>
    implements $DiaryDeleteResponseCopyWith<$Res> {
  factory _$$DiaryDeleteResponseImplCopyWith(_$DiaryDeleteResponseImpl value,
          $Res Function(_$DiaryDeleteResponseImpl) then) =
      __$$DiaryDeleteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      int statusCode,
      String method,
      String path,
      DateTime timestamp});
}

/// @nodoc
class __$$DiaryDeleteResponseImplCopyWithImpl<$Res>
    extends _$DiaryDeleteResponseCopyWithImpl<$Res, _$DiaryDeleteResponseImpl>
    implements _$$DiaryDeleteResponseImplCopyWith<$Res> {
  __$$DiaryDeleteResponseImplCopyWithImpl(_$DiaryDeleteResponseImpl _value,
      $Res Function(_$DiaryDeleteResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(_$DiaryDeleteResponseImpl(
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
class _$DiaryDeleteResponseImpl implements _DiaryDeleteResponse {
  const _$DiaryDeleteResponseImpl(
      {required this.message,
      required this.statusCode,
      required this.method,
      required this.path,
      required this.timestamp});

  factory _$DiaryDeleteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryDeleteResponseImplFromJson(json);

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
    return 'DiaryDeleteResponse(message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryDeleteResponseImpl &&
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
  int get hashCode =>
      Object.hash(runtimeType, message, statusCode, method, path, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryDeleteResponseImplCopyWith<_$DiaryDeleteResponseImpl> get copyWith =>
      __$$DiaryDeleteResponseImplCopyWithImpl<_$DiaryDeleteResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryDeleteResponseImplToJson(
      this,
    );
  }
}

abstract class _DiaryDeleteResponse implements DiaryDeleteResponse {
  const factory _DiaryDeleteResponse(
      {required final String message,
      required final int statusCode,
      required final String method,
      required final String path,
      required final DateTime timestamp}) = _$DiaryDeleteResponseImpl;

  factory _DiaryDeleteResponse.fromJson(Map<String, dynamic> json) =
      _$DiaryDeleteResponseImpl.fromJson;

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
  _$$DiaryDeleteResponseImplCopyWith<_$DiaryDeleteResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
