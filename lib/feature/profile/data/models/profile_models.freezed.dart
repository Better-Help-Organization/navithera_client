// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePersonalDetailsRequest _$UpdatePersonalDetailsRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdatePersonalDetailsRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePersonalDetailsRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePersonalDetailsRequestCopyWith<UpdatePersonalDetailsRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePersonalDetailsRequestCopyWith<$Res> {
  factory $UpdatePersonalDetailsRequestCopyWith(
          UpdatePersonalDetailsRequest value,
          $Res Function(UpdatePersonalDetailsRequest) then) =
      _$UpdatePersonalDetailsRequestCopyWithImpl<$Res,
          UpdatePersonalDetailsRequest>;
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String? username,
      String? emergencyContact,
      String? gender});
}

/// @nodoc
class _$UpdatePersonalDetailsRequestCopyWithImpl<$Res,
        $Val extends UpdatePersonalDetailsRequest>
    implements $UpdatePersonalDetailsRequestCopyWith<$Res> {
  _$UpdatePersonalDetailsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? gender = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePersonalDetailsRequestImplCopyWith<$Res>
    implements $UpdatePersonalDetailsRequestCopyWith<$Res> {
  factory _$$UpdatePersonalDetailsRequestImplCopyWith(
          _$UpdatePersonalDetailsRequestImpl value,
          $Res Function(_$UpdatePersonalDetailsRequestImpl) then) =
      __$$UpdatePersonalDetailsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String? username,
      String? emergencyContact,
      String? gender});
}

