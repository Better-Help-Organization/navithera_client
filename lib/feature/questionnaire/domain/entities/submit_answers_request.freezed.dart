// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_answers_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubmitAnswersRequest _$SubmitAnswersRequestFromJson(Map<String, dynamic> json) {
  return _SubmitAnswersRequest.fromJson(json);
}

/// @nodoc
mixin _$SubmitAnswersRequest {
  String get modalId => throw _privateConstructorUsedError;
  List<AnswerRequest> get answers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubmitAnswersRequestCopyWith<SubmitAnswersRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitAnswersRequestCopyWith<$Res> {
  factory $SubmitAnswersRequestCopyWith(SubmitAnswersRequest value,
          $Res Function(SubmitAnswersRequest) then) =
      _$SubmitAnswersRequestCopyWithImpl<$Res, SubmitAnswersRequest>;
  @useResult
  $Res call({String modalId, List<AnswerRequest> answers});
}

/// @nodoc
class _$SubmitAnswersRequestCopyWithImpl<$Res,
        $Val extends SubmitAnswersRequest>
    implements $SubmitAnswersRequestCopyWith<$Res> {
  _$SubmitAnswersRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerRequest>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitAnswersRequestImplCopyWith<$Res>
    implements $SubmitAnswersRequestCopyWith<$Res> {
  factory _$$SubmitAnswersRequestImplCopyWith(_$SubmitAnswersRequestImpl value,
          $Res Function(_$SubmitAnswersRequestImpl) then) =
      __$$SubmitAnswersRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String modalId, List<AnswerRequest> answers});
}

/// @nodoc
class __$$SubmitAnswersRequestImplCopyWithImpl<$Res>
    extends _$SubmitAnswersRequestCopyWithImpl<$Res, _$SubmitAnswersRequestImpl>
    implements _$$SubmitAnswersRequestImplCopyWith<$Res> {
  __$$SubmitAnswersRequestImplCopyWithImpl(_$SubmitAnswersRequestImpl _value,
      $Res Function(_$SubmitAnswersRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modalId = null,
    Object? answers = null,
  }) {
    return _then(_$SubmitAnswersRequestImpl(
      modalId: null == modalId
          ? _value.modalId
          : modalId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerRequest>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitAnswersRequestImpl implements _SubmitAnswersRequest {
  const _$SubmitAnswersRequestImpl(
      {required this.modalId, required final List<AnswerRequest> answers})
      : _answers = answers;

  factory _$SubmitAnswersRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitAnswersRequestImplFromJson(json);

  @override
  final String modalId;
  final List<AnswerRequest> _answers;
  @override
  List<AnswerRequest> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'SubmitAnswersRequest(modalId: $modalId, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitAnswersRequestImpl &&
            (identical(other.modalId, modalId) || other.modalId == modalId) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, modalId, const DeepCollectionEquality().hash(_answers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitAnswersRequestImplCopyWith<_$SubmitAnswersRequestImpl>
      get copyWith =>
          __$$SubmitAnswersRequestImplCopyWithImpl<_$SubmitAnswersRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitAnswersRequestImplToJson(
      this,
    );
  }
}

abstract class _SubmitAnswersRequest implements SubmitAnswersRequest {
  const factory _SubmitAnswersRequest(
      {required final String modalId,
      required final List<AnswerRequest> answers}) = _$SubmitAnswersRequestImpl;

  factory _SubmitAnswersRequest.fromJson(Map<String, dynamic> json) =
      _$SubmitAnswersRequestImpl.fromJson;

  @override
  String get modalId;
  @override
  List<AnswerRequest> get answers;
  @override
  @JsonKey(ignore: true)
  _$$SubmitAnswersRequestImplCopyWith<_$SubmitAnswersRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AnswerRequest _$AnswerRequestFromJson(Map<String, dynamic> json) {
  return _AnswerRequest.fromJson(json);
}

/// @nodoc
mixin _$AnswerRequest {
  String get questionId => throw _privateConstructorUsedError;
  String? get singleOptionId => throw _privateConstructorUsedError;
  List<String>? get multiOptionIds => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerRequestCopyWith<AnswerRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerRequestCopyWith<$Res> {
  factory $AnswerRequestCopyWith(
          AnswerRequest value, $Res Function(AnswerRequest) then) =
      _$AnswerRequestCopyWithImpl<$Res, AnswerRequest>;
  @useResult
  $Res call(
      {String questionId,
      String? singleOptionId,
      List<String>? multiOptionIds,
      String? text});
}

/// @nodoc
class _$AnswerRequestCopyWithImpl<$Res, $Val extends AnswerRequest>
    implements $AnswerRequestCopyWith<$Res> {
  _$AnswerRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? singleOptionId = freezed,
    Object? multiOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      singleOptionId: freezed == singleOptionId
          ? _value.singleOptionId
          : singleOptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      multiOptionIds: freezed == multiOptionIds
          ? _value.multiOptionIds
          : multiOptionIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerRequestImplCopyWith<$Res>
    implements $AnswerRequestCopyWith<$Res> {
  factory _$$AnswerRequestImplCopyWith(
          _$AnswerRequestImpl value, $Res Function(_$AnswerRequestImpl) then) =
      __$$AnswerRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String questionId,
      String? singleOptionId,
      List<String>? multiOptionIds,
      String? text});
}

/// @nodoc
class __$$AnswerRequestImplCopyWithImpl<$Res>
    extends _$AnswerRequestCopyWithImpl<$Res, _$AnswerRequestImpl>
    implements _$$AnswerRequestImplCopyWith<$Res> {
  __$$AnswerRequestImplCopyWithImpl(
      _$AnswerRequestImpl _value, $Res Function(_$AnswerRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? singleOptionId = freezed,
    Object? multiOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(_$AnswerRequestImpl(
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as String,
      singleOptionId: freezed == singleOptionId
          ? _value.singleOptionId
          : singleOptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      multiOptionIds: freezed == multiOptionIds
          ? _value._multiOptionIds
          : multiOptionIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerRequestImpl implements _AnswerRequest {
  const _$AnswerRequestImpl(
      {required this.questionId,
      this.singleOptionId,
      final List<String>? multiOptionIds,
      this.text})
      : _multiOptionIds = multiOptionIds;

  factory _$AnswerRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerRequestImplFromJson(json);

  @override
  final String questionId;
  @override
  final String? singleOptionId;
  final List<String>? _multiOptionIds;
  @override
  List<String>? get multiOptionIds {
    final value = _multiOptionIds;
    if (value == null) return null;
    if (_multiOptionIds is EqualUnmodifiableListView) return _multiOptionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
            const DeepCollectionEquality()
                .equals(other._multiOptionIds, _multiOptionIds) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, questionId, singleOptionId,
      const DeepCollectionEquality().hash(_multiOptionIds), text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerRequestImplCopyWith<_$AnswerRequestImpl> get copyWith =>
      __$$AnswerRequestImplCopyWithImpl<_$AnswerRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerRequestImplToJson(
      this,
    );
  }
}

abstract class _AnswerRequest implements AnswerRequest {
  const factory _AnswerRequest(
      {required final String questionId,
      final String? singleOptionId,
      final List<String>? multiOptionIds,
      final String? text}) = _$AnswerRequestImpl;

  factory _AnswerRequest.fromJson(Map<String, dynamic> json) =
      _$AnswerRequestImpl.fromJson;

  @override
  String get questionId;
  @override
  String? get singleOptionId;
  @override
  List<String>? get multiOptionIds;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$AnswerRequestImplCopyWith<_$AnswerRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
