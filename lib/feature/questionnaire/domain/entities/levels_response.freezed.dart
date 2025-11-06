// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'levels_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LevelsResponse _$LevelsResponseFromJson(Map<String, dynamic> json) {
  return _LevelsResponse.fromJson(json);
}

/// @nodoc
mixin _$LevelsResponse {
  List<LevelModel> get data => throw _privateConstructorUsedError;

  /// Serializes this LevelsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LevelsResponseCopyWith<LevelsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelsResponseCopyWith<$Res> {
  factory $LevelsResponseCopyWith(
    LevelsResponse value,
    $Res Function(LevelsResponse) then,
  ) = _$LevelsResponseCopyWithImpl<$Res, LevelsResponse>;
  @useResult
  $Res call({List<LevelModel> data});
}

/// @nodoc
class _$LevelsResponseCopyWithImpl<$Res, $Val extends LevelsResponse>
    implements $LevelsResponseCopyWith<$Res> {
  _$LevelsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<LevelModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LevelsResponseImplCopyWith<$Res>
    implements $LevelsResponseCopyWith<$Res> {
  factory _$$LevelsResponseImplCopyWith(
    _$LevelsResponseImpl value,
    $Res Function(_$LevelsResponseImpl) then,
  ) = __$$LevelsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LevelModel> data});
}

/// @nodoc
class __$$LevelsResponseImplCopyWithImpl<$Res>
    extends _$LevelsResponseCopyWithImpl<$Res, _$LevelsResponseImpl>
    implements _$$LevelsResponseImplCopyWith<$Res> {
  __$$LevelsResponseImplCopyWithImpl(
    _$LevelsResponseImpl _value,
    $Res Function(_$LevelsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$LevelsResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<LevelModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelsResponseImpl implements _LevelsResponse {
  const _$LevelsResponseImpl({required final List<LevelModel> data})
    : _data = data;

  factory _$LevelsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelsResponseImplFromJson(json);

  final List<LevelModel> _data;
  @override
  List<LevelModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'LevelsResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of LevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelsResponseImplCopyWith<_$LevelsResponseImpl> get copyWith =>
      __$$LevelsResponseImplCopyWithImpl<_$LevelsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelsResponseImplToJson(this);
  }
}

abstract class _LevelsResponse implements LevelsResponse {
  const factory _LevelsResponse({required final List<LevelModel> data}) =
      _$LevelsResponseImpl;

  factory _LevelsResponse.fromJson(Map<String, dynamic> json) =
      _$LevelsResponseImpl.fromJson;

  @override
  List<LevelModel> get data;

  /// Create a copy of LevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelsResponseImplCopyWith<_$LevelsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
