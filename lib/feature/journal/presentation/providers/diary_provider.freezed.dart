// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DiaryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryStateCopyWith<$Res> {
  factory $DiaryStateCopyWith(
    DiaryState value,
    $Res Function(DiaryState) then,
  ) = _$DiaryStateCopyWithImpl<$Res, DiaryState>;
}

/// @nodoc
class _$DiaryStateCopyWithImpl<$Res, $Val extends DiaryState>
    implements $DiaryStateCopyWith<$Res> {
  _$DiaryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DiaryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
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
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements DiaryState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'DiaryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
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
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements DiaryState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<DiaryEntry> entries,
    Pagination pagination,
    bool canLoadMore,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? pagination = null,
    Object? canLoadMore = null,
  }) {
    return _then(
      _$LoadedImpl(
        null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                as List<DiaryEntry>,
        null == pagination
            ? _value.pagination
            : pagination // ignore: cast_nullable_to_non_nullable
                as Pagination,
        null == canLoadMore
            ? _value.canLoadMore
            : canLoadMore // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements Loaded {
  const _$LoadedImpl(
    final List<DiaryEntry> entries,
    this.pagination,
    this.canLoadMore,
  ) : _entries = entries;

  final List<DiaryEntry> _entries;
  @override
  List<DiaryEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final Pagination pagination;
  @override
  final bool canLoadMore;

  @override
  String toString() {
    return 'DiaryState.loaded(entries: $entries, pagination: $pagination, canLoadMore: $canLoadMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.canLoadMore, canLoadMore) ||
                other.canLoadMore == canLoadMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    pagination,
    canLoadMore,
  );

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(entries, pagination, canLoadMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(entries, pagination, canLoadMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entries, pagination, canLoadMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements DiaryState {
  const factory Loaded(
    final List<DiaryEntry> entries,
    final Pagination pagination,
    final bool canLoadMore,
  ) = _$LoadedImpl;

  List<DiaryEntry> get entries;
  Pagination get pagination;
  bool get canLoadMore;

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OperationLoadingImplCopyWith<$Res> {
  factory _$$OperationLoadingImplCopyWith(
    _$OperationLoadingImpl value,
    $Res Function(_$OperationLoadingImpl) then,
  ) = __$$OperationLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String operationType});
}

/// @nodoc
class __$$OperationLoadingImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$OperationLoadingImpl>
    implements _$$OperationLoadingImplCopyWith<$Res> {
  __$$OperationLoadingImplCopyWithImpl(
    _$OperationLoadingImpl _value,
    $Res Function(_$OperationLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? operationType = null}) {
    return _then(
      _$OperationLoadingImpl(
        null == operationType
            ? _value.operationType
            : operationType // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$OperationLoadingImpl implements OperationLoading {
  const _$OperationLoadingImpl(this.operationType);

  @override
  final String operationType;

  @override
  String toString() {
    return 'DiaryState.operationLoading(operationType: $operationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationLoadingImpl &&
            (identical(other.operationType, operationType) ||
                other.operationType == operationType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, operationType);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationLoadingImplCopyWith<_$OperationLoadingImpl> get copyWith =>
      __$$OperationLoadingImplCopyWithImpl<_$OperationLoadingImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return operationLoading(operationType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return operationLoading?.call(operationType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (operationLoading != null) {
      return operationLoading(operationType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return operationLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return operationLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (operationLoading != null) {
      return operationLoading(this);
    }
    return orElse();
  }
}

abstract class OperationLoading implements DiaryState {
  const factory OperationLoading(final String operationType) =
      _$OperationLoadingImpl;

  String get operationType;

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationLoadingImplCopyWith<_$OperationLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OperationSuccessImplCopyWith<$Res> {
  factory _$$OperationSuccessImplCopyWith(
    _$OperationSuccessImpl value,
    $Res Function(_$OperationSuccessImpl) then,
  ) = __$$OperationSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$OperationSuccessImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$OperationSuccessImpl>
    implements _$$OperationSuccessImplCopyWith<$Res> {
  __$$OperationSuccessImplCopyWithImpl(
    _$OperationSuccessImpl _value,
    $Res Function(_$OperationSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$OperationSuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$OperationSuccessImpl implements OperationSuccess {
  const _$OperationSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'DiaryState.operationSuccess(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationSuccessImplCopyWith<_$OperationSuccessImpl> get copyWith =>
      __$$OperationSuccessImplCopyWithImpl<_$OperationSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return operationSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return operationSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return operationSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return operationSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess(this);
    }
    return orElse();
  }
}

abstract class OperationSuccess implements DiaryState {
  const factory OperationSuccess(final String message) = _$OperationSuccessImpl;

  String get message;

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationSuccessImplCopyWith<_$OperationSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$ErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as Failure,
      ),
    );
  }

  /// Create a copy of DiaryState
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

class _$ErrorImpl implements Error {
  const _$ErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'DiaryState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )
    loaded,
    required TResult Function(String operationType) operationLoading,
    required TResult Function(String message) operationSuccess,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult? Function(String operationType)? operationLoading,
    TResult? Function(String message)? operationSuccess,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<DiaryEntry> entries,
      Pagination pagination,
      bool canLoadMore,
    )?
    loaded,
    TResult Function(String operationType)? operationLoading,
    TResult Function(String message)? operationSuccess,
    TResult Function(Failure failure)? error,
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
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(OperationLoading value) operationLoading,
    required TResult Function(OperationSuccess value) operationSuccess,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(OperationLoading value)? operationLoading,
    TResult? Function(OperationSuccess value)? operationSuccess,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(OperationLoading value)? operationLoading,
    TResult Function(OperationSuccess value)? operationSuccess,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements DiaryState {
  const factory Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of DiaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
