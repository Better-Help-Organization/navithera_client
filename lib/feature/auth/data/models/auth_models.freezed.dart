// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return _ApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiResponse {
  AuthData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call({AuthData data, String message, int statusCode});

  $AuthDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthDataCopyWith<$Res> get data {
    return $AuthDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseImplCopyWith(
          _$ApiResponseImpl value, $Res Function(_$ApiResponseImpl) then) =
      __$$ApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData data, String message, int statusCode});

  @override
  $AuthDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseImpl>
    implements _$$ApiResponseImplCopyWith<$Res> {
  __$$ApiResponseImplCopyWithImpl(
      _$ApiResponseImpl _value, $Res Function(_$ApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(_$ApiResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseImpl implements _ApiResponse {
  const _$ApiResponseImpl(
      {required this.data, required this.message, required this.statusCode});

  factory _$ApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseImplFromJson(json);

  @override
  final AuthData data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ApiResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<_$ApiResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseImplToJson(
      this,
    );
  }
}

abstract class _ApiResponse implements ApiResponse {
  const factory _ApiResponse(
      {required final AuthData data,
      required final String message,
      required final int statusCode}) = _$ApiResponseImpl;

  factory _ApiResponse.fromJson(Map<String, dynamic> json) =
      _$ApiResponseImpl.fromJson;

  @override
  AuthData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthData _$AuthDataFromJson(Map<String, dynamic> json) {
  return _AuthData.fromJson(json);
}

/// @nodoc
mixin _$AuthData {
  UserModel get user => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthDataCopyWith<AuthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDataCopyWith<$Res> {
  factory $AuthDataCopyWith(AuthData value, $Res Function(AuthData) then) =
      _$AuthDataCopyWithImpl<$Res, AuthData>;
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthDataCopyWithImpl<$Res, $Val extends AuthData>
    implements $AuthDataCopyWith<$Res> {
  _$AuthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthDataImplCopyWith<$Res>
    implements $AuthDataCopyWith<$Res> {
  factory _$$AuthDataImplCopyWith(
          _$AuthDataImpl value, $Res Function(_$AuthDataImpl) then) =
      __$$AuthDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthDataImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthDataImpl>
    implements _$$AuthDataImplCopyWith<$Res> {
  __$$AuthDataImplCopyWithImpl(
      _$AuthDataImpl _value, $Res Function(_$AuthDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$AuthDataImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthDataImpl implements _AuthData {
  const _$AuthDataImpl(
      {required this.user,
      required this.accessToken,
      required this.refreshToken});

  factory _$AuthDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthDataImplFromJson(json);

  @override
  final UserModel user;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthData(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthDataImplCopyWith<_$AuthDataImpl> get copyWith =>
      __$$AuthDataImplCopyWithImpl<_$AuthDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthDataImplToJson(
      this,
    );
  }
}

abstract class _AuthData implements AuthData {
  const factory _AuthData(
      {required final UserModel user,
      required final String accessToken,
      required final String refreshToken}) = _$AuthDataImpl;

  factory _AuthData.fromJson(Map<String, dynamic> json) =
      _$AuthDataImpl.fromJson;

  @override
  UserModel get user;
  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthDataImplCopyWith<_$AuthDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firebaseToken => throw _privateConstructorUsedError;
  String? get voIpToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
          LoginRequest value, $Res Function(LoginRequest) then) =
      _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call(
      {String phoneNumber,
      String password,
      String firebaseToken,
      String? voIpToken});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? password = null,
    Object? firebaseToken = null,
    Object? voIpToken = freezed,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: null == firebaseToken
          ? _value.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String,
      voIpToken: freezed == voIpToken
          ? _value.voIpToken
          : voIpToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
          _$LoginRequestImpl value, $Res Function(_$LoginRequestImpl) then) =
      __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phoneNumber,
      String password,
      String firebaseToken,
      String? voIpToken});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
      _$LoginRequestImpl _value, $Res Function(_$LoginRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? password = null,
    Object? firebaseToken = null,
    Object? voIpToken = freezed,
  }) {
    return _then(_$LoginRequestImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: null == firebaseToken
          ? _value.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String,
      voIpToken: freezed == voIpToken
          ? _value.voIpToken
          : voIpToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl(
      {required this.phoneNumber,
      required this.password,
      required this.firebaseToken,
      this.voIpToken});

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String password;
  @override
  final String firebaseToken;
  @override
  final String? voIpToken;

  @override
  String toString() {
    return 'LoginRequest(phoneNumber: $phoneNumber, password: $password, firebaseToken: $firebaseToken, voIpToken: $voIpToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken) &&
            (identical(other.voIpToken, voIpToken) ||
                other.voIpToken == voIpToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, password, firebaseToken, voIpToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(
      this,
    );
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest(
      {required final String phoneNumber,
      required final String password,
      required final String firebaseToken,
      final String? voIpToken}) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get password;
  @override
  String get firebaseToken;
  @override
  String? get voIpToken;
  @override
  @JsonKey(ignore: true)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileApiResponse _$ProfileApiResponseFromJson(Map<String, dynamic> json) {
  return _ProfileApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileApiResponse {
  UserModel get data =>
      throw _privateConstructorUsedError; // Direct user data, not wrapped in AuthData
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileApiResponseCopyWith<ProfileApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileApiResponseCopyWith<$Res> {
  factory $ProfileApiResponseCopyWith(
          ProfileApiResponse value, $Res Function(ProfileApiResponse) then) =
      _$ProfileApiResponseCopyWithImpl<$Res, ProfileApiResponse>;
  @useResult
  $Res call({UserModel data, String message, int statusCode});

  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ProfileApiResponseCopyWithImpl<$Res, $Val extends ProfileApiResponse>
    implements $ProfileApiResponseCopyWith<$Res> {
  _$ProfileApiResponseCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserModel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get data {
    return $UserModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileApiResponseImplCopyWith<$Res>
    implements $ProfileApiResponseCopyWith<$Res> {
  factory _$$ProfileApiResponseImplCopyWith(_$ProfileApiResponseImpl value,
          $Res Function(_$ProfileApiResponseImpl) then) =
      __$$ProfileApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel data, String message, int statusCode});

  @override
  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$ProfileApiResponseImplCopyWithImpl<$Res>
    extends _$ProfileApiResponseCopyWithImpl<$Res, _$ProfileApiResponseImpl>
    implements _$$ProfileApiResponseImplCopyWith<$Res> {
  __$$ProfileApiResponseImplCopyWithImpl(_$ProfileApiResponseImpl _value,
      $Res Function(_$ProfileApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(_$ProfileApiResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UserModel,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileApiResponseImpl implements _ProfileApiResponse {
  const _$ProfileApiResponseImpl(
      {required this.data, required this.message, required this.statusCode});

  factory _$ProfileApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileApiResponseImplFromJson(json);

  @override
  final UserModel data;
// Direct user data, not wrapped in AuthData
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ProfileApiResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileApiResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileApiResponseImplCopyWith<_$ProfileApiResponseImpl> get copyWith =>
      __$$ProfileApiResponseImplCopyWithImpl<_$ProfileApiResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileApiResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfileApiResponse implements ProfileApiResponse {
  const factory _ProfileApiResponse(
      {required final UserModel data,
      required final String message,
      required final int statusCode}) = _$ProfileApiResponseImpl;

  factory _ProfileApiResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileApiResponseImpl.fromJson;

  @override
  UserModel get data;
  @override // Direct user data, not wrapped in AuthData
  String get message;
  @override
  int get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ProfileApiResponseImplCopyWith<_$ProfileApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return _SignupRequest.fromJson(json);
}

/// @nodoc
mixin _$SignupRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get firebaseToken => throw _privateConstructorUsedError;
  String get dob => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupRequestCopyWith<SignupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestCopyWith<$Res> {
  factory $SignupRequestCopyWith(
          SignupRequest value, $Res Function(SignupRequest) then) =
      _$SignupRequestCopyWithImpl<$Res, SignupRequest>;
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String email,
      String password,
      String gender,
      String firebaseToken,
      String dob,
      String username,
      String phoneNumber});
}

/// @nodoc
class _$SignupRequestCopyWithImpl<$Res, $Val extends SignupRequest>
    implements $SignupRequestCopyWith<$Res> {
  _$SignupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? gender = null,
    Object? firebaseToken = null,
    Object? dob = null,
    Object? username = null,
    Object? phoneNumber = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: null == firebaseToken
          ? _value.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupRequestImplCopyWith<$Res>
    implements $SignupRequestCopyWith<$Res> {
  factory _$$SignupRequestImplCopyWith(
          _$SignupRequestImpl value, $Res Function(_$SignupRequestImpl) then) =
      __$$SignupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstName,
      String lastName,
      String email,
      String password,
      String gender,
      String firebaseToken,
      String dob,
      String username,
      String phoneNumber});
}

/// @nodoc
class __$$SignupRequestImplCopyWithImpl<$Res>
    extends _$SignupRequestCopyWithImpl<$Res, _$SignupRequestImpl>
    implements _$$SignupRequestImplCopyWith<$Res> {
  __$$SignupRequestImplCopyWithImpl(
      _$SignupRequestImpl _value, $Res Function(_$SignupRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? gender = null,
    Object? firebaseToken = null,
    Object? dob = null,
    Object? username = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$SignupRequestImpl(
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
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: null == firebaseToken
          ? _value.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupRequestImpl implements _SignupRequest {
  const _$SignupRequestImpl(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.gender,
      required this.firebaseToken,
      required this.dob,
      required this.username,
      required this.phoneNumber});

  factory _$SignupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String gender;
  @override
  final String firebaseToken;
  @override
  final String dob;
  @override
  final String username;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'SignupRequest(firstName: $firstName, lastName: $lastName, email: $email, password: $password, gender: $gender, firebaseToken: $firebaseToken, dob: $dob, username: $username, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstName, lastName, email,
      password, gender, firebaseToken, dob, username, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupRequestImplCopyWith<_$SignupRequestImpl> get copyWith =>
      __$$SignupRequestImplCopyWithImpl<_$SignupRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupRequestImplToJson(
      this,
    );
  }
}

abstract class _SignupRequest implements SignupRequest {
  const factory _SignupRequest(
      {required final String firstName,
      required final String lastName,
      required final String email,
      required final String password,
      required final String gender,
      required final String firebaseToken,
      required final String dob,
      required final String username,
      required final String phoneNumber}) = _$SignupRequestImpl;

  factory _SignupRequest.fromJson(Map<String, dynamic> json) =
      _$SignupRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get gender;
  @override
  String get firebaseToken;
  @override
  String get dob;
  @override
  String get username;
  @override
  String get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$SignupRequestImplCopyWith<_$SignupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpertiseData _$ExpertiseDataFromJson(Map<String, dynamic> json) {
  return _ExpertiseData.fromJson(json);
}

/// @nodoc
mixin _$ExpertiseData {
  String get id => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get expertise => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpertiseDataCopyWith<ExpertiseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpertiseDataCopyWith<$Res> {
  factory $ExpertiseDataCopyWith(
          ExpertiseData value, $Res Function(ExpertiseData) then) =
      _$ExpertiseDataCopyWithImpl<$Res, ExpertiseData>;
  @useResult
  $Res call(
      {String id, DateTime? updatedAt, DateTime? createdAt, String? expertise});
}

/// @nodoc
class _$ExpertiseDataCopyWithImpl<$Res, $Val extends ExpertiseData>
    implements $ExpertiseDataCopyWith<$Res> {
  _$ExpertiseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? expertise = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpertiseDataImplCopyWith<$Res>
    implements $ExpertiseDataCopyWith<$Res> {
  factory _$$ExpertiseDataImplCopyWith(
          _$ExpertiseDataImpl value, $Res Function(_$ExpertiseDataImpl) then) =
      __$$ExpertiseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, DateTime? updatedAt, DateTime? createdAt, String? expertise});
}

/// @nodoc
class __$$ExpertiseDataImplCopyWithImpl<$Res>
    extends _$ExpertiseDataCopyWithImpl<$Res, _$ExpertiseDataImpl>
    implements _$$ExpertiseDataImplCopyWith<$Res> {
  __$$ExpertiseDataImplCopyWithImpl(
      _$ExpertiseDataImpl _value, $Res Function(_$ExpertiseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? expertise = freezed,
  }) {
    return _then(_$ExpertiseDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpertiseDataImpl implements _ExpertiseData {
  const _$ExpertiseDataImpl(
      {required this.id, this.updatedAt, this.createdAt, this.expertise});

  factory _$ExpertiseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpertiseDataImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? createdAt;
  @override
  final String? expertise;

  @override
  String toString() {
    return 'ExpertiseData(id: $id, updatedAt: $updatedAt, createdAt: $createdAt, expertise: $expertise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpertiseDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expertise, expertise) ||
                other.expertise == expertise));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, updatedAt, createdAt, expertise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpertiseDataImplCopyWith<_$ExpertiseDataImpl> get copyWith =>
      __$$ExpertiseDataImplCopyWithImpl<_$ExpertiseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpertiseDataImplToJson(
      this,
    );
  }
}

abstract class _ExpertiseData implements ExpertiseData {
  const factory _ExpertiseData(
      {required final String id,
      final DateTime? updatedAt,
      final DateTime? createdAt,
      final String? expertise}) = _$ExpertiseDataImpl;

  factory _ExpertiseData.fromJson(Map<String, dynamic> json) =
      _$ExpertiseDataImpl.fromJson;

  @override
  String get id;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get createdAt;
  @override
  String? get expertise;
  @override
  @JsonKey(ignore: true)
  _$$ExpertiseDataImplCopyWith<_$ExpertiseDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  bool? get isVisible => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  dynamic get emergencyContact => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isLinked => throw _privateConstructorUsedError;
  bool? get isEmailAuthenticated => throw _privateConstructorUsedError;
  bool? get isPhoneNumberAuthenticated => throw _privateConstructorUsedError;
  @JsonKey(name: 'preference')
  List<PrefData>? get preferences =>
      throw _privateConstructorUsedError; // Map 'preference' to 'preferences'
  @JsonKey(name: 'answer')
  List<AnsData>? get answers =>
      throw _privateConstructorUsedError; // Map 'answer' to 'answers'
  @JsonKey(name: 'activeSubscription')
  SubscriptionData? get activeSubscription =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'expertise')
  List<ExpertiseData>? get expertise => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  bool? get isOnline => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  NotificationItem? get hasNotification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String firstName,
      String lastName,
      DateTime createdAt,
      String? status,
      String? gender,
      DateTime? dob,
      String? username,
      String? phoneNumber,
      bool? isVisible,
      DateTime? updatedAt,
      dynamic emergencyContact,
      DateTime? deletedAt,
      bool? isLinked,
      bool? isEmailAuthenticated,
      bool? isPhoneNumberAuthenticated,
      @JsonKey(name: 'preference') List<PrefData>? preferences,
      @JsonKey(name: 'answer') List<AnsData>? answers,
      @JsonKey(name: 'activeSubscription') SubscriptionData? activeSubscription,
      @JsonKey(name: 'expertise') List<ExpertiseData>? expertise,
      int? avatar,
      String? profile,
      bool? isOnline,
      String? bio,
      NotificationItem? hasNotification});

  $SubscriptionDataCopyWith<$Res>? get activeSubscription;
  $NotificationItemCopyWith<$Res>? get hasNotification;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isEmailAuthenticated = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? preferences = freezed,
    Object? answers = freezed,
    Object? activeSubscription = freezed,
    Object? expertise = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? isOnline = freezed,
    Object? bio = freezed,
    Object? hasNotification = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: freezed == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLinked: freezed == isLinked
          ? _value.isLinked
          : isLinked // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEmailAuthenticated: freezed == isEmailAuthenticated
          ? _value.isEmailAuthenticated
          : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPhoneNumberAuthenticated: freezed == isPhoneNumberAuthenticated
          ? _value.isPhoneNumberAuthenticated
          : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<PrefData>?,
      answers: freezed == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnsData>?,
      activeSubscription: freezed == activeSubscription
          ? _value.activeSubscription
          : activeSubscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionData?,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<ExpertiseData>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      hasNotification: freezed == hasNotification
          ? _value.hasNotification
          : hasNotification // ignore: cast_nullable_to_non_nullable
              as NotificationItem?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SubscriptionDataCopyWith<$Res>? get activeSubscription {
    if (_value.activeSubscription == null) {
      return null;
    }

    return $SubscriptionDataCopyWith<$Res>(_value.activeSubscription!, (value) {
      return _then(_value.copyWith(activeSubscription: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationItemCopyWith<$Res>? get hasNotification {
    if (_value.hasNotification == null) {
      return null;
    }

    return $NotificationItemCopyWith<$Res>(_value.hasNotification!, (value) {
      return _then(_value.copyWith(hasNotification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String firstName,
      String lastName,
      DateTime createdAt,
      String? status,
      String? gender,
      DateTime? dob,
      String? username,
      String? phoneNumber,
      bool? isVisible,
      DateTime? updatedAt,
      dynamic emergencyContact,
      DateTime? deletedAt,
      bool? isLinked,
      bool? isEmailAuthenticated,
      bool? isPhoneNumberAuthenticated,
      @JsonKey(name: 'preference') List<PrefData>? preferences,
      @JsonKey(name: 'answer') List<AnsData>? answers,
      @JsonKey(name: 'activeSubscription') SubscriptionData? activeSubscription,
      @JsonKey(name: 'expertise') List<ExpertiseData>? expertise,
      int? avatar,
      String? profile,
      bool? isOnline,
      String? bio,
      NotificationItem? hasNotification});

  @override
  $SubscriptionDataCopyWith<$Res>? get activeSubscription;
  @override
  $NotificationItemCopyWith<$Res>? get hasNotification;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isEmailAuthenticated = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? preferences = freezed,
    Object? answers = freezed,
    Object? activeSubscription = freezed,
    Object? expertise = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? isOnline = freezed,
    Object? bio = freezed,
    Object? hasNotification = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isVisible: freezed == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as dynamic,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLinked: freezed == isLinked
          ? _value.isLinked
          : isLinked // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEmailAuthenticated: freezed == isEmailAuthenticated
          ? _value.isEmailAuthenticated
          : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPhoneNumberAuthenticated: freezed == isPhoneNumberAuthenticated
          ? _value.isPhoneNumberAuthenticated
          : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool?,
      preferences: freezed == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as List<PrefData>?,
      answers: freezed == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnsData>?,
      activeSubscription: freezed == activeSubscription
          ? _value.activeSubscription
          : activeSubscription // ignore: cast_nullable_to_non_nullable
              as SubscriptionData?,
      expertise: freezed == expertise
          ? _value._expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<ExpertiseData>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      hasNotification: freezed == hasNotification
          ? _value.hasNotification
          : hasNotification // ignore: cast_nullable_to_non_nullable
              as NotificationItem?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.createdAt,
      this.status,
      this.gender,
      this.dob,
      this.username,
      this.phoneNumber,
      this.isVisible,
      this.updatedAt,
      this.emergencyContact,
      this.deletedAt,
      this.isLinked,
      this.isEmailAuthenticated,
      this.isPhoneNumberAuthenticated,
      @JsonKey(name: 'preference') final List<PrefData>? preferences,
      @JsonKey(name: 'answer') final List<AnsData>? answers,
      @JsonKey(name: 'activeSubscription') this.activeSubscription,
      @JsonKey(name: 'expertise') final List<ExpertiseData>? expertise,
      this.avatar,
      this.profile,
      this.isOnline,
      this.bio,
      this.hasNotification})
      : _preferences = preferences,
        _answers = answers,
        _expertise = expertise;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime createdAt;
  @override
  final String? status;
  @override
  final String? gender;
  @override
  final DateTime? dob;
  @override
  final String? username;
  @override
  final String? phoneNumber;
  @override
  final bool? isVisible;
  @override
  final DateTime? updatedAt;
  @override
  final dynamic emergencyContact;
  @override
  final DateTime? deletedAt;
  @override
  final bool? isLinked;
  @override
  final bool? isEmailAuthenticated;
  @override
  final bool? isPhoneNumberAuthenticated;
  final List<PrefData>? _preferences;
  @override
  @JsonKey(name: 'preference')
  List<PrefData>? get preferences {
    final value = _preferences;
    if (value == null) return null;
    if (_preferences is EqualUnmodifiableListView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Map 'preference' to 'preferences'
  final List<AnsData>? _answers;
// Map 'preference' to 'preferences'
  @override
  @JsonKey(name: 'answer')
  List<AnsData>? get answers {
    final value = _answers;
    if (value == null) return null;
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Map 'answer' to 'answers'
  @override
  @JsonKey(name: 'activeSubscription')
  final SubscriptionData? activeSubscription;
  final List<ExpertiseData>? _expertise;
  @override
  @JsonKey(name: 'expertise')
  List<ExpertiseData>? get expertise {
    final value = _expertise;
    if (value == null) return null;
    if (_expertise is EqualUnmodifiableListView) return _expertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? avatar;
  @override
  final String? profile;
  @override
  final bool? isOnline;
  @override
  final String? bio;
  @override
  final NotificationItem? hasNotification;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, status: $status, gender: $gender, dob: $dob, username: $username, phoneNumber: $phoneNumber, isVisible: $isVisible, updatedAt: $updatedAt, emergencyContact: $emergencyContact, deletedAt: $deletedAt, isLinked: $isLinked, isEmailAuthenticated: $isEmailAuthenticated, isPhoneNumberAuthenticated: $isPhoneNumberAuthenticated, preferences: $preferences, answers: $answers, activeSubscription: $activeSubscription, expertise: $expertise, avatar: $avatar, profile: $profile, isOnline: $isOnline, bio: $bio, hasNotification: $hasNotification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.emergencyContact, emergencyContact) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isLinked, isLinked) ||
                other.isLinked == isLinked) &&
            (identical(other.isEmailAuthenticated, isEmailAuthenticated) ||
                other.isEmailAuthenticated == isEmailAuthenticated) &&
            (identical(other.isPhoneNumberAuthenticated,
                    isPhoneNumberAuthenticated) ||
                other.isPhoneNumberAuthenticated ==
                    isPhoneNumberAuthenticated) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.activeSubscription, activeSubscription) ||
                other.activeSubscription == activeSubscription) &&
            const DeepCollectionEquality()
                .equals(other._expertise, _expertise) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.hasNotification, hasNotification) ||
                other.hasNotification == hasNotification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        firstName,
        lastName,
        createdAt,
        status,
        gender,
        dob,
        username,
        phoneNumber,
        isVisible,
        updatedAt,
        const DeepCollectionEquality().hash(emergencyContact),
        deletedAt,
        isLinked,
        isEmailAuthenticated,
        isPhoneNumberAuthenticated,
        const DeepCollectionEquality().hash(_preferences),
        const DeepCollectionEquality().hash(_answers),
        activeSubscription,
        const DeepCollectionEquality().hash(_expertise),
        avatar,
        profile,
        isOnline,
        bio,
        hasNotification
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String email,
      required final String firstName,
      required final String lastName,
      required final DateTime createdAt,
      final String? status,
      final String? gender,
      final DateTime? dob,
      final String? username,
      final String? phoneNumber,
      final bool? isVisible,
      final DateTime? updatedAt,
      final dynamic emergencyContact,
      final DateTime? deletedAt,
      final bool? isLinked,
      final bool? isEmailAuthenticated,
      final bool? isPhoneNumberAuthenticated,
      @JsonKey(name: 'preference') final List<PrefData>? preferences,
      @JsonKey(name: 'answer') final List<AnsData>? answers,
      @JsonKey(name: 'activeSubscription')
      final SubscriptionData? activeSubscription,
      @JsonKey(name: 'expertise') final List<ExpertiseData>? expertise,
      final int? avatar,
      final String? profile,
      final bool? isOnline,
      final String? bio,
      final NotificationItem? hasNotification}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get createdAt;
  @override
  String? get status;
  @override
  String? get gender;
  @override
  DateTime? get dob;
  @override
  String? get username;
  @override
  String? get phoneNumber;
  @override
  bool? get isVisible;
  @override
  DateTime? get updatedAt;
  @override
  dynamic get emergencyContact;
  @override
  DateTime? get deletedAt;
  @override
  bool? get isLinked;
  @override
  bool? get isEmailAuthenticated;
  @override
  bool? get isPhoneNumberAuthenticated;
  @override
  @JsonKey(name: 'preference')
  List<PrefData>? get preferences;
  @override // Map 'preference' to 'preferences'
  @JsonKey(name: 'answer')
  List<AnsData>? get answers;
  @override // Map 'answer' to 'answers'
  @JsonKey(name: 'activeSubscription')
  SubscriptionData? get activeSubscription;
  @override
  @JsonKey(name: 'expertise')
  List<ExpertiseData>? get expertise;
  @override
  int? get avatar;
  @override
  String? get profile;
  @override
  bool? get isOnline;
  @override
  String? get bio;
  @override
  NotificationItem? get hasNotification;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrefData _$PrefDataFromJson(Map<String, dynamic> json) {
  return _PrefData.fromJson(json);
}

/// @nodoc
mixin _$PrefData {
  String? get id => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrefDataCopyWith<PrefData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrefDataCopyWith<$Res> {
  factory $PrefDataCopyWith(PrefData value, $Res Function(PrefData) then) =
      _$PrefDataCopyWithImpl<$Res, PrefData>;
  @useResult
  $Res call({String? id, String? gender, String? goal});
}

/// @nodoc
class _$PrefDataCopyWithImpl<$Res, $Val extends PrefData>
    implements $PrefDataCopyWith<$Res> {
  _$PrefDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gender = freezed,
    Object? goal = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrefDataImplCopyWith<$Res>
    implements $PrefDataCopyWith<$Res> {
  factory _$$PrefDataImplCopyWith(
          _$PrefDataImpl value, $Res Function(_$PrefDataImpl) then) =
      __$$PrefDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? gender, String? goal});
}

/// @nodoc
class __$$PrefDataImplCopyWithImpl<$Res>
    extends _$PrefDataCopyWithImpl<$Res, _$PrefDataImpl>
    implements _$$PrefDataImplCopyWith<$Res> {
  __$$PrefDataImplCopyWithImpl(
      _$PrefDataImpl _value, $Res Function(_$PrefDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gender = freezed,
    Object? goal = freezed,
  }) {
    return _then(_$PrefDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrefDataImpl implements _PrefData {
  const _$PrefDataImpl({this.id, this.gender, this.goal});

  factory _$PrefDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrefDataImplFromJson(json);

  @override
  final String? id;
  @override
  final String? gender;
  @override
  final String? goal;

  @override
  String toString() {
    return 'PrefData(id: $id, gender: $gender, goal: $goal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrefDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.goal, goal) || other.goal == goal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, gender, goal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrefDataImplCopyWith<_$PrefDataImpl> get copyWith =>
      __$$PrefDataImplCopyWithImpl<_$PrefDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrefDataImplToJson(
      this,
    );
  }
}

abstract class _PrefData implements PrefData {
  const factory _PrefData(
      {final String? id,
      final String? gender,
      final String? goal}) = _$PrefDataImpl;

  factory _PrefData.fromJson(Map<String, dynamic> json) =
      _$PrefDataImpl.fromJson;

  @override
  String? get id;
  @override
  String? get gender;
  @override
  String? get goal;
  @override
  @JsonKey(ignore: true)
  _$$PrefDataImplCopyWith<_$PrefDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnsData _$AnsDataFromJson(Map<String, dynamic> json) {
  return _AnsData.fromJson(json);
}

/// @nodoc
mixin _$AnsData {
  String? get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnsDataCopyWith<AnsData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnsDataCopyWith<$Res> {
  factory $AnsDataCopyWith(AnsData value, $Res Function(AnsData) then) =
      _$AnsDataCopyWithImpl<$Res, AnsData>;
  @useResult
  $Res call({String? id, String? text});
}

/// @nodoc
class _$AnsDataCopyWithImpl<$Res, $Val extends AnsData>
    implements $AnsDataCopyWith<$Res> {
  _$AnsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnsDataImplCopyWith<$Res> implements $AnsDataCopyWith<$Res> {
  factory _$$AnsDataImplCopyWith(
          _$AnsDataImpl value, $Res Function(_$AnsDataImpl) then) =
      __$$AnsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? text});
}

/// @nodoc
class __$$AnsDataImplCopyWithImpl<$Res>
    extends _$AnsDataCopyWithImpl<$Res, _$AnsDataImpl>
    implements _$$AnsDataImplCopyWith<$Res> {
  __$$AnsDataImplCopyWithImpl(
      _$AnsDataImpl _value, $Res Function(_$AnsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
  }) {
    return _then(_$AnsDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnsDataImpl implements _AnsData {
  const _$AnsDataImpl({this.id, this.text});

  factory _$AnsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnsDataImplFromJson(json);

  @override
  final String? id;
  @override
  final String? text;

  @override
  String toString() {
    return 'AnsData(id: $id, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnsDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnsDataImplCopyWith<_$AnsDataImpl> get copyWith =>
      __$$AnsDataImplCopyWithImpl<_$AnsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnsDataImplToJson(
      this,
    );
  }
}

abstract class _AnsData implements AnsData {
  const factory _AnsData({final String? id, final String? text}) =
      _$AnsDataImpl;

  factory _AnsData.fromJson(Map<String, dynamic> json) = _$AnsDataImpl.fromJson;

  @override
  String? get id;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$AnsDataImplCopyWith<_$AnsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError; // String? dob,
  String? get username => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(UpdateProfileRequest value,
          $Res Function(UpdateProfileRequest) then) =
      _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call(
      {String? firstName,
      String? lastName,
      String? email,
      String? gender,
      String? username,
      String? phoneNumber});
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<$Res,
        $Val extends UpdateProfileRequest>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(_$UpdateProfileRequestImpl value,
          $Res Function(_$UpdateProfileRequestImpl) then) =
      __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? firstName,
      String? lastName,
      String? email,
      String? gender,
      String? username,
      String? phoneNumber});
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(_$UpdateProfileRequestImpl _value,
      $Res Function(_$UpdateProfileRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$UpdateProfileRequestImpl(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl(
      {this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.username,
      this.phoneNumber});

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? gender;
// String? dob,
  @override
  final String? username;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'UpdateProfileRequest(firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, username: $username, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, firstName, lastName, email, gender, username, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith =>
          __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest(
      {final String? firstName,
      final String? lastName,
      final String? email,
      final String? gender,
      final String? username,
      final String? phoneNumber}) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get gender;
  @override // String? dob,
  String? get username;
  @override
  String? get phoneNumber;
  @override
  @JsonKey(ignore: true)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateProfilePicRequest _$UpdateProfilePicRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateProfilePicRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfilePicRequest {
  int? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateProfilePicRequestCopyWith<UpdateProfilePicRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfilePicRequestCopyWith<$Res> {
  factory $UpdateProfilePicRequestCopyWith(UpdateProfilePicRequest value,
          $Res Function(UpdateProfilePicRequest) then) =
      _$UpdateProfilePicRequestCopyWithImpl<$Res, UpdateProfilePicRequest>;
  @useResult
  $Res call({int? avatar});
}

/// @nodoc
class _$UpdateProfilePicRequestCopyWithImpl<$Res,
        $Val extends UpdateProfilePicRequest>
    implements $UpdateProfilePicRequestCopyWith<$Res> {
  _$UpdateProfilePicRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateProfilePicRequestImplCopyWith<$Res>
    implements $UpdateProfilePicRequestCopyWith<$Res> {
  factory _$$UpdateProfilePicRequestImplCopyWith(
          _$UpdateProfilePicRequestImpl value,
          $Res Function(_$UpdateProfilePicRequestImpl) then) =
      __$$UpdateProfilePicRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? avatar});
}

/// @nodoc
class __$$UpdateProfilePicRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfilePicRequestCopyWithImpl<$Res,
        _$UpdateProfilePicRequestImpl>
    implements _$$UpdateProfilePicRequestImplCopyWith<$Res> {
  __$$UpdateProfilePicRequestImplCopyWithImpl(
      _$UpdateProfilePicRequestImpl _value,
      $Res Function(_$UpdateProfilePicRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = freezed,
  }) {
    return _then(_$UpdateProfilePicRequestImpl(
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfilePicRequestImpl implements _UpdateProfilePicRequest {
  const _$UpdateProfilePicRequestImpl({this.avatar});

  factory _$UpdateProfilePicRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfilePicRequestImplFromJson(json);

  @override
  final int? avatar;

  @override
  String toString() {
    return 'UpdateProfilePicRequest(avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfilePicRequestImpl &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfilePicRequestImplCopyWith<_$UpdateProfilePicRequestImpl>
      get copyWith => __$$UpdateProfilePicRequestImplCopyWithImpl<
          _$UpdateProfilePicRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfilePicRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateProfilePicRequest implements UpdateProfilePicRequest {
  const factory _UpdateProfilePicRequest({final int? avatar}) =
      _$UpdateProfilePicRequestImpl;

  factory _UpdateProfilePicRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfilePicRequestImpl.fromJson;

  @override
  int? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$UpdateProfilePicRequestImplCopyWith<_$UpdateProfilePicRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _ForgotPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordRequestCopyWith<$Res> {
  factory $ForgotPasswordRequestCopyWith(ForgotPasswordRequest value,
          $Res Function(ForgotPasswordRequest) then) =
      _$ForgotPasswordRequestCopyWithImpl<$Res, ForgotPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<$Res,
        $Val extends ForgotPasswordRequest>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotPasswordRequestImplCopyWith<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$$ForgotPasswordRequestImplCopyWith(
          _$ForgotPasswordRequestImpl value,
          $Res Function(_$ForgotPasswordRequestImpl) then) =
      __$$ForgotPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordRequestImplCopyWithImpl<$Res>
    extends _$ForgotPasswordRequestCopyWithImpl<$Res,
        _$ForgotPasswordRequestImpl>
    implements _$$ForgotPasswordRequestImplCopyWith<$Res> {
  __$$ForgotPasswordRequestImplCopyWithImpl(_$ForgotPasswordRequestImpl _value,
      $Res Function(_$ForgotPasswordRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ForgotPasswordRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordRequestImpl implements _ForgotPasswordRequest {
  const _$ForgotPasswordRequestImpl({required this.email});

  factory _$ForgotPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
      get copyWith => __$$ForgotPasswordRequestImplCopyWithImpl<
          _$ForgotPasswordRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordRequest implements ForgotPasswordRequest {
  const factory _ForgotPasswordRequest({required final String email}) =
      _$ForgotPasswordRequestImpl;

  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return _ResetPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get passwordConfirm => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResetPasswordRequestCopyWith<ResetPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordRequestCopyWith<$Res> {
  factory $ResetPasswordRequestCopyWith(ResetPasswordRequest value,
          $Res Function(ResetPasswordRequest) then) =
      _$ResetPasswordRequestCopyWithImpl<$Res, ResetPasswordRequest>;
  @useResult
  $Res call(
      {String email, String password, String passwordConfirm, String otp});
}

/// @nodoc
class _$ResetPasswordRequestCopyWithImpl<$Res,
        $Val extends ResetPasswordRequest>
    implements $ResetPasswordRequestCopyWith<$Res> {
  _$ResetPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordRequestImplCopyWith<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  factory _$$ResetPasswordRequestImplCopyWith(_$ResetPasswordRequestImpl value,
          $Res Function(_$ResetPasswordRequestImpl) then) =
      __$$ResetPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email, String password, String passwordConfirm, String otp});
}

/// @nodoc
class __$$ResetPasswordRequestImplCopyWithImpl<$Res>
    extends _$ResetPasswordRequestCopyWithImpl<$Res, _$ResetPasswordRequestImpl>
    implements _$$ResetPasswordRequestImplCopyWith<$Res> {
  __$$ResetPasswordRequestImplCopyWithImpl(_$ResetPasswordRequestImpl _value,
      $Res Function(_$ResetPasswordRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
    Object? otp = null,
  }) {
    return _then(_$ResetPasswordRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirm: null == passwordConfirm
          ? _value.passwordConfirm
          : passwordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordRequestImpl implements _ResetPasswordRequest {
  const _$ResetPasswordRequestImpl(
      {required this.email,
      required this.password,
      required this.passwordConfirm,
      required this.otp});

  factory _$ResetPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String passwordConfirm;
  @override
  final String otp;

  @override
  String toString() {
    return 'ResetPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirm, passwordConfirm) ||
                other.passwordConfirm == passwordConfirm) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, passwordConfirm, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
      get copyWith =>
          __$$ResetPasswordRequestImplCopyWithImpl<_$ResetPasswordRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordRequest implements ResetPasswordRequest {
  const factory _ResetPasswordRequest(
      {required final String email,
      required final String password,
      required final String passwordConfirm,
      required final String otp}) = _$ResetPasswordRequestImpl;

  factory _ResetPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get passwordConfirm;
  @override
  String get otp;
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
    Map<String, dynamic> json) {
  return _ForgotPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordResponse {
  String get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotPasswordResponseCopyWith<ForgotPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordResponseCopyWith<$Res> {
  factory $ForgotPasswordResponseCopyWith(ForgotPasswordResponse value,
          $Res Function(ForgotPasswordResponse) then) =
      _$ForgotPasswordResponseCopyWithImpl<$Res, ForgotPasswordResponse>;
  @useResult
  $Res call({String data, String message, int statusCode});
}

/// @nodoc
class _$ForgotPasswordResponseCopyWithImpl<$Res,
        $Val extends ForgotPasswordResponse>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  _$ForgotPasswordResponseCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotPasswordResponseImplCopyWith<$Res>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  factory _$$ForgotPasswordResponseImplCopyWith(
          _$ForgotPasswordResponseImpl value,
          $Res Function(_$ForgotPasswordResponseImpl) then) =
      __$$ForgotPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String data, String message, int statusCode});
}

/// @nodoc
class __$$ForgotPasswordResponseImplCopyWithImpl<$Res>
    extends _$ForgotPasswordResponseCopyWithImpl<$Res,
        _$ForgotPasswordResponseImpl>
    implements _$$ForgotPasswordResponseImplCopyWith<$Res> {
  __$$ForgotPasswordResponseImplCopyWithImpl(
      _$ForgotPasswordResponseImpl _value,
      $Res Function(_$ForgotPasswordResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(_$ForgotPasswordResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordResponseImpl implements _ForgotPasswordResponse {
  const _$ForgotPasswordResponseImpl(
      {required this.data, required this.message, required this.statusCode});

  factory _$ForgotPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordResponseImplFromJson(json);

  @override
  final String data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ForgotPasswordResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
      get copyWith => __$$ForgotPasswordResponseImplCopyWithImpl<
          _$ForgotPasswordResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordResponseImplToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordResponse implements ForgotPasswordResponse {
  const factory _ForgotPasswordResponse(
      {required final String data,
      required final String message,
      required final int statusCode}) = _$ForgotPasswordResponseImpl;

  factory _ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordResponseImpl.fromJson;

  @override
  String get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordResponse _$ResetPasswordResponseFromJson(
    Map<String, dynamic> json) {
  return _ResetPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordResponse {
  ResetPasswordData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResetPasswordResponseCopyWith<ResetPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordResponseCopyWith<$Res> {
  factory $ResetPasswordResponseCopyWith(ResetPasswordResponse value,
          $Res Function(ResetPasswordResponse) then) =
      _$ResetPasswordResponseCopyWithImpl<$Res, ResetPasswordResponse>;
  @useResult
  $Res call({ResetPasswordData data, String message, int statusCode});

  $ResetPasswordDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ResetPasswordResponseCopyWithImpl<$Res,
        $Val extends ResetPasswordResponse>
    implements $ResetPasswordResponseCopyWith<$Res> {
  _$ResetPasswordResponseCopyWithImpl(this._value, this._then);

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
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ResetPasswordData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResetPasswordDataCopyWith<$Res> get data {
    return $ResetPasswordDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResetPasswordResponseImplCopyWith<$Res>
    implements $ResetPasswordResponseCopyWith<$Res> {
  factory _$$ResetPasswordResponseImplCopyWith(
          _$ResetPasswordResponseImpl value,
          $Res Function(_$ResetPasswordResponseImpl) then) =
      __$$ResetPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ResetPasswordData data, String message, int statusCode});

  @override
  $ResetPasswordDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ResetPasswordResponseImplCopyWithImpl<$Res>
    extends _$ResetPasswordResponseCopyWithImpl<$Res,
        _$ResetPasswordResponseImpl>
    implements _$$ResetPasswordResponseImplCopyWith<$Res> {
  __$$ResetPasswordResponseImplCopyWithImpl(_$ResetPasswordResponseImpl _value,
      $Res Function(_$ResetPasswordResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(_$ResetPasswordResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ResetPasswordData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordResponseImpl implements _ResetPasswordResponse {
  const _$ResetPasswordResponseImpl(
      {required this.data, required this.message, required this.statusCode});

  factory _$ResetPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordResponseImplFromJson(json);

  @override
  final ResetPasswordData data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ResetPasswordResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordResponseImplCopyWith<_$ResetPasswordResponseImpl>
      get copyWith => __$$ResetPasswordResponseImplCopyWithImpl<
          _$ResetPasswordResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordResponseImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordResponse implements ResetPasswordResponse {
  const factory _ResetPasswordResponse(
      {required final ResetPasswordData data,
      required final String message,
      required final int statusCode}) = _$ResetPasswordResponseImpl;

  factory _ResetPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordResponseImpl.fromJson;

  @override
  ResetPasswordData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordResponseImplCopyWith<_$ResetPasswordResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordData _$ResetPasswordDataFromJson(Map<String, dynamic> json) {
  return _ResetPasswordData.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordData {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResetPasswordDataCopyWith<ResetPasswordData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordDataCopyWith<$Res> {
  factory $ResetPasswordDataCopyWith(
          ResetPasswordData value, $Res Function(ResetPasswordData) then) =
      _$ResetPasswordDataCopyWithImpl<$Res, ResetPasswordData>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ResetPasswordDataCopyWithImpl<$Res, $Val extends ResetPasswordData>
    implements $ResetPasswordDataCopyWith<$Res> {
  _$ResetPasswordDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordDataImplCopyWith<$Res>
    implements $ResetPasswordDataCopyWith<$Res> {
  factory _$$ResetPasswordDataImplCopyWith(_$ResetPasswordDataImpl value,
          $Res Function(_$ResetPasswordDataImpl) then) =
      __$$ResetPasswordDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ResetPasswordDataImplCopyWithImpl<$Res>
    extends _$ResetPasswordDataCopyWithImpl<$Res, _$ResetPasswordDataImpl>
    implements _$$ResetPasswordDataImplCopyWith<$Res> {
  __$$ResetPasswordDataImplCopyWithImpl(_$ResetPasswordDataImpl _value,
      $Res Function(_$ResetPasswordDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ResetPasswordDataImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordDataImpl implements _ResetPasswordData {
  const _$ResetPasswordDataImpl({required this.message});

  factory _$ResetPasswordDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordDataImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'ResetPasswordData(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordDataImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordDataImplCopyWith<_$ResetPasswordDataImpl> get copyWith =>
      __$$ResetPasswordDataImplCopyWithImpl<_$ResetPasswordDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordDataImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordData implements ResetPasswordData {
  const factory _ResetPasswordData({required final String message}) =
      _$ResetPasswordDataImpl;

  factory _ResetPasswordData.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordDataImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordDataImplCopyWith<_$ResetPasswordDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionData _$SubscriptionDataFromJson(Map<String, dynamic> json) {
  return _SubscriptionData.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionData {
  String get id => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get start_date => throw _privateConstructorUsedError;
  String? get end_date => throw _privateConstructorUsedError;
  int? get old_price => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionDataCopyWith<SubscriptionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionDataCopyWith<$Res> {
  factory $SubscriptionDataCopyWith(
          SubscriptionData value, $Res Function(SubscriptionData) then) =
      _$SubscriptionDataCopyWithImpl<$Res, SubscriptionData>;
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      int? type,
      String? status,
      String? start_date,
      String? end_date,
      int? old_price,
      int? price});
}

/// @nodoc
class _$SubscriptionDataCopyWithImpl<$Res, $Val extends SubscriptionData>
    implements $SubscriptionDataCopyWith<$Res> {
  _$SubscriptionDataCopyWithImpl(this._value, this._then);

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
    Object? type = freezed,
    Object? status = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? old_price = freezed,
    Object? price = freezed,
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as String?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as String?,
      old_price: freezed == old_price
          ? _value.old_price
          : old_price // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionDataImplCopyWith<$Res>
    implements $SubscriptionDataCopyWith<$Res> {
  factory _$$SubscriptionDataImplCopyWith(_$SubscriptionDataImpl value,
          $Res Function(_$SubscriptionDataImpl) then) =
      __$$SubscriptionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime updatedAt,
      DateTime createdAt,
      int? type,
      String? status,
      String? start_date,
      String? end_date,
      int? old_price,
      int? price});
}

/// @nodoc
class __$$SubscriptionDataImplCopyWithImpl<$Res>
    extends _$SubscriptionDataCopyWithImpl<$Res, _$SubscriptionDataImpl>
    implements _$$SubscriptionDataImplCopyWith<$Res> {
  __$$SubscriptionDataImplCopyWithImpl(_$SubscriptionDataImpl _value,
      $Res Function(_$SubscriptionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? type = freezed,
    Object? status = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? old_price = freezed,
    Object? price = freezed,
  }) {
    return _then(_$SubscriptionDataImpl(
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as String?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as String?,
      old_price: freezed == old_price
          ? _value.old_price
          : old_price // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionDataImpl implements _SubscriptionData {
  const _$SubscriptionDataImpl(
      {required this.id,
      required this.updatedAt,
      required this.createdAt,
      this.type,
      this.status,
      this.start_date,
      this.end_date,
      this.old_price,
      this.price});

  factory _$SubscriptionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionDataImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime updatedAt;
  @override
  final DateTime createdAt;
  @override
  final int? type;
  @override
  final String? status;
  @override
  final String? start_date;
  @override
  final String? end_date;
  @override
  final int? old_price;
  @override
  final int? price;

  @override
  String toString() {
    return 'SubscriptionData(id: $id, updatedAt: $updatedAt, createdAt: $createdAt, type: $type, status: $status, start_date: $start_date, end_date: $end_date, old_price: $old_price, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.end_date, end_date) ||
                other.end_date == end_date) &&
            (identical(other.old_price, old_price) ||
                other.old_price == old_price) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, updatedAt, createdAt, type,
      status, start_date, end_date, old_price, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionDataImplCopyWith<_$SubscriptionDataImpl> get copyWith =>
      __$$SubscriptionDataImplCopyWithImpl<_$SubscriptionDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionDataImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionData implements SubscriptionData {
  const factory _SubscriptionData(
      {required final String id,
      required final DateTime updatedAt,
      required final DateTime createdAt,
      final int? type,
      final String? status,
      final String? start_date,
      final String? end_date,
      final int? old_price,
      final int? price}) = _$SubscriptionDataImpl;

  factory _SubscriptionData.fromJson(Map<String, dynamic> json) =
      _$SubscriptionDataImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get updatedAt;
  @override
  DateTime get createdAt;
  @override
  int? get type;
  @override
  String? get status;
  @override
  String? get start_date;
  @override
  String? get end_date;
  @override
  int? get old_price;
  @override
  int? get price;
  @override
  @JsonKey(ignore: true)
  _$$SubscriptionDataImplCopyWith<_$SubscriptionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
