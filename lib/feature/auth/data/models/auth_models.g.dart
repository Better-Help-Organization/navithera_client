// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl _$$ApiResponseImplFromJson(Map<String, dynamic> json) =>
    _$ApiResponseImpl(
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ApiResponseImplToJson(_$ApiResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$AuthDataImpl _$$AuthDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthDataImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$AuthDataImplToJson(_$AuthDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      firebaseToken: json['firebaseToken'] as String,
      voIpToken: json['voIpToken'] as String?,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'firebaseToken': instance.firebaseToken,
      'voIpToken': instance.voIpToken,
    };

_$ProfileApiResponseImpl _$$ProfileApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileApiResponseImpl(
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfileApiResponseImplToJson(
        _$ProfileApiResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$SignupRequestImpl _$$SignupRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignupRequestImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
      firebaseToken: json['firebaseToken'] as String,
      dob: json['dob'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$$SignupRequestImplToJson(_$SignupRequestImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'firebaseToken': instance.firebaseToken,
      'dob': instance.dob,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
    };

_$ExpertiseDataImpl _$$ExpertiseDataImplFromJson(Map<String, dynamic> json) =>
    _$ExpertiseDataImpl(
      id: json['id'] as String,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expertise: json['expertise'] as String?,
    );

Map<String, dynamic> _$$ExpertiseDataImplToJson(_$ExpertiseDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'expertise': instance.expertise,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isVisible: json['isVisible'] as bool?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      emergencyContact: json['emergencyContact'],
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      isLinked: json['isLinked'] as bool?,
      isEmailAuthenticated: json['isEmailAuthenticated'] as bool?,
      isPhoneNumberAuthenticated: json['isPhoneNumberAuthenticated'] as bool?,
      preferences: (json['preference'] as List<dynamic>?)
          ?.map((e) => PrefData.fromJson(e as Map<String, dynamic>))
          .toList(),
      answers: (json['answer'] as List<dynamic>?)
          ?.map((e) => AnsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeSubscription: json['activeSubscription'] == null
          ? null
          : SubscriptionData.fromJson(
              json['activeSubscription'] as Map<String, dynamic>),
      expertise: (json['expertise'] as List<dynamic>?)
          ?.map((e) => ExpertiseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      avatar: (json['avatar'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      isOnline: json['isOnline'] as bool?,
      bio: json['bio'] as String?,
      hasNotification: json['hasNotification'] == null
          ? null
          : NotificationItem.fromJson(
              json['hasNotification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'isVisible': instance.isVisible,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'emergencyContact': instance.emergencyContact,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isLinked': instance.isLinked,
      'isEmailAuthenticated': instance.isEmailAuthenticated,
      'isPhoneNumberAuthenticated': instance.isPhoneNumberAuthenticated,
      'preference': instance.preferences,
      'answer': instance.answers,
      'activeSubscription': instance.activeSubscription,
      'expertise': instance.expertise,
      'avatar': instance.avatar,
      'profile': instance.profile,
      'isOnline': instance.isOnline,
      'bio': instance.bio,
      'hasNotification': instance.hasNotification,
    };

_$PrefDataImpl _$$PrefDataImplFromJson(Map<String, dynamic> json) =>
    _$PrefDataImpl(
      id: json['id'] as String?,
      gender: json['gender'] as String?,
      goal: json['goal'] as String?,
    );

Map<String, dynamic> _$$PrefDataImplToJson(_$PrefDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'goal': instance.goal,
    };

_$AnsDataImpl _$$AnsDataImplFromJson(Map<String, dynamic> json) =>
    _$AnsDataImpl(
      id: json['id'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$AnsDataImplToJson(_$AnsDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
    };

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProfileRequestImpl(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
        _$UpdateProfileRequestImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
    };

_$UpdateProfilePicRequestImpl _$$UpdateProfilePicRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateProfilePicRequestImpl(
      avatar: (json['avatar'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UpdateProfilePicRequestImplToJson(
        _$UpdateProfilePicRequestImpl instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
    };

_$ForgotPasswordRequestImpl _$$ForgotPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ForgotPasswordRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$ForgotPasswordRequestImplToJson(
        _$ForgotPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$ResetPasswordRequestImpl _$$ResetPasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirm: json['passwordConfirm'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
        _$ResetPasswordRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'passwordConfirm': instance.passwordConfirm,
      'otp': instance.otp,
    };

_$ForgotPasswordResponseImpl _$$ForgotPasswordResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ForgotPasswordResponseImpl(
      data: json['data'] as String,
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ForgotPasswordResponseImplToJson(
        _$ForgotPasswordResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$ResetPasswordResponseImpl _$$ResetPasswordResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordResponseImpl(
      data: ResetPasswordData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ResetPasswordResponseImplToJson(
        _$ResetPasswordResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$ResetPasswordDataImpl _$$ResetPasswordDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordDataImpl(
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ResetPasswordDataImplToJson(
        _$ResetPasswordDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$SubscriptionDataImpl _$$SubscriptionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionDataImpl(
      id: json['id'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: (json['type'] as num?)?.toInt(),
      status: json['status'] as String?,
      start_date: json['start_date'] as String?,
      end_date: json['end_date'] as String?,
      old_price: (json['old_price'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SubscriptionDataImplToJson(
        _$SubscriptionDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'type': instance.type,
      'status': instance.status,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'old_price': instance.old_price,
      'price': instance.price,
    };
