// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AiChatState {
  List<ChatMessage> get messages => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  UsageInfo? get usageInfo => throw _privateConstructorUsedError;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatStateCopyWith<AiChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatStateCopyWith<$Res> {
  factory $AiChatStateCopyWith(
    AiChatState value,
    $Res Function(AiChatState) then,
  ) = _$AiChatStateCopyWithImpl<$Res, AiChatState>;
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isLoading,
    String? error,
    UsageInfo? usageInfo,
  });

  $UsageInfoCopyWith<$Res>? get usageInfo;
}

/// @nodoc
class _$AiChatStateCopyWithImpl<$Res, $Val extends AiChatState>
    implements $AiChatStateCopyWith<$Res> {
  _$AiChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? usageInfo = freezed,
  }) {
    return _then(
      _value.copyWith(
            messages:
                null == messages
                    ? _value.messages
                    : messages // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessage>,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
            usageInfo:
                freezed == usageInfo
                    ? _value.usageInfo
                    : usageInfo // ignore: cast_nullable_to_non_nullable
                        as UsageInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsageInfoCopyWith<$Res>? get usageInfo {
    if (_value.usageInfo == null) {
      return null;
    }

    return $UsageInfoCopyWith<$Res>(_value.usageInfo!, (value) {
      return _then(_value.copyWith(usageInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiChatStateImplCopyWith<$Res>
    implements $AiChatStateCopyWith<$Res> {
  factory _$$AiChatStateImplCopyWith(
    _$AiChatStateImpl value,
    $Res Function(_$AiChatStateImpl) then,
  ) = __$$AiChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isLoading,
    String? error,
    UsageInfo? usageInfo,
  });

  @override
  $UsageInfoCopyWith<$Res>? get usageInfo;
}

/// @nodoc
class __$$AiChatStateImplCopyWithImpl<$Res>
    extends _$AiChatStateCopyWithImpl<$Res, _$AiChatStateImpl>
    implements _$$AiChatStateImplCopyWith<$Res> {
  __$$AiChatStateImplCopyWithImpl(
    _$AiChatStateImpl _value,
    $Res Function(_$AiChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? usageInfo = freezed,
  }) {
    return _then(
      _$AiChatStateImpl(
        messages:
            null == messages
                ? _value._messages
                : messages // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessage>,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
        usageInfo:
            freezed == usageInfo
                ? _value.usageInfo
                : usageInfo // ignore: cast_nullable_to_non_nullable
                    as UsageInfo?,
      ),
    );
  }
}

/// @nodoc

class _$AiChatStateImpl implements _AiChatState {
  const _$AiChatStateImpl({
    final List<ChatMessage> messages = const [],
    this.isLoading = false,
    this.error,
    this.usageInfo,
  }) : _messages = messages;

  final List<ChatMessage> _messages;
  @override
  @JsonKey()
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final UsageInfo? usageInfo;

  @override
  String toString() {
    return 'AiChatState(messages: $messages, isLoading: $isLoading, error: $error, usageInfo: $usageInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.usageInfo, usageInfo) ||
                other.usageInfo == usageInfo));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    isLoading,
    error,
    usageInfo,
  );

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatStateImplCopyWith<_$AiChatStateImpl> get copyWith =>
      __$$AiChatStateImplCopyWithImpl<_$AiChatStateImpl>(this, _$identity);
}

abstract class _AiChatState implements AiChatState {
  const factory _AiChatState({
    final List<ChatMessage> messages,
    final bool isLoading,
    final String? error,
    final UsageInfo? usageInfo,
  }) = _$AiChatStateImpl;

  @override
  List<ChatMessage> get messages;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  UsageInfo? get usageInfo;

  /// Create a copy of AiChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatStateImplCopyWith<_$AiChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
