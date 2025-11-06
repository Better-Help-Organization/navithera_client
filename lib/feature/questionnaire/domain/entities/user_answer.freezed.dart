// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  String get questionId => throw _privateConstructorUsedError;
  String? get selectedOptionId =>
      throw _privateConstructorUsedError; // For single choice
  List<String>? get selectedOptionIds =>
      throw _privateConstructorUsedError; // For multiple choice
  String? get text => throw _privateConstructorUsedError;

  /// Serializes this UserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
    UserAnswer value,
    $Res Function(UserAnswer) then,
  ) = _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call({
    String questionId,
    String? selectedOptionId,
    List<String>? selectedOptionIds,
    String? text,
  });
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = freezed,
    Object? selectedOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(
      _value.copyWith(
            questionId:
                null == questionId
                    ? _value.questionId
                    : questionId // ignore: cast_nullable_to_non_nullable
                        as String,
            selectedOptionId:
                freezed == selectedOptionId
                    ? _value.selectedOptionId
                    : selectedOptionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedOptionIds:
                freezed == selectedOptionIds
                    ? _value.selectedOptionIds
                    : selectedOptionIds // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UserAnswerImplCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$UserAnswerImplCopyWith(
    _$UserAnswerImpl value,
    $Res Function(_$UserAnswerImpl) then,
  ) = __$$UserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    String? selectedOptionId,
    List<String>? selectedOptionIds,
    String? text,
  });
}

/// @nodoc
class __$$UserAnswerImplCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$UserAnswerImpl>
    implements _$$UserAnswerImplCopyWith<$Res> {
  __$$UserAnswerImplCopyWithImpl(
    _$UserAnswerImpl _value,
    $Res Function(_$UserAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = freezed,
    Object? selectedOptionIds = freezed,
    Object? text = freezed,
  }) {
    return _then(
      _$UserAnswerImpl(
        questionId:
            null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                    as String,
        selectedOptionId:
            freezed == selectedOptionId
                ? _value.selectedOptionId
                : selectedOptionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedOptionIds:
            freezed == selectedOptionIds
                ? _value._selectedOptionIds
                : selectedOptionIds // ignore: cast_nullable_to_non_nullable
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
class _$UserAnswerImpl implements _UserAnswer {
  const _$UserAnswerImpl({
    required this.questionId,
    this.selectedOptionId,
    final List<String>? selectedOptionIds,
    this.text,
  }) : _selectedOptionIds = selectedOptionIds;

  factory _$UserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnswerImplFromJson(json);

  @override
  final String questionId;
  @override
  final String? selectedOptionId;
  // For single choice
  final List<String>? _selectedOptionIds;
  // For single choice
  @override
  List<String>? get selectedOptionIds {
    final value = _selectedOptionIds;
    if (value == null) return null;
    if (_selectedOptionIds is EqualUnmodifiableListView)
      return _selectedOptionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // For multiple choice
  @override
  final String? text;

  @override
  String toString() {
    return 'UserAnswer(questionId: $questionId, selectedOptionId: $selectedOptionId, selectedOptionIds: $selectedOptionIds, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnswerImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            const DeepCollectionEquality().equals(
              other._selectedOptionIds,
              _selectedOptionIds,
            ) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    selectedOptionId,
    const DeepCollectionEquality().hash(_selectedOptionIds),
    text,
  );

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      __$$UserAnswerImplCopyWithImpl<_$UserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnswerImplToJson(this);
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer({
    required final String questionId,
    final String? selectedOptionId,
    final List<String>? selectedOptionIds,
    final String? text,
  }) = _$UserAnswerImpl;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$UserAnswerImpl.fromJson;

  @override
  String get questionId;
  @override
  String? get selectedOptionId; // For single choice
  @override
  List<String>? get selectedOptionIds; // For multiple choice
  @override
  String? get text;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