/// @nodoc
class __$$UpdatePersonalDetailsRequestImplCopyWithImpl<$Res>
    extends _$UpdatePersonalDetailsRequestCopyWithImpl<$Res,
        _$UpdatePersonalDetailsRequestImpl>
    implements _$$UpdatePersonalDetailsRequestImplCopyWith<$Res> {
  __$$UpdatePersonalDetailsRequestImplCopyWithImpl(
      _$UpdatePersonalDetailsRequestImpl _value,
      $Res Function(_$UpdatePersonalDetailsRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? gender = freezed,
  }) {
    return _then(_$UpdatePersonalDetailsRequestImpl(
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePersonalDetailsRequestImpl
    implements _UpdatePersonalDetailsRequest {
  const _$UpdatePersonalDetailsRequestImpl(
      {required this.firstName,
      required this.lastName,
      this.username,
      this.emergencyContact,
      this.gender});

  factory _$UpdatePersonalDetailsRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdatePersonalDetailsRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? username;
  @override
  final String? emergencyContact;
  @override
  final String? gender;

  @override
  String toString() {
    return 'UpdatePersonalDetailsRequest(firstName: $firstName, lastName: $lastName, username: $username, emergencyContact: $emergencyContact, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePersonalDetailsRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, firstName, lastName, username, emergencyContact, gender);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePersonalDetailsRequestImplCopyWith<
          _$UpdatePersonalDetailsRequestImpl>
      get copyWith => __$$UpdatePersonalDetailsRequestImplCopyWithImpl<
          _$UpdatePersonalDetailsRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePersonalDetailsRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePersonalDetailsRequest
    implements UpdatePersonalDetailsRequest {
  const factory _UpdatePersonalDetailsRequest(
      {required final String firstName,
      required final String lastName,
      final String? username,
      final String? emergencyContact,
      final String? gender}) = _$UpdatePersonalDetailsRequestImpl;

  factory _UpdatePersonalDetailsRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePersonalDetailsRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get username;
  @override
  String? get emergencyContact;
  @override
  String? get gender;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePersonalDetailsRequestImplCopyWith<
          _$UpdatePersonalDetailsRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdatePersonalDetailsResponse _$UpdatePersonalDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return _UpdatePersonalDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdatePersonalDetailsResponse {
  UpdatePersonalDetailsData get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePersonalDetailsResponseCopyWith<UpdatePersonalDetailsResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePersonalDetailsResponseCopyWith<$Res> {
  factory $UpdatePersonalDetailsResponseCopyWith(
          UpdatePersonalDetailsResponse value,
          $Res Function(UpdatePersonalDetailsResponse) then) =
      _$UpdatePersonalDetailsResponseCopyWithImpl<$Res,
          UpdatePersonalDetailsResponse>;
  @useResult
  $Res call(
      {UpdatePersonalDetailsData data,
      String? message,
      int? statusCode,
      String? method,
      String? path,
      String? timestamp});

  $UpdatePersonalDetailsDataCopyWith<$Res> get data;
}

/// @nodoc
class _$UpdatePersonalDetailsResponseCopyWithImpl<$Res,
        $Val extends UpdatePersonalDetailsResponse>
    implements $UpdatePersonalDetailsResponseCopyWith<$Res> {
  _$UpdatePersonalDetailsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
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
              as UpdatePersonalDetailsData,
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
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdatePersonalDetailsDataCopyWith<$Res> get data {
    return $UpdatePersonalDetailsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdatePersonalDetailsResponseImplCopyWith<$Res>
    implements $UpdatePersonalDetailsResponseCopyWith<$Res> {
  factory _$$UpdatePersonalDetailsResponseImplCopyWith(
          _$UpdatePersonalDetailsResponseImpl value,
          $Res Function(_$UpdatePersonalDetailsResponseImpl) then) =
      __$$UpdatePersonalDetailsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UpdatePersonalDetailsData data,
      String? message,
      int? statusCode,
      String? method,
      String? path,
      String? timestamp});

  @override
  $UpdatePersonalDetailsDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$UpdatePersonalDetailsResponseImplCopyWithImpl<$Res>
    extends _$UpdatePersonalDetailsResponseCopyWithImpl<$Res,
        _$UpdatePersonalDetailsResponseImpl>
    implements _$$UpdatePersonalDetailsResponseImplCopyWith<$Res> {
  __$$UpdatePersonalDetailsResponseImplCopyWithImpl(
      _$UpdatePersonalDetailsResponseImpl _value,
      $Res Function(_$UpdatePersonalDetailsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$UpdatePersonalDetailsResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UpdatePersonalDetailsData,
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
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePersonalDetailsResponseImpl
    implements _UpdatePersonalDetailsResponse {
  const _$UpdatePersonalDetailsResponseImpl(
      {required this.data,
      this.message,
      this.statusCode,
      this.method,
      this.path,
      this.timestamp});

  factory _$UpdatePersonalDetailsResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UpdatePersonalDetailsResponseImplFromJson(json);

  @override
  final UpdatePersonalDetailsData data;
  @override
  final String? message;
  @override
  final int? statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'UpdatePersonalDetailsResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePersonalDetailsResponseImpl &&
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
  _$$UpdatePersonalDetailsResponseImplCopyWith<
          _$UpdatePersonalDetailsResponseImpl>
      get copyWith => __$$UpdatePersonalDetailsResponseImplCopyWithImpl<
          _$UpdatePersonalDetailsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePersonalDetailsResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdatePersonalDetailsResponse
    implements UpdatePersonalDetailsResponse {
  const factory _UpdatePersonalDetailsResponse(
      {required final UpdatePersonalDetailsData data,
      final String? message,
      final int? statusCode,
      final String? method,
      final String? path,
      final String? timestamp}) = _$UpdatePersonalDetailsResponseImpl;

  factory _UpdatePersonalDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$UpdatePersonalDetailsResponseImpl.fromJson;

  @override
  UpdatePersonalDetailsData get data;
  @override
  String? get message;
  @override
  int? get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePersonalDetailsResponseImplCopyWith<
          _$UpdatePersonalDetailsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdatePersonalDetailsData _$UpdatePersonalDetailsDataFromJson(
    Map<String, dynamic> json) {
  return _UpdatePersonalDetailsData.fromJson(json);
}

/// @nodoc
mixin _$UpdatePersonalDetailsData {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePersonalDetailsDataCopyWith<UpdatePersonalDetailsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePersonalDetailsDataCopyWith<$Res> {
  factory $UpdatePersonalDetailsDataCopyWith(UpdatePersonalDetailsData value,
          $Res Function(UpdatePersonalDetailsData) then) =
      _$UpdatePersonalDetailsDataCopyWithImpl<$Res, UpdatePersonalDetailsData>;
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      String? phoneNumber,
      String? gender,
      DateTime? dob,
      String? username,
      String? emergencyContact,
      int? avatar,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UpdatePersonalDetailsDataCopyWithImpl<$Res,
        $Val extends UpdatePersonalDetailsData>
    implements $UpdatePersonalDetailsDataCopyWith<$Res> {
  _$UpdatePersonalDetailsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePersonalDetailsDataImplCopyWith<$Res>
    implements $UpdatePersonalDetailsDataCopyWith<$Res> {
  factory _$$UpdatePersonalDetailsDataImplCopyWith(
          _$UpdatePersonalDetailsDataImpl value,
          $Res Function(_$UpdatePersonalDetailsDataImpl) then) =
      __$$UpdatePersonalDetailsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String firstName,
      String lastName,
      String email,
      String? phoneNumber,
      String? gender,
      DateTime? dob,
      String? username,
      String? emergencyContact,
      int? avatar,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$UpdatePersonalDetailsDataImplCopyWithImpl<$Res>
    extends _$UpdatePersonalDetailsDataCopyWithImpl<$Res,
        _$UpdatePersonalDetailsDataImpl>
    implements _$$UpdatePersonalDetailsDataImplCopyWith<$Res> {
  __$$UpdatePersonalDetailsDataImplCopyWithImpl(
      _$UpdatePersonalDetailsDataImpl _value,
      $Res Function(_$UpdatePersonalDetailsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UpdatePersonalDetailsDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePersonalDetailsDataImpl implements _UpdatePersonalDetailsData {
  const _$UpdatePersonalDetailsDataImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phoneNumber,
      this.gender,
      this.dob,
      this.username,
      this.emergencyContact,
      this.avatar,
      this.createdAt,
      this.updatedAt});

  factory _$UpdatePersonalDetailsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePersonalDetailsDataImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? gender;
  @override
  final DateTime? dob;
  @override
  final String? username;
  @override
  final String? emergencyContact;
  @override
  final int? avatar;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UpdatePersonalDetailsData(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, gender: $gender, dob: $dob, username: $username, emergencyContact: $emergencyContact, avatar: $avatar, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePersonalDetailsDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      gender,
      dob,
      username,
      emergencyContact,
      avatar,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePersonalDetailsDataImplCopyWith<_$UpdatePersonalDetailsDataImpl>
      get copyWith => __$$UpdatePersonalDetailsDataImplCopyWithImpl<
          _$UpdatePersonalDetailsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePersonalDetailsDataImplToJson(
      this,
    );
  }
}

abstract class _UpdatePersonalDetailsData implements UpdatePersonalDetailsData {
  const factory _UpdatePersonalDetailsData(
      {required final String id,
      required final String firstName,
      required final String lastName,
      required final String email,
      final String? phoneNumber,
      final String? gender,
      final DateTime? dob,
      final String? username,
      final String? emergencyContact,
      final int? avatar,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UpdatePersonalDetailsDataImpl;

  factory _UpdatePersonalDetailsData.fromJson(Map<String, dynamic> json) =
      _$UpdatePersonalDetailsDataImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get gender;
  @override
  DateTime? get dob;
  @override
  String? get username;
  @override
  String? get emergencyContact;
  @override
  int? get avatar;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePersonalDetailsDataImplCopyWith<_$UpdatePersonalDetailsDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  bool? get isLinked => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  bool? get isVisible => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<PreferenceData>? get preference => throw _privateConstructorUsedError;
  List<UserAnswer>? get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String firstName,
      String lastName,
      String email,
      String? phoneNumber,
      String? status,
      String? gender,
      DateTime? dob,
      bool? isLinked,
      String? username,
      String? emergencyContact,
      bool? isVisible,
      int? avatar,
      DateTime? updatedAt,
      List<PreferenceData>? preference,
      List<UserAnswer>? answer});
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? isLinked = freezed,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? isVisible = freezed,
    Object? avatar = freezed,
    Object? updatedAt = freezed,
    Object? preference = freezed,
    Object? answer = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLinked: freezed == isLinked
          ? _value.isLinked
          : isLinked // ignore: cast_nullable_to_non_nullable
              as bool?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: freezed == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preference: freezed == preference
          ? _value.preference
          : preference // ignore: cast_nullable_to_non_nullable
              as List<PreferenceData>?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<UserAnswer>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String firstName,
      String lastName,
      String email,
      String? phoneNumber,
      String? status,
      String? gender,
      DateTime? dob,
      bool? isLinked,
      String? username,
      String? emergencyContact,
      bool? isVisible,
      int? avatar,
      DateTime? updatedAt,
      List<PreferenceData>? preference,
      List<UserAnswer>? answer});
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? isLinked = freezed,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? isVisible = freezed,
    Object? avatar = freezed,
    Object? updatedAt = freezed,
    Object? preference = freezed,
    Object? answer = freezed,
  }) {
    return _then(_$ProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLinked: freezed == isLinked
          ? _value.isLinked
          : isLinked // ignore: cast_nullable_to_non_nullable
              as bool?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: freezed == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preference: freezed == preference
          ? _value._preference
          : preference // ignore: cast_nullable_to_non_nullable
              as List<PreferenceData>?,
      answer: freezed == answer
          ? _value._answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<UserAnswer>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl(
      {required this.id,
      required this.createdAt,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phoneNumber,
      this.status,
      this.gender,
      this.dob,
      this.isLinked,
      this.username,
      this.emergencyContact,
      this.isVisible,
      this.avatar,
      this.updatedAt,
      final List<PreferenceData>? preference,
      final List<UserAnswer>? answer})
      : _preference = preference,
        _answer = answer;

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? status;
  @override
  final String? gender;
  @override
  final DateTime? dob;
  @override
  final bool? isLinked;
  @override
  final String? username;
  @override
  final String? emergencyContact;
  @override
  final bool? isVisible;
  @override
  final int? avatar;
  @override
  final DateTime? updatedAt;
  final List<PreferenceData>? _preference;
  @override
  List<PreferenceData>? get preference {
    final value = _preference;
    if (value == null) return null;
    if (_preference is EqualUnmodifiableListView) return _preference;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<UserAnswer>? _answer;
  @override
  List<UserAnswer>? get answer {
    final value = _answer;
    if (value == null) return null;
    if (_answer is EqualUnmodifiableListView) return _answer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, createdAt: $createdAt, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, status: $status, gender: $gender, dob: $dob, isLinked: $isLinked, username: $username, emergencyContact: $emergencyContact, isVisible: $isVisible, avatar: $avatar, updatedAt: $updatedAt, preference: $preference, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.isLinked, isLinked) ||
                other.isLinked == isLinked) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._preference, _preference) &&
            const DeepCollectionEquality().equals(other._answer, _answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      firstName,
      lastName,
      email,
      phoneNumber,
      status,
      gender,
      dob,
      isLinked,
      username,
      emergencyContact,
      isVisible,
      avatar,
      updatedAt,
      const DeepCollectionEquality().hash(_preference),
      const DeepCollectionEquality().hash(_answer));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel(
      {required final String id,
      required final DateTime createdAt,
      required final String firstName,
      required final String lastName,
      required final String email,
      final String? phoneNumber,
      final String? status,
      final String? gender,
      final DateTime? dob,
      final bool? isLinked,
      final String? username,
      final String? emergencyContact,
      final bool? isVisible,
      final int? avatar,
      final DateTime? updatedAt,
      final List<PreferenceData>? preference,
      final List<UserAnswer>? answer}) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get status;
  @override
  String? get gender;
  @override
  DateTime? get dob;
  @override
  bool? get isLinked;
  @override
  String? get username;
  @override
  String? get emergencyContact;
  @override
  bool? get isVisible;
  @override
  int? get avatar;
  @override
  DateTime? get updatedAt;
  @override
  List<PreferenceData>? get preference;
  @override
  List<UserAnswer>? get answer;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
