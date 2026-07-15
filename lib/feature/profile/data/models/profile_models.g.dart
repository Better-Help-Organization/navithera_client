// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePersonalDetailsRequestImpl _$$UpdatePersonalDetailsRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePersonalDetailsRequestImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$UpdatePersonalDetailsRequestImplToJson(
        _$UpdatePersonalDetailsRequestImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'emergencyContact': instance.emergencyContact,
      'gender': instance.gender,
    };

_$UpdatePersonalDetailsResponseImpl
    _$$UpdatePersonalDetailsResponseImplFromJson(Map<String, dynamic> json) =>
        _$UpdatePersonalDetailsResponseImpl(
          data: UpdatePersonalDetailsData.fromJson(
              json['data'] as Map<String, dynamic>),
          message: json['message'] as String?,
          statusCode: (json['statusCode'] as num?)?.toInt(),
          method: json['method'] as String?,
          path: json['path'] as String?,
          timestamp: json['timestamp'] as String?,
        );

Map<String, dynamic> _$$UpdatePersonalDetailsResponseImplToJson(
        _$UpdatePersonalDetailsResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp,
    };

_$UpdatePersonalDetailsDataImpl _$$UpdatePersonalDetailsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePersonalDetailsDataImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      username: json['username'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UpdatePersonalDetailsDataImplToJson(
        _$UpdatePersonalDetailsDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'username': instance.username,
      'emergencyContact': instance.emergencyContact,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      status: json['status'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      isLinked: json['isLinked'] as bool?,
      username: json['username'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      isVisible: json['isVisible'] as bool?,
      avatar: (json['avatar'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      preference: (json['preference'] as List<dynamic>?)
          ?.map((e) => PreferenceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      answer: (json['answer'] as List<dynamic>?)
          ?.map((e) => UserAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'isLinked': instance.isLinked,
      'username': instance.username,
      'emergencyContact': instance.emergencyContact,
      'isVisible': instance.isVisible,
      'avatar': instance.avatar,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'preference': instance.preference,
      'answer': instance.answer,
    };
