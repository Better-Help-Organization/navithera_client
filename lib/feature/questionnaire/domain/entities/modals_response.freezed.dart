// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modals_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ModalsResponse _$ModalsResponseFromJson(Map<String, dynamic> json) {
  return _ModalsResponse.fromJson(json);
}

/// @nodoc
mixin _$ModalsResponse {
  List<TherapyModal> get data => throw _privateConstructorUsedError;

  /// Serializes this ModalsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModalsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModalsResponseCopyWith<ModalsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModalsResponseCopyWith<$Res> {
  factory $ModalsResponseCopyWith(
    ModalsResponse value,
    $Res Function(ModalsResponse) then,
  ) = _$ModalsResponseCopyWithImpl<$Res, ModalsResponse>;
  @useResult
  $Res call({List<TherapyModal> data});
}

/// @nodoc
class _$ModalsResponseCopyWithImpl<$Res, $Val extends ModalsResponse>
    implements $ModalsResponseCopyWith<$Res> {
  _$ModalsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModalsResponse
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
                        as List<TherapyModal>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModalsResponseImplCopyWith<$Res>
    implements $ModalsResponseCopyWith<$Res> {
  factory _$$ModalsResponseImplCopyWith(
    _$ModalsResponseImpl value,
    $Res Function(_$ModalsResponseImpl) then,
  ) = __$$ModalsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TherapyModal> data});
}

/// @nodoc
class __$$ModalsResponseImplCopyWithImpl<$Res>
    extends _$ModalsResponseCopyWithImpl<$Res, _$ModalsResponseImpl>
    implements _$$ModalsResponseImplCopyWith<$Res> {
  __$$ModalsResponseImplCopyWithImpl(
    _$ModalsResponseImpl _value,
    $Res Function(_$ModalsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModalsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$ModalsResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<TherapyModal>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModalsResponseImpl implements _ModalsResponse {
  const _$ModalsResponseImpl({required final List<TherapyModal> data})
    : _data = data;

  factory _$ModalsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModalsResponseImplFromJson(json);

  final List<TherapyModal> _data;
  @override
  List<TherapyModal> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ModalsResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModalsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of ModalsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModalsResponseImplCopyWith<_$ModalsResponseImpl> get copyWith =>
      __$$ModalsResponseImplCopyWithImpl<_$ModalsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ModalsResponseImplToJson(this);
  }
}

abstract class _ModalsResponse implements ModalsResponse {
  const factory _ModalsResponse({required final List<TherapyModal> data}) =
      _$ModalsResponseImpl;

  factory _ModalsResponse.fromJson(Map<String, dynamic> json) =
      _$ModalsResponseImpl.fromJson;

  @override
  List<TherapyModal> get data;

  /// Create a copy of ModalsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModalsResponseImplCopyWith<_$ModalsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
