// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'languages_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LanguagesResponse _$LanguagesResponseFromJson(Map<String, dynamic> json) {
  return _LanguagesResponse.fromJson(json);
}

/// @nodoc
mixin _$LanguagesResponse {
  List<LanguageModel> get data => throw _privateConstructorUsedError;

  /// Serializes this LanguagesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LanguagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LanguagesResponseCopyWith<LanguagesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguagesResponseCopyWith<$Res> {
  factory $LanguagesResponseCopyWith(
    LanguagesResponse value,
    $Res Function(LanguagesResponse) then,
  ) = _$LanguagesResponseCopyWithImpl<$Res, LanguagesResponse>;
  @useResult
  $Res call({List<LanguageModel> data});
}

/// @nodoc
class _$LanguagesResponseCopyWithImpl<$Res, $Val extends LanguagesResponse>
    implements $LanguagesResponseCopyWith<$Res> {
  _$LanguagesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LanguagesResponse
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
                        as List<LanguageModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LanguagesResponseImplCopyWith<$Res>
    implements $LanguagesResponseCopyWith<$Res> {
  factory _$$LanguagesResponseImplCopyWith(
    _$LanguagesResponseImpl value,
    $Res Function(_$LanguagesResponseImpl) then,
  ) = __$$LanguagesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LanguageModel> data});
}

/// @nodoc
class __$$LanguagesResponseImplCopyWithImpl<$Res>
    extends _$LanguagesResponseCopyWithImpl<$Res, _$LanguagesResponseImpl>
    implements _$$LanguagesResponseImplCopyWith<$Res> {
  __$$LanguagesResponseImplCopyWithImpl(
    _$LanguagesResponseImpl _value,
    $Res Function(_$LanguagesResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LanguagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$LanguagesResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<LanguageModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LanguagesResponseImpl implements _LanguagesResponse {
  const _$LanguagesResponseImpl({required final List<LanguageModel> data})
    : _data = data;

  factory _$LanguagesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LanguagesResponseImplFromJson(json);

  final List<LanguageModel> _data;
  @override
  List<LanguageModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'LanguagesResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguagesResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of LanguagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguagesResponseImplCopyWith<_$LanguagesResponseImpl> get copyWith =>
      __$$LanguagesResponseImplCopyWithImpl<_$LanguagesResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LanguagesResponseImplToJson(this);
  }
}

abstract class _LanguagesResponse implements LanguagesResponse {
  const factory _LanguagesResponse({required final List<LanguageModel> data}) =
      _$LanguagesResponseImpl;

  factory _LanguagesResponse.fromJson(Map<String, dynamic> json) =
      _$LanguagesResponseImpl.fromJson;

  @override
  List<LanguageModel> get data;

  /// Create a copy of LanguagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguagesResponseImplCopyWith<_$LanguagesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
