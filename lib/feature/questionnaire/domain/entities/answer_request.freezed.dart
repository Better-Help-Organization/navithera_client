// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnswerRequest _$AnswerRequestFromJson(Map<String, dynamic> json) {
  return _AnswerRequest.fromJson(json);
}

/// @nodoc
mixin _$AnswerRequest {
  String get questionId => throw _privateConstructorUsedError;
  String? get singleOptionId =>
      throw _privateConstructorUsedError; // For single choice
  List<String>? get multiOptionIds =>
      throw _privateConstructorUsedError; // For multiple choice
  String? get text => throw _privateConstructorUsedError;

  /// Serializes this AnswerRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerRequestCopyWith<AnswerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerRequestCopyWith<$Res> {
  factory $AnswerRequestCopyWith(
    AnswerRequest value,
    $Res Function(AnswerRequest) then,
  ) = _$AnswerRequestCopyWithImpl<$Res, AnswerRequest>;
  @useResult
  $Res call({
    String questionId,
    String? singleOptionId,
    List<String>? multiOptionIds,
    String? text,
  });
}

/// @nodoc
class _$AnswerRequestCopyWithImpl<$Res, $Val extends AnswerRequest>
    implements $AnswerRequestCopyWith<$Res> {
  _$AnswerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? singleOptionId = freezed,
    Object? multiOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId:
                null == questionId
                    ? _value.questionId
                    : questionId // ignore: cast_nullable_to_non_nullable
                        as String,
            singleOptionId:
                freezed == singleOptionId
                    ? _value.singleOptionId
                    : singleOptionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            multiOptionIds:
                freezed == multiOptionIds
                    ? _value.multiOptionIds
                    : multiOptionIds // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
            text:
                freezed == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnswerRequestImplCopyWith<$Res>
    implements $AnswerRequestCopyWith<$Res> {
  factory _$$AnswerRequestImplCopyWith(
    _$AnswerRequestImpl value,
    $Res Function(_$AnswerRequestImpl) then,
  ) = __$$AnswerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String? singleOptionId,
    List<String>? multiOptionIds,
    String? text,
  });
}

/// @nodoc
class __$$AnswerRequestImplCopyWithImpl<$Res>
    extends _$AnswerRequestCopyWithImpl<$Res, _$AnswerRequestImpl>
    implements _$$AnswerRequestImplCopyWith<$Res> {
  __$$AnswerRequestImplCopyWithImpl(
    _$AnswerRequestImpl _value,
    $Res Function(_$AnswerRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? singleOptionId = freezed,
    Object? multiOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(
      _$AnswerRequestImpl(
        questionId:
            null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                    as String,
        singleOptionId:
            freezed == singleOptionId
                ? _value.singleOptionId
                : singleOptionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        multiOptionIds:
            freezed == multiOptionIds
                ? _value._multiOptionIds
                : multiOptionIds // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        text:
            freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerRequestImpl implements _AnswerRequest {
  const _$AnswerRequestImpl({
    required this.questionId,
    this.singleOptionId,
    final List<String>? multiOptionIds,
    this.text,
  }) : _multiOptionIds = multiOptionIds;

  factory _$AnswerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerRequestImplFromJson(json);

  @override
  final String questionId;
  @override
  final String? singleOptionId;
  // For single choice
  final List<String>? _multiOptionIds;
  // For single choice
  @override
  List<String>? get multiOptionIds {
    final value = _multiOptionIds;
    if (value == null) return null;
    if (_multiOptionIds is EqualUnmodifiableListView) return _multiOptionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // For multiple choice
  @override
  final String? text;

  @override
  String toString() {
    return 'AnswerRequest(questionId: $questionId, singleOptionId: $singleOptionId, multiOptionIds: $multiOptionIds, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerRequestImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.singleOptionId, singleOptionId) ||
                other.singleOptionId == singleOptionId) &&
            const DeepCollectionEquality().equals(
              other._multiOptionIds,
              _multiOptionIds,
            ) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    singleOptionId,
    const DeepCollectionEquality().hash(_multiOptionIds),
    text,
  );

  /// Create a copy of AnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerRequestImplCopyWith<_$AnswerRequestImpl> get copyWith =>
      __$$AnswerRequestImplCopyWithImpl<_$AnswerRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerRequestImplToJson(this);
  }
}

abstract class _AnswerRequest implements AnswerRequest {
  const factory _AnswerRequest({
    required final String questionId,
    final String? singleOptionId,
    final List<String>? multiOptionIds,
    final String? text,
  }) = _$AnswerRequestImpl;

  factory _AnswerRequest.fromJson(Map<String, dynamic> json) =
      _$AnswerRequestImpl.fromJson;

  @override
  String get questionId;
  @override
  String? get singleOptionId; // For single choice
  @override
  List<String>? get multiOptionIds; // For multiple choice
  @override
  String? get text;

  /// Create a copy of AnswerRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerRequestImplCopyWith<_$AnswerRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
