// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool? get isEmailAuthenticated => throw _privateConstructorUsedError;
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
  bool? get isPhoneNumberAuthenticated => throw _privateConstructorUsedError;
  @JsonKey(name: 'preference')
  List<PrefData>? get preferences => throw _privateConstructorUsedError; // Map 'preference' to 'preferences'
  @JsonKey(name: 'answer')
  List<AnsData>? get answers => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription')
  List<SubscriptionData>? get subscriptions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'activeSubscription')
  SubscriptionData? get activeSubscription =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'expertise')
  List<ExpertiseData>? get expertise => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  NotificationItem? get hasNotification => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime? createdAt,
    bool? isEmailAuthenticated,
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
    bool? isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference') List<PrefData>? preferences,
    @JsonKey(name: 'answer') List<AnsData>? answers,
    @JsonKey(name: 'subscription') List<SubscriptionData>? subscriptions,
    @JsonKey(name: 'activeSubscription') SubscriptionData? activeSubscription,
    @JsonKey(name: 'expertise') List<ExpertiseData>? expertise,
    int? avatar,
    String? profile,
    NotificationItem? hasNotification,
  });

  $SubscriptionDataCopyWith<$Res>? get activeSubscription;
  $NotificationItemCopyWith<$Res>? get hasNotification;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = freezed,
    Object? isEmailAuthenticated = freezed,
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
    Object? isPhoneNumberAuthenticated = freezed,
    Object? preferences = freezed,
    Object? answers = freezed,
    Object? subscriptions = freezed,
    Object? activeSubscription = freezed,
    Object? expertise = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? hasNotification = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isEmailAuthenticated:
                freezed == isEmailAuthenticated
                    ? _value.isEmailAuthenticated
                    : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            dob:
                freezed == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            isVisible:
                freezed == isVisible
                    ? _value.isVisible
                    : isVisible // ignore: cast_nullable_to_non_nullable
                        as bool?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            emergencyContact:
                freezed == emergencyContact
                    ? _value.emergencyContact
                    : emergencyContact // ignore: cast_nullable_to_non_nullable
                        as dynamic,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isLinked:
                freezed == isLinked
                    ? _value.isLinked
                    : isLinked // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isPhoneNumberAuthenticated:
                freezed == isPhoneNumberAuthenticated
                    ? _value.isPhoneNumberAuthenticated
                    : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            preferences:
                freezed == preferences
                    ? _value.preferences
                    : preferences // ignore: cast_nullable_to_non_nullable
                        as List<PrefData>?,
            answers:
                freezed == answers
                    ? _value.answers
                    : answers // ignore: cast_nullable_to_non_nullable
                        as List<AnsData>?,
            subscriptions:
                freezed == subscriptions
                    ? _value.subscriptions
                    : subscriptions // ignore: cast_nullable_to_non_nullable
                        as List<SubscriptionData>?,
            activeSubscription:
                freezed == activeSubscription
                    ? _value.activeSubscription
                    : activeSubscription // ignore: cast_nullable_to_non_nullable
                        as SubscriptionData?,
            expertise:
                freezed == expertise
                    ? _value.expertise
                    : expertise // ignore: cast_nullable_to_non_nullable
                        as List<ExpertiseData>?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as int?,
            profile:
                freezed == profile
                    ? _value.profile
                    : profile // ignore: cast_nullable_to_non_nullable
                        as String?,
            hasNotification:
                freezed == hasNotification
                    ? _value.hasNotification
                    : hasNotification // ignore: cast_nullable_to_non_nullable
                        as NotificationItem?,
          )
          as $Val,
    );
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime? createdAt,
    bool? isEmailAuthenticated,
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
    bool? isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference') List<PrefData>? preferences,
    @JsonKey(name: 'answer') List<AnsData>? answers,
    @JsonKey(name: 'subscription') List<SubscriptionData>? subscriptions,
    @JsonKey(name: 'activeSubscription') SubscriptionData? activeSubscription,
    @JsonKey(name: 'expertise') List<ExpertiseData>? expertise,
    int? avatar,
    String? profile,
    NotificationItem? hasNotification,
  });

  @override
  $SubscriptionDataCopyWith<$Res>? get activeSubscription;
  @override
  $NotificationItemCopyWith<$Res>? get hasNotification;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = freezed,
    Object? isEmailAuthenticated = freezed,
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
    Object? isPhoneNumberAuthenticated = freezed,
    Object? preferences = freezed,
    Object? answers = freezed,
    Object? subscriptions = freezed,
    Object? activeSubscription = freezed,
    Object? expertise = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? hasNotification = freezed,
  }) {
    return _then(
      _$UserImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isEmailAuthenticated:
            freezed == isEmailAuthenticated
                ? _value.isEmailAuthenticated
                : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        dob:
            freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        isVisible:
            freezed == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                    as bool?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        emergencyContact:
            freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isLinked:
            freezed == isLinked
                ? _value.isLinked
                : isLinked // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isPhoneNumberAuthenticated:
            freezed == isPhoneNumberAuthenticated
                ? _value.isPhoneNumberAuthenticated
                : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        preferences:
            freezed == preferences
                ? _value._preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                    as List<PrefData>?,
        answers:
            freezed == answers
                ? _value._answers
                : answers // ignore: cast_nullable_to_non_nullable
                    as List<AnsData>?,
        subscriptions:
            freezed == subscriptions
                ? _value._subscriptions
                : subscriptions // ignore: cast_nullable_to_non_nullable
                    as List<SubscriptionData>?,
        activeSubscription:
            freezed == activeSubscription
                ? _value.activeSubscription
                : activeSubscription // ignore: cast_nullable_to_non_nullable
                    as SubscriptionData?,
        expertise:
            freezed == expertise
                ? _value._expertise
                : expertise // ignore: cast_nullable_to_non_nullable
                    as List<ExpertiseData>?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as int?,
        profile:
            freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                    as String?,
        hasNotification:
            freezed == hasNotification
                ? _value.hasNotification
                : hasNotification // ignore: cast_nullable_to_non_nullable
                    as NotificationItem?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    this.isEmailAuthenticated,
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
    this.isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference') final List<PrefData>? preferences,
    @JsonKey(name: 'answer') final List<AnsData>? answers,
    @JsonKey(name: 'subscription') final List<SubscriptionData>? subscriptions,
    @JsonKey(name: 'activeSubscription') this.activeSubscription,
    @JsonKey(name: 'expertise') final List<ExpertiseData>? expertise,
    this.avatar,
    this.profile,
    this.hasNotification,
  }) : _preferences = preferences,
       _answers = answers,
       _subscriptions = subscriptions,
       _expertise = expertise;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime? createdAt;
  @override
  final bool? isEmailAuthenticated;
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

  final List<SubscriptionData>? _subscriptions;
  @override
  @JsonKey(name: 'subscription')
  List<SubscriptionData>? get subscriptions {
    final value = _subscriptions;
    if (value == null) return null;
    if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final NotificationItem? hasNotification;

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, isEmailAuthenticated: $isEmailAuthenticated, status: $status, gender: $gender, dob: $dob, username: $username, phoneNumber: $phoneNumber, isVisible: $isVisible, updatedAt: $updatedAt, emergencyContact: $emergencyContact, deletedAt: $deletedAt, isLinked: $isLinked, isPhoneNumberAuthenticated: $isPhoneNumberAuthenticated, preferences: $preferences, answers: $answers, subscriptions: $subscriptions, activeSubscription: $activeSubscription, expertise: $expertise, avatar: $avatar, profile: $profile, hasNotification: $hasNotification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isEmailAuthenticated, isEmailAuthenticated) ||
                other.isEmailAuthenticated == isEmailAuthenticated) &&
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
            const DeepCollectionEquality().equals(
              other.emergencyContact,
              emergencyContact,
            ) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isLinked, isLinked) ||
                other.isLinked == isLinked) &&
            (identical(
                  other.isPhoneNumberAuthenticated,
                  isPhoneNumberAuthenticated,
                ) ||
                other.isPhoneNumberAuthenticated ==
                    isPhoneNumberAuthenticated) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality().equals(
              other._subscriptions,
              _subscriptions,
            ) &&
            (identical(other.activeSubscription, activeSubscription) ||
                other.activeSubscription == activeSubscription) &&
            const DeepCollectionEquality().equals(
              other._expertise,
              _expertise,
            ) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.hasNotification, hasNotification) ||
                other.hasNotification == hasNotification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    createdAt,
    isEmailAuthenticated,
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
    isPhoneNumberAuthenticated,
    const DeepCollectionEquality().hash(_preferences),
    const DeepCollectionEquality().hash(_answers),
    const DeepCollectionEquality().hash(_subscriptions),
    activeSubscription,
    const DeepCollectionEquality().hash(_expertise),
    avatar,
    profile,
    hasNotification,
  ]);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final DateTime? createdAt,
    final bool? isEmailAuthenticated,
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
    final bool? isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference') final List<PrefData>? preferences,
    @JsonKey(name: 'answer') final List<AnsData>? answers,
    @JsonKey(name: 'subscription') final List<SubscriptionData>? subscriptions,
    @JsonKey(name: 'activeSubscription')
    final SubscriptionData? activeSubscription,
    @JsonKey(name: 'expertise') final List<ExpertiseData>? expertise,
    final int? avatar,
    final String? profile,
    final NotificationItem? hasNotification,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime? get createdAt;
  @override
  bool? get isEmailAuthenticated;
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
  bool? get isPhoneNumberAuthenticated;
  @override
  @JsonKey(name: 'preference')
  List<PrefData>? get preferences; // Map 'preference' to 'preferences'
  @override
  @JsonKey(name: 'answer')
  List<AnsData>? get answers;
  @override
  @JsonKey(name: 'subscription')
  List<SubscriptionData>? get subscriptions;
  @override
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
  NotificationItem? get hasNotification;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
