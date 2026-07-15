// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preference_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreferenceRequest _$PreferenceRequestFromJson(Map<String, dynamic> json) {
  return _PreferenceRequest.fromJson(json);
}

/// @nodoc
mixin _$PreferenceRequest {
  String get modalId => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  List<String> get languageIds => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  String get levelId => throw _privateConstructorUsedError;
  List<AvailabilitySlot> get availability => throw _privateConstructorUsedError;
  String? get otherLang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceRequestCopyWith<PreferenceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceRequestCopyWith<$Res> {
  factory $PreferenceRequestCopyWith(
          PreferenceRequest value, $Res Function(PreferenceRequest) then) =
      _$PreferenceRequestCopyWithImpl<$Res, PreferenceRequest>;
  @useResult
  $Res call(
      {String modalId,
      String gender,
      List<String> languageIds,
      String? goal,
      String levelId,
      List<AvailabilitySlot> availability,
      String? otherLang});
}

/// @nodoc
class _$PreferenceRequestCopyWithImpl<$Res, $Val extends PreferenceRequest>
    implements $PreferenceRequestCopyWith<$Res> {
  _$PreferenceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? gender = null,
    Object? languageIds = null,
    Object? goal = freezed,
    Object? levelId = null,
    Object? availability = null,
    Object? otherLang = freezed,
  }) {
    return _then(_value.copyWith(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      languageIds: null == languageIds
          ? _value.languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      levelId: null == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceRequestImplCopyWith<$Res>
    implements $PreferenceRequestCopyWith<$Res> {
  factory _$$PreferenceRequestImplCopyWith(_$PreferenceRequestImpl value,
          $Res Function(_$PreferenceRequestImpl) then) =
      __$$PreferenceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modalId,
      String gender,
      List<String> languageIds,
      String? goal,
      String levelId,
      List<AvailabilitySlot> availability,
      String? otherLang});
}

/// @nodoc
class __$$PreferenceRequestImplCopyWithImpl<$Res>
    extends _$PreferenceRequestCopyWithImpl<$Res, _$PreferenceRequestImpl>
    implements _$$PreferenceRequestImplCopyWith<$Res> {
  __$$PreferenceRequestImplCopyWithImpl(_$PreferenceRequestImpl _value,
      $Res Function(_$PreferenceRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? gender = null,
    Object? languageIds = null,
    Object? goal = freezed,
    Object? levelId = null,
    Object? availability = null,
    Object? otherLang = freezed,
  }) {
    return _then(_$PreferenceRequestImpl(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      languageIds: null == languageIds
          ? _value._languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      levelId: null == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String,
      availability: null == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceRequestImpl implements _PreferenceRequest {
  const _$PreferenceRequestImpl(
      {required this.modalId,
      required this.gender,
      required final List<String> languageIds,
      this.goal,
      required this.levelId,
      required final List<AvailabilitySlot> availability,
      this.otherLang})
      : _languageIds = languageIds,
        _availability = availability;

  factory _$PreferenceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceRequestImplFromJson(json);

  @override
  final String modalId;
  @override
  final String gender;
  final List<String> _languageIds;
  @override
  List<String> get languageIds {
    if (_languageIds is EqualUnmodifiableListView) return _languageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languageIds);
  }

  @override
  final String? goal;
  @override
  final String levelId;
  final List<AvailabilitySlot> _availability;
  @override
  List<AvailabilitySlot> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  @override
  final String? otherLang;

  @override
  String toString() {
    return 'PreferenceRequest(modalId: $modalId, gender: $gender, languageIds: $languageIds, goal: $goal, levelId: $levelId, availability: $availability, otherLang: $otherLang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceRequestImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._languageIds, _languageIds) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.otherLang, otherLang) ||
                other.otherLang == otherLang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      modalId,
      gender,
      const DeepCollectionEquality().hash(_languageIds),
      goal,
      levelId,
      const DeepCollectionEquality().hash(_availability),
      otherLang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceRequestImplCopyWith<_$PreferenceRequestImpl> get copyWith =>
      __$$PreferenceRequestImplCopyWithImpl<_$PreferenceRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceRequestImplToJson(
      this,
    );
  }
}

abstract class _PreferenceRequest implements PreferenceRequest {
  const factory _PreferenceRequest(
      {required final String modalId,
      required final String gender,
      required final List<String> languageIds,
      final String? goal,
      required final String levelId,
      required final List<AvailabilitySlot> availability,
      final String? otherLang}) = _$PreferenceRequestImpl;

  factory _PreferenceRequest.fromJson(Map<String, dynamic> json) =
      _$PreferenceRequestImpl.fromJson;

  @override
  String get modalId;
  @override
  String get gender;
  @override
  List<String> get languageIds;
  @override
  String? get goal;
  @override
  String get levelId;
  @override
  List<AvailabilitySlot> get availability;
  @override
  String? get otherLang;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceRequestImplCopyWith<_$PreferenceRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreferenceRequestWithoutLevel _$PreferenceRequestWithoutLevelFromJson(
    Map<String, dynamic> json) {
  return _PreferenceRequestWithoutLevel.fromJson(json);
}

/// @nodoc
mixin _$PreferenceRequestWithoutLevel {
  String get modalId => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  List<String> get languageIds => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  List<AvailabilitySlot> get availability => throw _privateConstructorUsedError;
  String? get otherLang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceRequestWithoutLevelCopyWith<PreferenceRequestWithoutLevel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceRequestWithoutLevelCopyWith<$Res> {
  factory $PreferenceRequestWithoutLevelCopyWith(
          PreferenceRequestWithoutLevel value,
          $Res Function(PreferenceRequestWithoutLevel) then) =
      _$PreferenceRequestWithoutLevelCopyWithImpl<$Res,
          PreferenceRequestWithoutLevel>;
  @useResult
  $Res call(
      {String modalId,
      String gender,
      List<String> languageIds,
      String? goal,
      List<AvailabilitySlot> availability,
      String? otherLang});
}

/// @nodoc
class _$PreferenceRequestWithoutLevelCopyWithImpl<$Res,
        $Val extends PreferenceRequestWithoutLevel>
    implements $PreferenceRequestWithoutLevelCopyWith<$Res> {
  _$PreferenceRequestWithoutLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? gender = null,
    Object? languageIds = null,
    Object? goal = freezed,
    Object? availability = null,
    Object? otherLang = freezed,
  }) {
    return _then(_value.copyWith(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      languageIds: null == languageIds
          ? _value.languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceRequestWithoutLevelImplCopyWith<$Res>
    implements $PreferenceRequestWithoutLevelCopyWith<$Res> {
  factory _$$PreferenceRequestWithoutLevelImplCopyWith(
          _$PreferenceRequestWithoutLevelImpl value,
          $Res Function(_$PreferenceRequestWithoutLevelImpl) then) =
      __$$PreferenceRequestWithoutLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modalId,
      String gender,
      List<String> languageIds,
      String? goal,
      List<AvailabilitySlot> availability,
      String? otherLang});
}

/// @nodoc
class __$$PreferenceRequestWithoutLevelImplCopyWithImpl<$Res>
    extends _$PreferenceRequestWithoutLevelCopyWithImpl<$Res,
        _$PreferenceRequestWithoutLevelImpl>
    implements _$$PreferenceRequestWithoutLevelImplCopyWith<$Res> {
  __$$PreferenceRequestWithoutLevelImplCopyWithImpl(
      _$PreferenceRequestWithoutLevelImpl _value,
      $Res Function(_$PreferenceRequestWithoutLevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? gender = null,
    Object? languageIds = null,
    Object? goal = freezed,
    Object? availability = null,
    Object? otherLang = freezed,
  }) {
    return _then(_$PreferenceRequestWithoutLevelImpl(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      languageIds: null == languageIds
          ? _value._languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: null == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceRequestWithoutLevelImpl
    implements _PreferenceRequestWithoutLevel {
  const _$PreferenceRequestWithoutLevelImpl(
      {required this.modalId,
      required this.gender,
      required final List<String> languageIds,
      this.goal,
      required final List<AvailabilitySlot> availability,
      this.otherLang})
      : _languageIds = languageIds,
        _availability = availability;

  factory _$PreferenceRequestWithoutLevelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreferenceRequestWithoutLevelImplFromJson(json);

  @override
  final String modalId;
  @override
  final String gender;
  final List<String> _languageIds;
  @override
  List<String> get languageIds {
    if (_languageIds is EqualUnmodifiableListView) return _languageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languageIds);
  }

  @override
  final String? goal;
  final List<AvailabilitySlot> _availability;
  @override
  List<AvailabilitySlot> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  @override
  final String? otherLang;

  @override
  String toString() {
    return 'PreferenceRequestWithoutLevel(modalId: $modalId, gender: $gender, languageIds: $languageIds, goal: $goal, availability: $availability, otherLang: $otherLang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceRequestWithoutLevelImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._languageIds, _languageIds) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.otherLang, otherLang) ||
                other.otherLang == otherLang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      modalId,
      gender,
      const DeepCollectionEquality().hash(_languageIds),
      goal,
      const DeepCollectionEquality().hash(_availability),
      otherLang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceRequestWithoutLevelImplCopyWith<
          _$PreferenceRequestWithoutLevelImpl>
      get copyWith => __$$PreferenceRequestWithoutLevelImplCopyWithImpl<
          _$PreferenceRequestWithoutLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceRequestWithoutLevelImplToJson(
      this,
    );
  }
}

abstract class _PreferenceRequestWithoutLevel
    implements PreferenceRequestWithoutLevel {
  const factory _PreferenceRequestWithoutLevel(
      {required final String modalId,
      required final String gender,
      required final List<String> languageIds,
      final String? goal,
      required final List<AvailabilitySlot> availability,
      final String? otherLang}) = _$PreferenceRequestWithoutLevelImpl;

  factory _PreferenceRequestWithoutLevel.fromJson(Map<String, dynamic> json) =
      _$PreferenceRequestWithoutLevelImpl.fromJson;

  @override
  String get modalId;
  @override
  String get gender;
  @override
  List<String> get languageIds;
  @override
  String? get goal;
  @override
  List<AvailabilitySlot> get availability;
  @override
  String? get otherLang;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceRequestWithoutLevelImplCopyWith<
          _$PreferenceRequestWithoutLevelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PreferenceRequestModalOnly _$PreferenceRequestModalOnlyFromJson(
    Map<String, dynamic> json) {
  return _PreferenceRequestModalOnly.fromJson(json);
}

/// @nodoc
mixin _$PreferenceRequestModalOnly {
  String get modalId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceRequestModalOnlyCopyWith<PreferenceRequestModalOnly>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceRequestModalOnlyCopyWith<$Res> {
  factory $PreferenceRequestModalOnlyCopyWith(PreferenceRequestModalOnly value,
          $Res Function(PreferenceRequestModalOnly) then) =
      _$PreferenceRequestModalOnlyCopyWithImpl<$Res,
          PreferenceRequestModalOnly>;
  @useResult
  $Res call({String modalId});
}

/// @nodoc
class _$PreferenceRequestModalOnlyCopyWithImpl<$Res,
        $Val extends PreferenceRequestModalOnly>
    implements $PreferenceRequestModalOnlyCopyWith<$Res> {
  _$PreferenceRequestModalOnlyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
  }) {
    return _then(_value.copyWith(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceRequestModalOnlyImplCopyWith<$Res>
    implements $PreferenceRequestModalOnlyCopyWith<$Res> {
  factory _$$PreferenceRequestModalOnlyImplCopyWith(
          _$PreferenceRequestModalOnlyImpl value,
          $Res Function(_$PreferenceRequestModalOnlyImpl) then) =
      __$$PreferenceRequestModalOnlyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String modalId});
}

/// @nodoc
class __$$PreferenceRequestModalOnlyImplCopyWithImpl<$Res>
    extends _$PreferenceRequestModalOnlyCopyWithImpl<$Res,
        _$PreferenceRequestModalOnlyImpl>
    implements _$$PreferenceRequestModalOnlyImplCopyWith<$Res> {
  __$$PreferenceRequestModalOnlyImplCopyWithImpl(
      _$PreferenceRequestModalOnlyImpl _value,
      $Res Function(_$PreferenceRequestModalOnlyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
  }) {
    return _then(_$PreferenceRequestModalOnlyImpl(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceRequestModalOnlyImpl implements _PreferenceRequestModalOnly {
  const _$PreferenceRequestModalOnlyImpl({required this.modalId});

  factory _$PreferenceRequestModalOnlyImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreferenceRequestModalOnlyImplFromJson(json);

  @override
  final String modalId;

  @override
  String toString() {
    return 'PreferenceRequestModalOnly(modalId: $modalId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceRequestModalOnlyImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, modalId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceRequestModalOnlyImplCopyWith<_$PreferenceRequestModalOnlyImpl>
      get copyWith => __$$PreferenceRequestModalOnlyImplCopyWithImpl<
          _$PreferenceRequestModalOnlyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceRequestModalOnlyImplToJson(
      this,
    );
  }
}

abstract class _PreferenceRequestModalOnly
    implements PreferenceRequestModalOnly {
  const factory _PreferenceRequestModalOnly({required final String modalId}) =
      _$PreferenceRequestModalOnlyImpl;

  factory _PreferenceRequestModalOnly.fromJson(Map<String, dynamic> json) =
      _$PreferenceRequestModalOnlyImpl.fromJson;

  @override
  String get modalId;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceRequestModalOnlyImplCopyWith<_$PreferenceRequestModalOnlyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AvailabilitySlot _$AvailabilitySlotFromJson(Map<String, dynamic> json) {
  return _AvailabilitySlot.fromJson(json);
}

/// @nodoc
mixin _$AvailabilitySlot {
  String get day => throw _privateConstructorUsedError;
  String get day_period => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvailabilitySlotCopyWith<AvailabilitySlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilitySlotCopyWith<$Res> {
  factory $AvailabilitySlotCopyWith(
          AvailabilitySlot value, $Res Function(AvailabilitySlot) then) =
      _$AvailabilitySlotCopyWithImpl<$Res, AvailabilitySlot>;
  @useResult
  $Res call({String day, String day_period});
}

/// @nodoc
class _$AvailabilitySlotCopyWithImpl<$Res, $Val extends AvailabilitySlot>
    implements $AvailabilitySlotCopyWith<$Res> {
  _$AvailabilitySlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? day_period = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      day_period: null == day_period
          ? _value.day_period
          : day_period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvailabilitySlotImplCopyWith<$Res>
    implements $AvailabilitySlotCopyWith<$Res> {
  factory _$$AvailabilitySlotImplCopyWith(_$AvailabilitySlotImpl value,
          $Res Function(_$AvailabilitySlotImpl) then) =
      __$$AvailabilitySlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, String day_period});
}

/// @nodoc
class __$$AvailabilitySlotImplCopyWithImpl<$Res>
    extends _$AvailabilitySlotCopyWithImpl<$Res, _$AvailabilitySlotImpl>
    implements _$$AvailabilitySlotImplCopyWith<$Res> {
  __$$AvailabilitySlotImplCopyWithImpl(_$AvailabilitySlotImpl _value,
      $Res Function(_$AvailabilitySlotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? day_period = null,
  }) {
    return _then(_$AvailabilitySlotImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      day_period: null == day_period
          ? _value.day_period
          : day_period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailabilitySlotImpl implements _AvailabilitySlot {
  const _$AvailabilitySlotImpl({required this.day, required this.day_period});

  factory _$AvailabilitySlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailabilitySlotImplFromJson(json);

  @override
  final String day;
  @override
  final String day_period;

  @override
  String toString() {
    return 'AvailabilitySlot(day: $day, day_period: $day_period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailabilitySlotImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.day_period, day_period) ||
                other.day_period == day_period));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, day_period);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailabilitySlotImplCopyWith<_$AvailabilitySlotImpl> get copyWith =>
      __$$AvailabilitySlotImplCopyWithImpl<_$AvailabilitySlotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailabilitySlotImplToJson(
      this,
    );
  }
}

abstract class _AvailabilitySlot implements AvailabilitySlot {
  const factory _AvailabilitySlot(
      {required final String day,
      required final String day_period}) = _$AvailabilitySlotImpl;

  factory _AvailabilitySlot.fromJson(Map<String, dynamic> json) =
      _$AvailabilitySlotImpl.fromJson;

  @override
  String get day;
  @override
  String get day_period;
  @override
  @JsonKey(ignore: true)
  _$$AvailabilitySlotImplCopyWith<_$AvailabilitySlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreferenceUpdateRequest _$PreferenceUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return _PreferenceUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$PreferenceUpdateRequest {
  String? get modalId => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<String>? get languageIds => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  String? get levelId => throw _privateConstructorUsedError;
  List<AvailabilitySlot>? get availability =>
      throw _privateConstructorUsedError;
  String? get otherLang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceUpdateRequestCopyWith<PreferenceUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceUpdateRequestCopyWith<$Res> {
  factory $PreferenceUpdateRequestCopyWith(PreferenceUpdateRequest value,
          $Res Function(PreferenceUpdateRequest) then) =
      _$PreferenceUpdateRequestCopyWithImpl<$Res, PreferenceUpdateRequest>;
  @useResult
  $Res call(
      {String? modalId,
      String? gender,
      List<String>? languageIds,
      String? goal,
      String? levelId,
      List<AvailabilitySlot>? availability,
      String? otherLang});
}

/// @nodoc
class _$PreferenceUpdateRequestCopyWithImpl<$Res,
        $Val extends PreferenceUpdateRequest>
    implements $PreferenceUpdateRequestCopyWith<$Res> {
  _$PreferenceUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = freezed,
    Object? gender = freezed,
    Object? languageIds = freezed,
    Object? goal = freezed,
    Object? levelId = freezed,
    Object? availability = freezed,
    Object? otherLang = freezed,
  }) {
    return _then(_value.copyWith(
      modalId: freezed == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      languageIds: freezed == languageIds
          ? _value.languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>?,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceUpdateRequestImplCopyWith<$Res>
    implements $PreferenceUpdateRequestCopyWith<$Res> {
  factory _$$PreferenceUpdateRequestImplCopyWith(
          _$PreferenceUpdateRequestImpl value,
          $Res Function(_$PreferenceUpdateRequestImpl) then) =
      __$$PreferenceUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? modalId,
      String? gender,
      List<String>? languageIds,
      String? goal,
      String? levelId,
      List<AvailabilitySlot>? availability,
      String? otherLang});
}

/// @nodoc
class __$$PreferenceUpdateRequestImplCopyWithImpl<$Res>
    extends _$PreferenceUpdateRequestCopyWithImpl<$Res,
        _$PreferenceUpdateRequestImpl>
    implements _$$PreferenceUpdateRequestImplCopyWith<$Res> {
  __$$PreferenceUpdateRequestImplCopyWithImpl(
      _$PreferenceUpdateRequestImpl _value,
      $Res Function(_$PreferenceUpdateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = freezed,
    Object? gender = freezed,
    Object? languageIds = freezed,
    Object? goal = freezed,
    Object? levelId = freezed,
    Object? availability = freezed,
    Object? otherLang = freezed,
  }) {
    return _then(_$PreferenceUpdateRequestImpl(
      modalId: freezed == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      languageIds: freezed == languageIds
          ? _value._languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>?,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceUpdateRequestImpl implements _PreferenceUpdateRequest {
  const _$PreferenceUpdateRequestImpl(
      {this.modalId,
      this.gender,
      final List<String>? languageIds,
      this.goal,
      this.levelId,
      final List<AvailabilitySlot>? availability,
      this.otherLang})
      : _languageIds = languageIds,
        _availability = availability;

  factory _$PreferenceUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceUpdateRequestImplFromJson(json);

  @override
  final String? modalId;
  @override
  final String? gender;
  final List<String>? _languageIds;
  @override
  List<String>? get languageIds {
    final value = _languageIds;
    if (value == null) return null;
    if (_languageIds is EqualUnmodifiableListView) return _languageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? goal;
  @override
  final String? levelId;
  final List<AvailabilitySlot>? _availability;
  @override
  List<AvailabilitySlot>? get availability {
    final value = _availability;
    if (value == null) return null;
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? otherLang;

  @override
  String toString() {
    return 'PreferenceUpdateRequest(modalId: $modalId, gender: $gender, languageIds: $languageIds, goal: $goal, levelId: $levelId, availability: $availability, otherLang: $otherLang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceUpdateRequestImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._languageIds, _languageIds) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.otherLang, otherLang) ||
                other.otherLang == otherLang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      modalId,
      gender,
      const DeepCollectionEquality().hash(_languageIds),
      goal,
      levelId,
      const DeepCollectionEquality().hash(_availability),
      otherLang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceUpdateRequestImplCopyWith<_$PreferenceUpdateRequestImpl>
      get copyWith => __$$PreferenceUpdateRequestImplCopyWithImpl<
          _$PreferenceUpdateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _PreferenceUpdateRequest implements PreferenceUpdateRequest {
  const factory _PreferenceUpdateRequest(
      {final String? modalId,
      final String? gender,
      final List<String>? languageIds,
      final String? goal,
      final String? levelId,
      final List<AvailabilitySlot>? availability,
      final String? otherLang}) = _$PreferenceUpdateRequestImpl;

  factory _PreferenceUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$PreferenceUpdateRequestImpl.fromJson;

  @override
  String? get modalId;
  @override
  String? get gender;
  @override
  List<String>? get languageIds;
  @override
  String? get goal;
  @override
  String? get levelId;
  @override
  List<AvailabilitySlot>? get availability;
  @override
  String? get otherLang;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceUpdateRequestImplCopyWith<_$PreferenceUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PreferenceUpdateWithoutLevelRequest
    _$PreferenceUpdateWithoutLevelRequestFromJson(Map<String, dynamic> json) {
  return _PreferenceUpdateWithoutLevelRequest.fromJson(json);
}

/// @nodoc
mixin _$PreferenceUpdateWithoutLevelRequest {
  String? get modalId => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  List<String>? get languageIds => throw _privateConstructorUsedError;
  String? get goal => throw _privateConstructorUsedError;
  List<AvailabilitySlot>? get availability =>
      throw _privateConstructorUsedError;
  String? get otherLang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceUpdateWithoutLevelRequestCopyWith<
          PreferenceUpdateWithoutLevelRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceUpdateWithoutLevelRequestCopyWith<$Res> {
  factory $PreferenceUpdateWithoutLevelRequestCopyWith(
          PreferenceUpdateWithoutLevelRequest value,
          $Res Function(PreferenceUpdateWithoutLevelRequest) then) =
      _$PreferenceUpdateWithoutLevelRequestCopyWithImpl<$Res,
          PreferenceUpdateWithoutLevelRequest>;
  @useResult
  $Res call(
      {String? modalId,
      String? gender,
      List<String>? languageIds,
      String? goal,
      List<AvailabilitySlot>? availability,
      String? otherLang});
}

/// @nodoc
class _$PreferenceUpdateWithoutLevelRequestCopyWithImpl<$Res,
        $Val extends PreferenceUpdateWithoutLevelRequest>
    implements $PreferenceUpdateWithoutLevelRequestCopyWith<$Res> {
  _$PreferenceUpdateWithoutLevelRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = freezed,
    Object? gender = freezed,
    Object? languageIds = freezed,
    Object? goal = freezed,
    Object? availability = freezed,
    Object? otherLang = freezed,
  }) {
    return _then(_value.copyWith(
      modalId: freezed == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      languageIds: freezed == languageIds
          ? _value.languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>?,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceUpdateWithoutLevelRequestImplCopyWith<$Res>
    implements $PreferenceUpdateWithoutLevelRequestCopyWith<$Res> {
  factory _$$PreferenceUpdateWithoutLevelRequestImplCopyWith(
          _$PreferenceUpdateWithoutLevelRequestImpl value,
          $Res Function(_$PreferenceUpdateWithoutLevelRequestImpl) then) =
      __$$PreferenceUpdateWithoutLevelRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? modalId,
      String? gender,
      List<String>? languageIds,
      String? goal,
      List<AvailabilitySlot>? availability,
      String? otherLang});
}

/// @nodoc
class __$$PreferenceUpdateWithoutLevelRequestImplCopyWithImpl<$Res>
    extends _$PreferenceUpdateWithoutLevelRequestCopyWithImpl<$Res,
        _$PreferenceUpdateWithoutLevelRequestImpl>
    implements _$$PreferenceUpdateWithoutLevelRequestImplCopyWith<$Res> {
  __$$PreferenceUpdateWithoutLevelRequestImplCopyWithImpl(
      _$PreferenceUpdateWithoutLevelRequestImpl _value,
      $Res Function(_$PreferenceUpdateWithoutLevelRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = freezed,
    Object? gender = freezed,
    Object? languageIds = freezed,
    Object? goal = freezed,
    Object? availability = freezed,
    Object? otherLang = freezed,
  }) {
    return _then(_$PreferenceUpdateWithoutLevelRequestImpl(
      modalId: freezed == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      languageIds: freezed == languageIds
          ? _value._languageIds
          : languageIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<AvailabilitySlot>?,
      otherLang: freezed == otherLang
          ? _value.otherLang
          : otherLang // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceUpdateWithoutLevelRequestImpl
    implements _PreferenceUpdateWithoutLevelRequest {
  const _$PreferenceUpdateWithoutLevelRequestImpl(
      {this.modalId,
      this.gender,
      final List<String>? languageIds,
      this.goal,
      final List<AvailabilitySlot>? availability,
      this.otherLang})
      : _languageIds = languageIds,
        _availability = availability;

  factory _$PreferenceUpdateWithoutLevelRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreferenceUpdateWithoutLevelRequestImplFromJson(json);

  @override
  final String? modalId;
  @override
  final String? gender;
  final List<String>? _languageIds;
  @override
  List<String>? get languageIds {
    final value = _languageIds;
    if (value == null) return null;
    if (_languageIds is EqualUnmodifiableListView) return _languageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? goal;
  final List<AvailabilitySlot>? _availability;
  @override
  List<AvailabilitySlot>? get availability {
    final value = _availability;
    if (value == null) return null;
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? otherLang;

  @override
  String toString() {
    return 'PreferenceUpdateWithoutLevelRequest(modalId: $modalId, gender: $gender, languageIds: $languageIds, goal: $goal, availability: $availability, otherLang: $otherLang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceUpdateWithoutLevelRequestImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._languageIds, _languageIds) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.otherLang, otherLang) ||
                other.otherLang == otherLang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      modalId,
      gender,
      const DeepCollectionEquality().hash(_languageIds),
      goal,
      const DeepCollectionEquality().hash(_availability),
      otherLang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceUpdateWithoutLevelRequestImplCopyWith<
          _$PreferenceUpdateWithoutLevelRequestImpl>
      get copyWith => __$$PreferenceUpdateWithoutLevelRequestImplCopyWithImpl<
          _$PreferenceUpdateWithoutLevelRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceUpdateWithoutLevelRequestImplToJson(
      this,
    );
  }
}

abstract class _PreferenceUpdateWithoutLevelRequest
    implements PreferenceUpdateWithoutLevelRequest {
  const factory _PreferenceUpdateWithoutLevelRequest(
      {final String? modalId,
      final String? gender,
      final List<String>? languageIds,
      final String? goal,
      final List<AvailabilitySlot>? availability,
      final String? otherLang}) = _$PreferenceUpdateWithoutLevelRequestImpl;

  factory _PreferenceUpdateWithoutLevelRequest.fromJson(
          Map<String, dynamic> json) =
      _$PreferenceUpdateWithoutLevelRequestImpl.fromJson;

  @override
  String? get modalId;
  @override
  String? get gender;
  @override
  List<String>? get languageIds;
  @override
  String? get goal;
  @override
  List<AvailabilitySlot>? get availability;
  @override
  String? get otherLang;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceUpdateWithoutLevelRequestImplCopyWith<
          _$PreferenceUpdateWithoutLevelRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PreferenceResponse _$PreferenceResponseFromJson(Map<String, dynamic> json) {
  return _PreferenceResponse.fromJson(json);
}

/// @nodoc
mixin _$PreferenceResponse {
  PreferenceData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceResponseCopyWith<PreferenceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceResponseCopyWith<$Res> {
  factory $PreferenceResponseCopyWith(
          PreferenceResponse value, $Res Function(PreferenceResponse) then) =
      _$PreferenceResponseCopyWithImpl<$Res, PreferenceResponse>;
  @useResult
  $Res call(
      {PreferenceData data,
      String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});

  $PreferenceDataCopyWith<$Res> get data;
}

/// @nodoc
class _$PreferenceResponseCopyWithImpl<$Res, $Val extends PreferenceResponse>
    implements $PreferenceResponseCopyWith<$Res> {
  _$PreferenceResponseCopyWithImpl(this._value, this._then);

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
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PreferenceData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
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
  $PreferenceDataCopyWith<$Res> get data {
    return $PreferenceDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PreferenceResponseImplCopyWith<$Res>
    implements $PreferenceResponseCopyWith<$Res> {
  factory _$$PreferenceResponseImplCopyWith(_$PreferenceResponseImpl value,
          $Res Function(_$PreferenceResponseImpl) then) =
      __$$PreferenceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PreferenceData data,
      String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});

  @override
  $PreferenceDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$PreferenceResponseImplCopyWithImpl<$Res>
    extends _$PreferenceResponseCopyWithImpl<$Res, _$PreferenceResponseImpl>
    implements _$$PreferenceResponseImplCopyWith<$Res> {
  __$$PreferenceResponseImplCopyWithImpl(_$PreferenceResponseImpl _value,
      $Res Function(_$PreferenceResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$PreferenceResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PreferenceData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$PreferenceResponseImpl implements _PreferenceResponse {
  const _$PreferenceResponseImpl(
      {required this.data,
      required this.message,
      required this.statusCode,
      this.method,
      this.path,
      this.timestamp});

  factory _$PreferenceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceResponseImplFromJson(json);

  @override
  final PreferenceData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'PreferenceResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceResponseImpl &&
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
  _$$PreferenceResponseImplCopyWith<_$PreferenceResponseImpl> get copyWith =>
      __$$PreferenceResponseImplCopyWithImpl<_$PreferenceResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceResponseImplToJson(
      this,
    );
  }
}

abstract class _PreferenceResponse implements PreferenceResponse {
  const factory _PreferenceResponse(
      {required final PreferenceData data,
      required final String message,
      required final int statusCode,
      final String? method,
      final String? path,
      final String? timestamp}) = _$PreferenceResponseImpl;

  factory _PreferenceResponse.fromJson(Map<String, dynamic> json) =
      _$PreferenceResponseImpl.fromJson;

  @override
  PreferenceData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceResponseImplCopyWith<_$PreferenceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreferenceGroupResponse _$PreferenceGroupResponseFromJson(
    Map<String, dynamic> json) {
  return _PreferenceGroupResponse.fromJson(json);
}

/// @nodoc
mixin _$PreferenceGroupResponse {
// required PreferenceData data,
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceGroupResponseCopyWith<PreferenceGroupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceGroupResponseCopyWith<$Res> {
  factory $PreferenceGroupResponseCopyWith(PreferenceGroupResponse value,
          $Res Function(PreferenceGroupResponse) then) =
      _$PreferenceGroupResponseCopyWithImpl<$Res, PreferenceGroupResponse>;
  @useResult
  $Res call(
      {String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});
}

/// @nodoc
class _$PreferenceGroupResponseCopyWithImpl<$Res,
        $Val extends PreferenceGroupResponse>
    implements $PreferenceGroupResponseCopyWith<$Res> {
  _$PreferenceGroupResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
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
}

/// @nodoc
abstract class _$$PreferenceGroupResponseImplCopyWith<$Res>
    implements $PreferenceGroupResponseCopyWith<$Res> {
  factory _$$PreferenceGroupResponseImplCopyWith(
          _$PreferenceGroupResponseImpl value,
          $Res Function(_$PreferenceGroupResponseImpl) then) =
      __$$PreferenceGroupResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});
}

/// @nodoc
class __$$PreferenceGroupResponseImplCopyWithImpl<$Res>
    extends _$PreferenceGroupResponseCopyWithImpl<$Res,
        _$PreferenceGroupResponseImpl>
    implements _$$PreferenceGroupResponseImplCopyWith<$Res> {
  __$$PreferenceGroupResponseImplCopyWithImpl(
      _$PreferenceGroupResponseImpl _value,
      $Res Function(_$PreferenceGroupResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$PreferenceGroupResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$PreferenceGroupResponseImpl implements _PreferenceGroupResponse {
  const _$PreferenceGroupResponseImpl(
      {required this.message,
      required this.statusCode,
      this.method,
      this.path,
      this.timestamp});

  factory _$PreferenceGroupResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceGroupResponseImplFromJson(json);

// required PreferenceData data,
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'PreferenceGroupResponse(message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceGroupResponseImpl &&
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
  _$$PreferenceGroupResponseImplCopyWith<_$PreferenceGroupResponseImpl>
      get copyWith => __$$PreferenceGroupResponseImplCopyWithImpl<
          _$PreferenceGroupResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceGroupResponseImplToJson(
      this,
    );
  }
}

abstract class _PreferenceGroupResponse implements PreferenceGroupResponse {
  const factory _PreferenceGroupResponse(
      {required final String message,
      required final int statusCode,
      final String? method,
      final String? path,
      final String? timestamp}) = _$PreferenceGroupResponseImpl;

  factory _PreferenceGroupResponse.fromJson(Map<String, dynamic> json) =
      _$PreferenceGroupResponseImpl.fromJson;

  @override // required PreferenceData data,
  String get message;
  @override
  int get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceGroupResponseImplCopyWith<_$PreferenceGroupResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PreferenceData _$PreferenceDataFromJson(Map<String, dynamic> json) {
  return _PreferenceData.fromJson(json);
}

/// @nodoc
mixin _$PreferenceData {
  String get gender =>
      throw _privateConstructorUsedError; // required String sessionFormat,
  String? get goal => throw _privateConstructorUsedError;
  Client? get client => throw _privateConstructorUsedError;
  Modal? get modal => throw _privateConstructorUsedError;
  List<Language>? get language => throw _privateConstructorUsedError;
  Level? get level => throw _privateConstructorUsedError;
  List<Availability>? get availability => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferenceDataCopyWith<PreferenceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceDataCopyWith<$Res> {
  factory $PreferenceDataCopyWith(
          PreferenceData value, $Res Function(PreferenceData) then) =
      _$PreferenceDataCopyWithImpl<$Res, PreferenceData>;
  @useResult
  $Res call(
      {String gender,
      String? goal,
      Client? client,
      Modal? modal,
      List<Language>? language,
      Level? level,
      List<Availability>? availability,
      String? updatedAt,
      String? id,
      String createdAt,
      String? deletedAt});

  $ClientCopyWith<$Res>? get client;
  $ModalCopyWith<$Res>? get modal;
  $LevelCopyWith<$Res>? get level;
}

/// @nodoc
class _$PreferenceDataCopyWithImpl<$Res, $Val extends PreferenceData>
    implements $PreferenceDataCopyWith<$Res> {
  _$PreferenceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = null,
    Object? goal = freezed,
    Object? client = freezed,
    Object? modal = freezed,
    Object? language = freezed,
    Object? level = freezed,
    Object? availability = freezed,
    Object? updatedAt = freezed,
    Object? id = freezed,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
      modal: freezed == modal
          ? _value.modal
          : modal // ignore: cast_nullable_to_non_nullable
              as Modal?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as List<Language>?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $ClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ModalCopyWith<$Res>? get modal {
    if (_value.modal == null) {
      return null;
    }

    return $ModalCopyWith<$Res>(_value.modal!, (value) {
      return _then(_value.copyWith(modal: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LevelCopyWith<$Res>? get level {
    if (_value.level == null) {
      return null;
    }

    return $LevelCopyWith<$Res>(_value.level!, (value) {
      return _then(_value.copyWith(level: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PreferenceDataImplCopyWith<$Res>
    implements $PreferenceDataCopyWith<$Res> {
  factory _$$PreferenceDataImplCopyWith(_$PreferenceDataImpl value,
          $Res Function(_$PreferenceDataImpl) then) =
      __$$PreferenceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gender,
      String? goal,
      Client? client,
      Modal? modal,
      List<Language>? language,
      Level? level,
      List<Availability>? availability,
      String? updatedAt,
      String? id,
      String createdAt,
      String? deletedAt});

  @override
  $ClientCopyWith<$Res>? get client;
  @override
  $ModalCopyWith<$Res>? get modal;
  @override
  $LevelCopyWith<$Res>? get level;
}

/// @nodoc
class __$$PreferenceDataImplCopyWithImpl<$Res>
    extends _$PreferenceDataCopyWithImpl<$Res, _$PreferenceDataImpl>
    implements _$$PreferenceDataImplCopyWith<$Res> {
  __$$PreferenceDataImplCopyWithImpl(
      _$PreferenceDataImpl _value, $Res Function(_$PreferenceDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gender = null,
    Object? goal = freezed,
    Object? client = freezed,
    Object? modal = freezed,
    Object? language = freezed,
    Object? level = freezed,
    Object? availability = freezed,
    Object? updatedAt = freezed,
    Object? id = freezed,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$PreferenceDataImpl(
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      goal: freezed == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
      modal: freezed == modal
          ? _value.modal
          : modal // ignore: cast_nullable_to_non_nullable
              as Modal?,
      language: freezed == language
          ? _value._language
          : language // ignore: cast_nullable_to_non_nullable
              as List<Language>?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Level?,
      availability: freezed == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<Availability>?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceDataImpl implements _PreferenceData {
  const _$PreferenceDataImpl(
      {required this.gender,
      this.goal,
      this.client,
      this.modal,
      final List<Language>? language,
      this.level,
      final List<Availability>? availability,
      this.updatedAt,
      this.id,
      required this.createdAt,
      this.deletedAt})
      : _language = language,
        _availability = availability;

  factory _$PreferenceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceDataImplFromJson(json);

  @override
  final String gender;
// required String sessionFormat,
  @override
  final String? goal;
  @override
  final Client? client;
  @override
  final Modal? modal;
  final List<Language>? _language;
  @override
  List<Language>? get language {
    final value = _language;
    if (value == null) return null;
    if (_language is EqualUnmodifiableListView) return _language;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Level? level;
  final List<Availability>? _availability;
  @override
  List<Availability>? get availability {
    final value = _availability;
    if (value == null) return null;
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? updatedAt;
  @override
  final String? id;
  @override
  final String createdAt;
  @override
  final String? deletedAt;

  @override
  String toString() {
    return 'PreferenceData(gender: $gender, goal: $goal, client: $client, modal: $modal, language: $language, level: $level, availability: $availability, updatedAt: $updatedAt, id: $id, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceDataImpl &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.modal, modal) || other.modal == modal) &&
            const DeepCollectionEquality().equals(other._language, _language) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gender,
      goal,
      client,
      modal,
      const DeepCollectionEquality().hash(_language),
      level,
      const DeepCollectionEquality().hash(_availability),
      updatedAt,
      id,
      createdAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceDataImplCopyWith<_$PreferenceDataImpl> get copyWith =>
      __$$PreferenceDataImplCopyWithImpl<_$PreferenceDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceDataImplToJson(
      this,
    );
  }
}

abstract class _PreferenceData implements PreferenceData {
  const factory _PreferenceData(
      {required final String gender,
      final String? goal,
      final Client? client,
      final Modal? modal,
      final List<Language>? language,
      final Level? level,
      final List<Availability>? availability,
      final String? updatedAt,
      final String? id,
      required final String createdAt,
      final String? deletedAt}) = _$PreferenceDataImpl;

  factory _PreferenceData.fromJson(Map<String, dynamic> json) =
      _$PreferenceDataImpl.fromJson;

  @override
  String get gender;
  @override // required String sessionFormat,
  String? get goal;
  @override
  Client? get client;
  @override
  Modal? get modal;
  @override
  List<Language>? get language;
  @override
  Level? get level;
  @override
  List<Availability>? get availability;
  @override
  String? get updatedAt;
  @override
  String? get id;
  @override
  String get createdAt;
  @override
  String? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$PreferenceDataImplCopyWith<_$PreferenceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Client _$ClientFromJson(Map<String, dynamic> json) {
  return _Client.fromJson(json);
}

/// @nodoc
mixin _$Client {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientCopyWith<Client> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCopyWith<$Res> {
  factory $ClientCopyWith(Client value, $Res Function(Client) then) =
      _$ClientCopyWithImpl<$Res, Client>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$ClientCopyWithImpl<$Res, $Val extends Client>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientImplCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$$ClientImplCopyWith(
          _$ClientImpl value, $Res Function(_$ClientImpl) then) =
      __$$ClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ClientImplCopyWithImpl<$Res>
    extends _$ClientCopyWithImpl<$Res, _$ClientImpl>
    implements _$$ClientImplCopyWith<$Res> {
  __$$ClientImplCopyWithImpl(
      _$ClientImpl _value, $Res Function(_$ClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ClientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientImpl implements _Client {
  const _$ClientImpl({required this.id});

  factory _$ClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'Client(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      __$$ClientImplCopyWithImpl<_$ClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientImplToJson(
      this,
    );
  }
}

abstract class _Client implements Client {
  const factory _Client({required final String id}) = _$ClientImpl;

  factory _Client.fromJson(Map<String, dynamic> json) = _$ClientImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Modal _$ModalFromJson(Map<String, dynamic> json) {
  return _Modal.fromJson(json);
}

/// @nodoc
mixin _$Modal {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModalCopyWith<Modal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModalCopyWith<$Res> {
  factory $ModalCopyWith(Modal value, $Res Function(Modal) then) =
      _$ModalCopyWithImpl<$Res, Modal>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$ModalCopyWithImpl<$Res, $Val extends Modal>
    implements $ModalCopyWith<$Res> {
  _$ModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModalImplCopyWith<$Res> implements $ModalCopyWith<$Res> {
  factory _$$ModalImplCopyWith(
          _$ModalImpl value, $Res Function(_$ModalImpl) then) =
      __$$ModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ModalImplCopyWithImpl<$Res>
    extends _$ModalCopyWithImpl<$Res, _$ModalImpl>
    implements _$$ModalImplCopyWith<$Res> {
  __$$ModalImplCopyWithImpl(
      _$ModalImpl _value, $Res Function(_$ModalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ModalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModalImpl implements _Modal {
  const _$ModalImpl({required this.id});

  factory _$ModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModalImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'Modal(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModalImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModalImplCopyWith<_$ModalImpl> get copyWith =>
      __$$ModalImplCopyWithImpl<_$ModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModalImplToJson(
      this,
    );
  }
}

abstract class _Modal implements Modal {
  const factory _Modal({required final String id}) = _$ModalImpl;

  factory _Modal.fromJson(Map<String, dynamic> json) = _$ModalImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$ModalImplCopyWith<_$ModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return _Language.fromJson(json);
}

/// @nodoc
mixin _$Language {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LanguageCopyWith<Language> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageCopyWith<$Res> {
  factory $LanguageCopyWith(Language value, $Res Function(Language) then) =
      _$LanguageCopyWithImpl<$Res, Language>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$LanguageCopyWithImpl<$Res, $Val extends Language>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageImplCopyWith<$Res>
    implements $LanguageCopyWith<$Res> {
  factory _$$LanguageImplCopyWith(
          _$LanguageImpl value, $Res Function(_$LanguageImpl) then) =
      __$$LanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$LanguageImplCopyWithImpl<$Res>
    extends _$LanguageCopyWithImpl<$Res, _$LanguageImpl>
    implements _$$LanguageImplCopyWith<$Res> {
  __$$LanguageImplCopyWithImpl(
      _$LanguageImpl _value, $Res Function(_$LanguageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$LanguageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguageImpl implements _Language {
  const _$LanguageImpl({required this.id});

  factory _$LanguageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguageImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'Language(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      __$$LanguageImplCopyWithImpl<_$LanguageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguageImplToJson(
      this,
    );
  }
}

abstract class _Language implements Language {
  const factory _Language({required final String id}) = _$LanguageImpl;

  factory _Language.fromJson(Map<String, dynamic> json) =
      _$LanguageImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$LanguageImplCopyWith<_$LanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Level _$LevelFromJson(Map<String, dynamic> json) {
  return _Level.fromJson(json);
}

/// @nodoc
mixin _$Level {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelCopyWith<Level> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelCopyWith<$Res> {
  factory $LevelCopyWith(Level value, $Res Function(Level) then) =
      _$LevelCopyWithImpl<$Res, Level>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$LevelCopyWithImpl<$Res, $Val extends Level>
    implements $LevelCopyWith<$Res> {
  _$LevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelImplCopyWith<$Res> implements $LevelCopyWith<$Res> {
  factory _$$LevelImplCopyWith(
          _$LevelImpl value, $Res Function(_$LevelImpl) then) =
      __$$LevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$LevelImplCopyWithImpl<$Res>
    extends _$LevelCopyWithImpl<$Res, _$LevelImpl>
    implements _$$LevelImplCopyWith<$Res> {
  __$$LevelImplCopyWithImpl(
      _$LevelImpl _value, $Res Function(_$LevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$LevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelImpl implements _Level {
  const _$LevelImpl({required this.id});

  factory _$LevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelImplFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'Level(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      __$$LevelImplCopyWithImpl<_$LevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelImplToJson(
      this,
    );
  }
}

abstract class _Level implements Level {
  const factory _Level({required final String id}) = _$LevelImpl;

  factory _Level.fromJson(Map<String, dynamic> json) = _$LevelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$LevelImplCopyWith<_$LevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Availability _$AvailabilityFromJson(Map<String, dynamic> json) {
  return _Availability.fromJson(json);
}

/// @nodoc
mixin _$Availability {
  String get day => throw _privateConstructorUsedError;
  String get day_period =>
      throw _privateConstructorUsedError; // required int duration,
// required String timezone,
  String get updatedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvailabilityCopyWith<Availability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailabilityCopyWith<$Res> {
  factory $AvailabilityCopyWith(
          Availability value, $Res Function(Availability) then) =
      _$AvailabilityCopyWithImpl<$Res, Availability>;
  @useResult
  $Res call(
      {String day,
      String day_period,
      String updatedAt,
      String id,
      String createdAt,
      String? deletedAt});
}

/// @nodoc
class _$AvailabilityCopyWithImpl<$Res, $Val extends Availability>
    implements $AvailabilityCopyWith<$Res> {
  _$AvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? day_period = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      day_period: null == day_period
          ? _value.day_period
          : day_period // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvailabilityImplCopyWith<$Res>
    implements $AvailabilityCopyWith<$Res> {
  factory _$$AvailabilityImplCopyWith(
          _$AvailabilityImpl value, $Res Function(_$AvailabilityImpl) then) =
      __$$AvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String day,
      String day_period,
      String updatedAt,
      String id,
      String createdAt,
      String? deletedAt});
}

/// @nodoc
class __$$AvailabilityImplCopyWithImpl<$Res>
    extends _$AvailabilityCopyWithImpl<$Res, _$AvailabilityImpl>
    implements _$$AvailabilityImplCopyWith<$Res> {
  __$$AvailabilityImplCopyWithImpl(
      _$AvailabilityImpl _value, $Res Function(_$AvailabilityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? day_period = null,
    Object? updatedAt = null,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$AvailabilityImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      day_period: null == day_period
          ? _value.day_period
          : day_period // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailabilityImpl implements _Availability {
  const _$AvailabilityImpl(
      {required this.day,
      required this.day_period,
      required this.updatedAt,
      required this.id,
      required this.createdAt,
      this.deletedAt});

  factory _$AvailabilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailabilityImplFromJson(json);

  @override
  final String day;
  @override
  final String day_period;
// required int duration,
// required String timezone,
  @override
  final String updatedAt;
  @override
  final String id;
  @override
  final String createdAt;
  @override
  final String? deletedAt;

  @override
  String toString() {
    return 'Availability(day: $day, day_period: $day_period, updatedAt: $updatedAt, id: $id, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailabilityImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.day_period, day_period) ||
                other.day_period == day_period) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, day, day_period, updatedAt, id, createdAt, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailabilityImplCopyWith<_$AvailabilityImpl> get copyWith =>
      __$$AvailabilityImplCopyWithImpl<_$AvailabilityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailabilityImplToJson(
      this,
    );
  }
}

abstract class _Availability implements Availability {
  const factory _Availability(
      {required final String day,
      required final String day_period,
      required final String updatedAt,
      required final String id,
      required final String createdAt,
      final String? deletedAt}) = _$AvailabilityImpl;

  factory _Availability.fromJson(Map<String, dynamic> json) =
      _$AvailabilityImpl.fromJson;

  @override
  String get day;
  @override
  String get day_period;
  @override // required int duration,
// required String timezone,
  String get updatedAt;
  @override
  String get id;
  @override
  String get createdAt;
  @override
  String? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$AvailabilityImplCopyWith<_$AvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchRequest _$MatchRequestFromJson(Map<String, dynamic> json) {
  return _MatchRequest.fromJson(json);
}

/// @nodoc
mixin _$MatchRequest {
  String get preferenceId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchRequestCopyWith<MatchRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchRequestCopyWith<$Res> {
  factory $MatchRequestCopyWith(
          MatchRequest value, $Res Function(MatchRequest) then) =
      _$MatchRequestCopyWithImpl<$Res, MatchRequest>;
  @useResult
  $Res call({String preferenceId});
}

/// @nodoc
class _$MatchRequestCopyWithImpl<$Res, $Val extends MatchRequest>
    implements $MatchRequestCopyWith<$Res> {
  _$MatchRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferenceId = null,
  }) {
    return _then(_value.copyWith(
      preferenceId: null == preferenceId
          ? _value.preferenceId
          : preferenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchRequestImplCopyWith<$Res>
    implements $MatchRequestCopyWith<$Res> {
  factory _$$MatchRequestImplCopyWith(
          _$MatchRequestImpl value, $Res Function(_$MatchRequestImpl) then) =
      __$$MatchRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String preferenceId});
}

/// @nodoc
class __$$MatchRequestImplCopyWithImpl<$Res>
    extends _$MatchRequestCopyWithImpl<$Res, _$MatchRequestImpl>
    implements _$$MatchRequestImplCopyWith<$Res> {
  __$$MatchRequestImplCopyWithImpl(
      _$MatchRequestImpl _value, $Res Function(_$MatchRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preferenceId = null,
  }) {
    return _then(_$MatchRequestImpl(
      preferenceId: null == preferenceId
          ? _value.preferenceId
          : preferenceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchRequestImpl implements _MatchRequest {
  const _$MatchRequestImpl({required this.preferenceId});

  factory _$MatchRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchRequestImplFromJson(json);

  @override
  final String preferenceId;

  @override
  String toString() {
    return 'MatchRequest(preferenceId: $preferenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchRequestImpl &&
            (identical(other.preferenceId, preferenceId) ||
                other.preferenceId == preferenceId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, preferenceId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchRequestImplCopyWith<_$MatchRequestImpl> get copyWith =>
      __$$MatchRequestImplCopyWithImpl<_$MatchRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchRequestImplToJson(
      this,
    );
  }
}

abstract class _MatchRequest implements MatchRequest {
  const factory _MatchRequest({required final String preferenceId}) =
      _$MatchRequestImpl;

  factory _MatchRequest.fromJson(Map<String, dynamic> json) =
      _$MatchRequestImpl.fromJson;

  @override
  String get preferenceId;
  @override
  @JsonKey(ignore: true)
  _$$MatchRequestImplCopyWith<_$MatchRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchResponse _$MatchResponseFromJson(Map<String, dynamic> json) {
  return _MatchResponse.fromJson(json);
}

/// @nodoc
mixin _$MatchResponse {
  MatchData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchResponseCopyWith<MatchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchResponseCopyWith<$Res> {
  factory $MatchResponseCopyWith(
          MatchResponse value, $Res Function(MatchResponse) then) =
      _$MatchResponseCopyWithImpl<$Res, MatchResponse>;
  @useResult
  $Res call(
      {MatchData data,
      String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});

  $MatchDataCopyWith<$Res> get data;
}

/// @nodoc
class _$MatchResponseCopyWithImpl<$Res, $Val extends MatchResponse>
    implements $MatchResponseCopyWith<$Res> {
  _$MatchResponseCopyWithImpl(this._value, this._then);

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
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MatchData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
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
  $MatchDataCopyWith<$Res> get data {
    return $MatchDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchResponseImplCopyWith<$Res>
    implements $MatchResponseCopyWith<$Res> {
  factory _$$MatchResponseImplCopyWith(
          _$MatchResponseImpl value, $Res Function(_$MatchResponseImpl) then) =
      __$$MatchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MatchData data,
      String message,
      int statusCode,
      String? method,
      String? path,
      String? timestamp});

  @override
  $MatchDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$MatchResponseImplCopyWithImpl<$Res>
    extends _$MatchResponseCopyWithImpl<$Res, _$MatchResponseImpl>
    implements _$$MatchResponseImplCopyWith<$Res> {
  __$$MatchResponseImplCopyWithImpl(
      _$MatchResponseImpl _value, $Res Function(_$MatchResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$MatchResponseImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MatchData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$MatchResponseImpl implements _MatchResponse {
  const _$MatchResponseImpl(
      {required this.data,
      required this.message,
      required this.statusCode,
      this.method,
      this.path,
      this.timestamp});

  factory _$MatchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchResponseImplFromJson(json);

  @override
  final MatchData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'MatchResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchResponseImpl &&
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
  _$$MatchResponseImplCopyWith<_$MatchResponseImpl> get copyWith =>
      __$$MatchResponseImplCopyWithImpl<_$MatchResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchResponseImplToJson(
      this,
    );
  }
}

abstract class _MatchResponse implements MatchResponse {
  const factory _MatchResponse(
      {required final MatchData data,
      required final String message,
      required final int statusCode,
      final String? method,
      final String? path,
      final String? timestamp}) = _$MatchResponseImpl;

  factory _MatchResponse.fromJson(Map<String, dynamic> json) =
      _$MatchResponseImpl.fromJson;

  @override
  MatchData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$MatchResponseImplCopyWith<_$MatchResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchData _$MatchDataFromJson(Map<String, dynamic> json) {
  return _MatchData.fromJson(json);
}

/// @nodoc
mixin _$MatchData {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchDataCopyWith<MatchData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDataCopyWith<$Res> {
  factory $MatchDataCopyWith(MatchData value, $Res Function(MatchData) then) =
      _$MatchDataCopyWithImpl<$Res, MatchData>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$MatchDataCopyWithImpl<$Res, $Val extends MatchData>
    implements $MatchDataCopyWith<$Res> {
  _$MatchDataCopyWithImpl(this._value, this._then);

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
abstract class _$$MatchDataImplCopyWith<$Res>
    implements $MatchDataCopyWith<$Res> {
  factory _$$MatchDataImplCopyWith(
          _$MatchDataImpl value, $Res Function(_$MatchDataImpl) then) =
      __$$MatchDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MatchDataImplCopyWithImpl<$Res>
    extends _$MatchDataCopyWithImpl<$Res, _$MatchDataImpl>
    implements _$$MatchDataImplCopyWith<$Res> {
  __$$MatchDataImplCopyWithImpl(
      _$MatchDataImpl _value, $Res Function(_$MatchDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MatchDataImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchDataImpl implements _MatchData {
  const _$MatchDataImpl({required this.message});

  factory _$MatchDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchDataImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'MatchData(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDataImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchDataImplCopyWith<_$MatchDataImpl> get copyWith =>
      __$$MatchDataImplCopyWithImpl<_$MatchDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchDataImplToJson(
      this,
    );
  }
}

abstract class _MatchData implements MatchData {
  const factory _MatchData({required final String message}) = _$MatchDataImpl;

  factory _MatchData.fromJson(Map<String, dynamic> json) =
      _$MatchDataImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$MatchDataImplCopyWith<_$MatchDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
