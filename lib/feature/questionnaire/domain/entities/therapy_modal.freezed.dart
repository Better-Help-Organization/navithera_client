// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapy_modal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TherapyModal _$TherapyModalFromJson(Map<String, dynamic> json) {
  return _TherapyModal.fromJson(json);
}

/// @nodoc
mixin _$TherapyModal {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TherapyModal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TherapyModal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TherapyModalCopyWith<TherapyModal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TherapyModalCopyWith<$Res> {
  factory $TherapyModalCopyWith(
    TherapyModal value,
    $Res Function(TherapyModal) then,
  ) = _$TherapyModalCopyWithImpl<$Res, TherapyModal>;
  @useResult
  $Res call({String id, String name, String description, DateTime createdAt});
}

/// @nodoc
class _$TherapyModalCopyWithImpl<$Res, $Val extends TherapyModal>
    implements $TherapyModalCopyWith<$Res> {
  _$TherapyModalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TherapyModal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TherapyModalImplCopyWith<$Res>
    implements $TherapyModalCopyWith<$Res> {
  factory _$$TherapyModalImplCopyWith(
    _$TherapyModalImpl value,
    $Res Function(_$TherapyModalImpl) then,
  ) = __$$TherapyModalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description, DateTime createdAt});
}

/// @nodoc
class __$$TherapyModalImplCopyWithImpl<$Res>
    extends _$TherapyModalCopyWithImpl<$Res, _$TherapyModalImpl>
    implements _$$TherapyModalImplCopyWith<$Res> {
  __$$TherapyModalImplCopyWithImpl(
    _$TherapyModalImpl _value,
    $Res Function(_$TherapyModalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TherapyModal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$TherapyModalImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TherapyModalImpl implements _TherapyModal {
  const _$TherapyModalImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory _$TherapyModalImpl.fromJson(Map<String, dynamic> json) =>
      _$$TherapyModalImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'TherapyModal(id: $id, name: $name, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TherapyModalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, createdAt);

  /// Create a copy of TherapyModal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TherapyModalImplCopyWith<_$TherapyModalImpl> get copyWith =>
      __$$TherapyModalImplCopyWithImpl<_$TherapyModalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TherapyModalImplToJson(this);
  }
}

abstract class _TherapyModal implements TherapyModal {
  const factory _TherapyModal({
    required final String id,
    required final String name,
    required final String description,
    required final DateTime createdAt,
  }) = _$TherapyModalImpl;

  factory _TherapyModal.fromJson(Map<String, dynamic> json) =
      _$TherapyModalImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  DateTime get createdAt;

  /// Create a copy of TherapyModal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TherapyModalImplCopyWith<_$TherapyModalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
