// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreferenceRequestImpl _$$PreferenceRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PreferenceRequestImpl(
  modalId: json['modalId'] as String,
  gender: json['gender'] as String,
  languageIds:
      (json['languageIds'] as List<dynamic>).map((e) => e as String).toList(),
  goal: json['goal'] as String?,
  levelId: json['levelId'] as String,
  availability:
      (json['availability'] as List<dynamic>)
          .map((e) => AvailabilitySlot.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$PreferenceRequestImplToJson(
  _$PreferenceRequestImpl instance,
) => <String, dynamic>{
  'modalId': instance.modalId,
  'gender': instance.gender,
  'languageIds': instance.languageIds,
  'goal': instance.goal,
  'levelId': instance.levelId,
  'availability': instance.availability,
};

_$PreferenceRequestWithoutLevelImpl
_$$PreferenceRequestWithoutLevelImplFromJson(Map<String, dynamic> json) =>
    _$PreferenceRequestWithoutLevelImpl(
      modalId: json['modalId'] as String,
      gender: json['gender'] as String,
      languageIds:
          (json['languageIds'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      goal: json['goal'] as String?,
      availability:
          (json['availability'] as List<dynamic>)
              .map((e) => AvailabilitySlot.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PreferenceRequestWithoutLevelImplToJson(
  _$PreferenceRequestWithoutLevelImpl instance,
) => <String, dynamic>{
  'modalId': instance.modalId,
  'gender': instance.gender,
  'languageIds': instance.languageIds,
  'goal': instance.goal,
  'availability': instance.availability,
};

_$PreferenceRequestModalOnlyImpl _$$PreferenceRequestModalOnlyImplFromJson(
  Map<String, dynamic> json,
) => _$PreferenceRequestModalOnlyImpl(modalId: json['modalId'] as String);

Map<String, dynamic> _$$PreferenceRequestModalOnlyImplToJson(
  _$PreferenceRequestModalOnlyImpl instance,
) => <String, dynamic>{'modalId': instance.modalId};

_$AvailabilitySlotImpl _$$AvailabilitySlotImplFromJson(
  Map<String, dynamic> json,
) => _$AvailabilitySlotImpl(
  day: json['day'] as String,
  day_period: json['day_period'] as String,
);

Map<String, dynamic> _$$AvailabilitySlotImplToJson(
  _$AvailabilitySlotImpl instance,
) => <String, dynamic>{'day': instance.day, 'day_period': instance.day_period};

_$PreferenceUpdateRequestImpl _$$PreferenceUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PreferenceUpdateRequestImpl(
  modalId: json['modalId'] as String?,
  gender: json['gender'] as String?,
  languageIds:
      (json['languageIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
  goal: json['goal'] as String?,
  levelId: json['levelId'] as String?,
  availability:
      (json['availability'] as List<dynamic>?)
          ?.map((e) => AvailabilitySlot.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$PreferenceUpdateRequestImplToJson(
  _$PreferenceUpdateRequestImpl instance,
) => <String, dynamic>{
  'modalId': instance.modalId,
  'gender': instance.gender,
  'languageIds': instance.languageIds,
  'goal': instance.goal,
  'levelId': instance.levelId,
  'availability': instance.availability,
};

_$PreferenceUpdateWithoutLevelRequestImpl
_$$PreferenceUpdateWithoutLevelRequestImplFromJson(Map<String, dynamic> json) =>
    _$PreferenceUpdateWithoutLevelRequestImpl(
      modalId: json['modalId'] as String?,
      gender: json['gender'] as String?,
      languageIds:
          (json['languageIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      goal: json['goal'] as String?,
      availability:
          (json['availability'] as List<dynamic>?)
              ?.map((e) => AvailabilitySlot.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$PreferenceUpdateWithoutLevelRequestImplToJson(
  _$PreferenceUpdateWithoutLevelRequestImpl instance,
) => <String, dynamic>{
  'modalId': instance.modalId,
  'gender': instance.gender,
  'languageIds': instance.languageIds,
  'goal': instance.goal,
  'availability': instance.availability,
};

_$PreferenceResponseImpl _$$PreferenceResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PreferenceResponseImpl(
  data: PreferenceData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  method: json['method'] as String?,
  path: json['path'] as String?,
  timestamp: json['timestamp'] as String?,
);

Map<String, dynamic> _$$PreferenceResponseImplToJson(
  _$PreferenceResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp,
};

_$PreferenceGroupResponseImpl _$$PreferenceGroupResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PreferenceGroupResponseImpl(
  message: json['message'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
  method: json['method'] as String?,
  path: json['path'] as String?,
  timestamp: json['timestamp'] as String?,
);

Map<String, dynamic> _$$PreferenceGroupResponseImplToJson(
  _$PreferenceGroupResponseImpl instance,
) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp,
};

_$PreferenceDataImpl _$$PreferenceDataImplFromJson(Map<String, dynamic> json) =>
    _$PreferenceDataImpl(
      gender: json['gender'] as String,
      goal: json['goal'] as String?,
      client:
          json['client'] == null
              ? null
              : Client.fromJson(json['client'] as Map<String, dynamic>),
      modal:
          json['modal'] == null
              ? null
              : Modal.fromJson(json['modal'] as Map<String, dynamic>),
      language:
          (json['language'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList(),
      level:
          json['level'] == null
              ? null
              : Level.fromJson(json['level'] as Map<String, dynamic>),
      availability:
          (json['availability'] as List<dynamic>?)
              ?.map((e) => Availability.fromJson(e as Map<String, dynamic>))
              .toList(),
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$$PreferenceDataImplToJson(
  _$PreferenceDataImpl instance,
) => <String, dynamic>{
  'gender': instance.gender,
  'goal': instance.goal,
  'client': instance.client,
  'modal': instance.modal,
  'language': instance.language,
  'level': instance.level,
  'availability': instance.availability,
  'updatedAt': instance.updatedAt,
  'id': instance.id,
  'createdAt': instance.createdAt,
  'deletedAt': instance.deletedAt,
};

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) =>
    _$ClientImpl(id: json['id'] as String);

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{'id': instance.id};

_$ModalImpl _$$ModalImplFromJson(Map<String, dynamic> json) =>
    _$ModalImpl(id: json['id'] as String);

Map<String, dynamic> _$$ModalImplToJson(_$ModalImpl instance) =>
    <String, dynamic>{'id': instance.id};

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(id: json['id'] as String);

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{'id': instance.id};

_$LevelImpl _$$LevelImplFromJson(Map<String, dynamic> json) =>
    _$LevelImpl(id: json['id'] as String);

Map<String, dynamic> _$$LevelImplToJson(_$LevelImpl instance) =>
    <String, dynamic>{'id': instance.id};

_$AvailabilityImpl _$$AvailabilityImplFromJson(Map<String, dynamic> json) =>
    _$AvailabilityImpl(
      day: json['day'] as String,
      day_period: json['day_period'] as String,
      updatedAt: json['updatedAt'] as String,
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );

Map<String, dynamic> _$$AvailabilityImplToJson(_$AvailabilityImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'day_period': instance.day_period,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
    };

_$MatchRequestImpl _$$MatchRequestImplFromJson(Map<String, dynamic> json) =>
    _$MatchRequestImpl(preferenceId: json['preferenceId'] as String);

Map<String, dynamic> _$$MatchRequestImplToJson(_$MatchRequestImpl instance) =>
    <String, dynamic>{'preferenceId': instance.preferenceId};

_$MatchResponseImpl _$$MatchResponseImplFromJson(Map<String, dynamic> json) =>
    _$MatchResponseImpl(
      data: MatchData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String?,
      path: json['path'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$MatchResponseImplToJson(_$MatchResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'method': instance.method,
      'path': instance.path,
      'timestamp': instance.timestamp,
    };

_$MatchDataImpl _$$MatchDataImplFromJson(Map<String, dynamic> json) =>
    _$MatchDataImpl(message: json['message'] as String);

Map<String, dynamic> _$$MatchDataImplToJson(_$MatchDataImpl instance) =>
    <String, dynamic>{'message': instance.message};
