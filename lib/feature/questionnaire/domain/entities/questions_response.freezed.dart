// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionsResponse _$QuestionsResponseFromJson(Map<String, dynamic> json) {
  return _QuestionsResponse.fromJson(json);
}

/// @nodoc
mixin _$QuestionsResponse {
  List<Question> get data => throw _privateConstructorUsedError;

  /// Serializes this QuestionsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionsResponseCopyWith<QuestionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionsResponseCopyWith<$Res> {
  factory $QuestionsResponseCopyWith(
    QuestionsResponse value,
    $Res Function(QuestionsResponse) then,
  ) = _$QuestionsResponseCopyWithImpl<$Res, QuestionsResponse>;
  @useResult
  $Res call({List<Question> data});
}

/// @nodoc
class _$QuestionsResponseCopyWithImpl<$Res, $Val extends QuestionsResponse>
    implements $QuestionsResponseCopyWith<$Res> {
  _$QuestionsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionsResponse
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
                        as List<Question>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionsResponseImplCopyWith<$Res>
    implements $QuestionsResponseCopyWith<$Res> {
  factory _$$QuestionsResponseImplCopyWith(
    _$QuestionsResponseImpl value,
    $Res Function(_$QuestionsResponseImpl) then,
  ) = __$$QuestionsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Question> data});
}

/// @nodoc
class __$$QuestionsResponseImplCopyWithImpl<$Res>
    extends _$QuestionsResponseCopyWithImpl<$Res, _$QuestionsResponseImpl>
    implements _$$QuestionsResponseImplCopyWith<$Res> {
  __$$QuestionsResponseImplCopyWithImpl(
    _$QuestionsResponseImpl _value,
    $Res Function(_$QuestionsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$QuestionsResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<Question>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionsResponseImpl implements _QuestionsResponse {
  const _$QuestionsResponseImpl({required final List<Question> data})
    : _data = data;

  factory _$QuestionsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionsResponseImplFromJson(json);

  final List<Question> _data;
  @override
  List<Question> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'QuestionsResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of QuestionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionsResponseImplCopyWith<_$QuestionsResponseImpl> get copyWith =>
      __$$QuestionsResponseImplCopyWithImpl<_$QuestionsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionsResponseImplToJson(this);
  }
}

abstract class _QuestionsResponse implements QuestionsResponse {
  const factory _QuestionsResponse({required final List<Question> data}) =
      _$QuestionsResponseImpl;

  factory _QuestionsResponse.fromJson(Map<String, dynamic> json) =
      _$QuestionsResponseImpl.fromJson;

  @override
  List<Question> get data;

  /// Create a copy of QuestionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionsResponseImplCopyWith<_$QuestionsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
