// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  isEmailAuthenticated: json['isEmailAuthenticated'] as bool?,
  status: json['status'] as String?,
  gender: json['gender'] as String?,
  dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
  username: json['username'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  isVisible: json['isVisible'] as bool?,
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  emergencyContact: json['emergencyContact'],
  deletedAt:
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
  isLinked: json['isLinked'] as bool?,
  isPhoneNumberAuthenticated: json['isPhoneNumberAuthenticated'] as bool?,
  preferences:
      (json['preference'] as List<dynamic>?)
          ?.map((e) => PrefData.fromJson(e as Map<String, dynamic>))
          .toList(),
  answers:
      (json['answer'] as List<dynamic>?)
          ?.map((e) => AnsData.fromJson(e as Map<String, dynamic>))
          .toList(),
  subscriptions:
      (json['subscription'] as List<dynamic>?)
          ?.map((e) => SubscriptionData.fromJson(e as Map<String, dynamic>))
          .toList(),
  activeSubscription:
      json['activeSubscription'] == null
          ? null
          : SubscriptionData.fromJson(
            json['activeSubscription'] as Map<String, dynamic>,
          ),
  expertise:
      (json['expertise'] as List<dynamic>?)
          ?.map((e) => ExpertiseData.fromJson(e as Map<String, dynamic>))
          .toList(),
  avatar: (json['avatar'] as num?)?.toInt(),
  profile: json['profile'] as String?,
  hasNotification:
      json['hasNotification'] == null
          ? null
          : NotificationItem.fromJson(
            json['hasNotification'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isEmailAuthenticated': instance.isEmailAuthenticated,
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
      'isPhoneNumberAuthenticated': instance.isPhoneNumberAuthenticated,
      'preference': instance.preferences,
      'answer': instance.answers,
      'subscription': instance.subscriptions,
      'activeSubscription': instance.activeSubscription,
      'expertise': instance.expertise,
      'avatar': instance.avatar,
      'profile': instance.profile,
      'hasNotification': instance.hasNotification,
    };
