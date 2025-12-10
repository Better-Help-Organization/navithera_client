// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_session_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LiveSessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveSessionStateCopyWith<$Res> {
  factory $LiveSessionStateCopyWith(
    LiveSessionState value,
    $Res Function(LiveSessionState) then,
  ) = _$LiveSessionStateCopyWithImpl<$Res, LiveSessionState>;
}

/// @nodoc
class _$LiveSessionStateCopyWithImpl<$Res, $Val extends LiveSessionState>
    implements $LiveSessionStateCopyWith<$Res> {
  _$LiveSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LiveSessionInitialImplCopyWith<$Res> {
  factory _$$LiveSessionInitialImplCopyWith(
    _$LiveSessionInitialImpl value,
    $Res Function(_$LiveSessionInitialImpl) then,
  ) = __$$LiveSessionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LiveSessionInitialImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionInitialImpl>
    implements _$$LiveSessionInitialImplCopyWith<$Res> {
  __$$LiveSessionInitialImplCopyWithImpl(
    _$LiveSessionInitialImpl _value,
    $Res Function(_$LiveSessionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LiveSessionInitialImpl implements LiveSessionInitial {
  const _$LiveSessionInitialImpl();

  @override
  String toString() {
    return 'LiveSessionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LiveSessionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class LiveSessionInitial implements LiveSessionState {
  const factory LiveSessionInitial() = _$LiveSessionInitialImpl;
}

/// @nodoc
abstract class _$$LiveSessionLoadingImplCopyWith<$Res> {
  factory _$$LiveSessionLoadingImplCopyWith(
    _$LiveSessionLoadingImpl value,
    $Res Function(_$LiveSessionLoadingImpl) then,
  ) = __$$LiveSessionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LiveSessionLoadingImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionLoadingImpl>
    implements _$$LiveSessionLoadingImplCopyWith<$Res> {
  __$$LiveSessionLoadingImplCopyWithImpl(
    _$LiveSessionLoadingImpl _value,
    $Res Function(_$LiveSessionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LiveSessionLoadingImpl implements LiveSessionLoading {
  const _$LiveSessionLoadingImpl();

  @override
  String toString() {
    return 'LiveSessionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LiveSessionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LiveSessionLoading implements LiveSessionState {
  const factory LiveSessionLoading() = _$LiveSessionLoadingImpl;
}

/// @nodoc
abstract class _$$LiveSessionLoadedImplCopyWith<$Res> {
  factory _$$LiveSessionLoadedImplCopyWith(
    _$LiveSessionLoadedImpl value,
    $Res Function(_$LiveSessionLoadedImpl) then,
  ) = __$$LiveSessionLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ChatItem> activeCalls});
}

/// @nodoc
class __$$LiveSessionLoadedImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionLoadedImpl>
    implements _$$LiveSessionLoadedImplCopyWith<$Res> {
  __$$LiveSessionLoadedImplCopyWithImpl(
    _$LiveSessionLoadedImpl _value,
    $Res Function(_$LiveSessionLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? activeCalls = null}) {
    return _then(
      _$LiveSessionLoadedImpl(
        null == activeCalls
            ? _value._activeCalls
            : activeCalls // ignore: cast_nullable_to_non_nullable
                as List<ChatItem>,
      ),
    );
  }
}

/// @nodoc

class _$LiveSessionLoadedImpl implements LiveSessionLoaded {
  const _$LiveSessionLoadedImpl(final List<ChatItem> activeCalls)
    : _activeCalls = activeCalls;

  final List<ChatItem> _activeCalls;
  @override
  List<ChatItem> get activeCalls {
    if (_activeCalls is EqualUnmodifiableListView) return _activeCalls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeCalls);
  }

  @override
  String toString() {
    return 'LiveSessionState.loaded(activeCalls: $activeCalls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveSessionLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._activeCalls,
              _activeCalls,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_activeCalls),
  );

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveSessionLoadedImplCopyWith<_$LiveSessionLoadedImpl> get copyWith =>
      __$$LiveSessionLoadedImplCopyWithImpl<_$LiveSessionLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return loaded(activeCalls);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return loaded?.call(activeCalls);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(activeCalls);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LiveSessionLoaded implements LiveSessionState {
  const factory LiveSessionLoaded(final List<ChatItem> activeCalls) =
      _$LiveSessionLoadedImpl;

  List<ChatItem> get activeCalls;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveSessionLoadedImplCopyWith<_$LiveSessionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LiveSessionErrorImplCopyWith<$Res> {
  factory _$$LiveSessionErrorImplCopyWith(
    _$LiveSessionErrorImpl value,
    $Res Function(_$LiveSessionErrorImpl) then,
  ) = __$$LiveSessionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$LiveSessionErrorImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionErrorImpl>
    implements _$$LiveSessionErrorImplCopyWith<$Res> {
  __$$LiveSessionErrorImplCopyWithImpl(
    _$LiveSessionErrorImpl _value,
    $Res Function(_$LiveSessionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$LiveSessionErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as Failure,
      ),
    );
  }

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$LiveSessionErrorImpl implements LiveSessionError {
  const _$LiveSessionErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'LiveSessionState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveSessionErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveSessionErrorImplCopyWith<_$LiveSessionErrorImpl> get copyWith =>
      __$$LiveSessionErrorImplCopyWithImpl<_$LiveSessionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LiveSessionError implements LiveSessionState {
  const factory LiveSessionError(final Failure failure) =
      _$LiveSessionErrorImpl;

  Failure get failure;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveSessionErrorImplCopyWith<_$LiveSessionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LiveSessionJoiningImplCopyWith<$Res> {
  factory _$$LiveSessionJoiningImplCopyWith(
    _$LiveSessionJoiningImpl value,
    $Res Function(_$LiveSessionJoiningImpl) then,
  ) = __$$LiveSessionJoiningImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LiveSessionJoiningImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionJoiningImpl>
    implements _$$LiveSessionJoiningImplCopyWith<$Res> {
  __$$LiveSessionJoiningImplCopyWithImpl(
    _$LiveSessionJoiningImpl _value,
    $Res Function(_$LiveSessionJoiningImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LiveSessionJoiningImpl implements LiveSessionJoining {
  const _$LiveSessionJoiningImpl();

  @override
  String toString() {
    return 'LiveSessionState.joining()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LiveSessionJoiningImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return joining();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return joining?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (joining != null) {
      return joining();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return joining(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return joining?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (joining != null) {
      return joining(this);
    }
    return orElse();
  }
}

abstract class LiveSessionJoining implements LiveSessionState {
  const factory LiveSessionJoining() = _$LiveSessionJoiningImpl;
}

/// @nodoc
abstract class _$$LiveSessionJoinSuccessImplCopyWith<$Res> {
  factory _$$LiveSessionJoinSuccessImplCopyWith(
    _$LiveSessionJoinSuccessImpl value,
    $Res Function(_$LiveSessionJoinSuccessImpl) then,
  ) = __$$LiveSessionJoinSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({JoinCallData joinData});

  $JoinCallDataCopyWith<$Res> get joinData;
}

/// @nodoc
class __$$LiveSessionJoinSuccessImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionJoinSuccessImpl>
    implements _$$LiveSessionJoinSuccessImplCopyWith<$Res> {
  __$$LiveSessionJoinSuccessImplCopyWithImpl(
    _$LiveSessionJoinSuccessImpl _value,
    $Res Function(_$LiveSessionJoinSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? joinData = null}) {
    return _then(
      _$LiveSessionJoinSuccessImpl(
        null == joinData
            ? _value.joinData
            : joinData // ignore: cast_nullable_to_non_nullable
                as JoinCallData,
      ),
    );
  }

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JoinCallDataCopyWith<$Res> get joinData {
    return $JoinCallDataCopyWith<$Res>(_value.joinData, (value) {
      return _then(_value.copyWith(joinData: value));
    });
  }
}

/// @nodoc

class _$LiveSessionJoinSuccessImpl implements LiveSessionJoinSuccess {
  const _$LiveSessionJoinSuccessImpl(this.joinData);

  @override
  final JoinCallData joinData;

  @override
  String toString() {
    return 'LiveSessionState.joinSuccess(joinData: $joinData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveSessionJoinSuccessImpl &&
            (identical(other.joinData, joinData) ||
                other.joinData == joinData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, joinData);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveSessionJoinSuccessImplCopyWith<_$LiveSessionJoinSuccessImpl>
  get copyWith =>
      __$$LiveSessionJoinSuccessImplCopyWithImpl<_$LiveSessionJoinSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return joinSuccess(joinData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return joinSuccess?.call(joinData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (joinSuccess != null) {
      return joinSuccess(joinData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return joinSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return joinSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (joinSuccess != null) {
      return joinSuccess(this);
    }
    return orElse();
  }
}

abstract class LiveSessionJoinSuccess implements LiveSessionState {
  const factory LiveSessionJoinSuccess(final JoinCallData joinData) =
      _$LiveSessionJoinSuccessImpl;

  JoinCallData get joinData;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveSessionJoinSuccessImplCopyWith<_$LiveSessionJoinSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LiveSessionJoinErrorImplCopyWith<$Res> {
  factory _$$LiveSessionJoinErrorImplCopyWith(
    _$LiveSessionJoinErrorImpl value,
    $Res Function(_$LiveSessionJoinErrorImpl) then,
  ) = __$$LiveSessionJoinErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$LiveSessionJoinErrorImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionJoinErrorImpl>
    implements _$$LiveSessionJoinErrorImplCopyWith<$Res> {
  __$$LiveSessionJoinErrorImplCopyWithImpl(
    _$LiveSessionJoinErrorImpl _value,
    $Res Function(_$LiveSessionJoinErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$LiveSessionJoinErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as Failure,
      ),
    );
  }

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$LiveSessionJoinErrorImpl implements LiveSessionJoinError {
  const _$LiveSessionJoinErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'LiveSessionState.joinError(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveSessionJoinErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveSessionJoinErrorImplCopyWith<_$LiveSessionJoinErrorImpl>
  get copyWith =>
      __$$LiveSessionJoinErrorImplCopyWithImpl<_$LiveSessionJoinErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ChatItem> activeCalls) loaded,
    required TResult Function(Failure failure) error,
    required TResult Function() joining,
    required TResult Function(JoinCallData joinData) joinSuccess,
    required TResult Function(Failure failure) joinError,
  }) {
    return joinError(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ChatItem> activeCalls)? loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function()? joining,
    TResult? Function(JoinCallData joinData)? joinSuccess,
    TResult? Function(Failure failure)? joinError,
  }) {
    return joinError?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ChatItem> activeCalls)? loaded,
    TResult Function(Failure failure)? error,
    TResult Function()? joining,
    TResult Function(JoinCallData joinData)? joinSuccess,
    TResult Function(Failure failure)? joinError,
    required TResult orElse(),
  }) {
    if (joinError != null) {
      return joinError(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LiveSessionInitial value) initial,
    required TResult Function(LiveSessionLoading value) loading,
    required TResult Function(LiveSessionLoaded value) loaded,
    required TResult Function(LiveSessionError value) error,
    required TResult Function(LiveSessionJoining value) joining,
    required TResult Function(LiveSessionJoinSuccess value) joinSuccess,
    required TResult Function(LiveSessionJoinError value) joinError,
  }) {
    return joinError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LiveSessionInitial value)? initial,
    TResult? Function(LiveSessionLoading value)? loading,
    TResult? Function(LiveSessionLoaded value)? loaded,
    TResult? Function(LiveSessionError value)? error,
    TResult? Function(LiveSessionJoining value)? joining,
    TResult? Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult? Function(LiveSessionJoinError value)? joinError,
  }) {
    return joinError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LiveSessionInitial value)? initial,
    TResult Function(LiveSessionLoading value)? loading,
    TResult Function(LiveSessionLoaded value)? loaded,
    TResult Function(LiveSessionError value)? error,
    TResult Function(LiveSessionJoining value)? joining,
    TResult Function(LiveSessionJoinSuccess value)? joinSuccess,
    TResult Function(LiveSessionJoinError value)? joinError,
    required TResult orElse(),
  }) {
    if (joinError != null) {
      return joinError(this);
    }
    return orElse();
  }
}

abstract class LiveSessionJoinError implements LiveSessionState {
  const factory LiveSessionJoinError(final Failure failure) =
      _$LiveSessionJoinErrorImpl;

  Failure get failure;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveSessionJoinErrorImplCopyWith<_$LiveSessionJoinErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
