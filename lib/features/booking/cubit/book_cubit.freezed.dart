// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookInitial value) initial,
    required TResult Function(BookLoading value) loading,
    required TResult Function(BookSuccess value) success,
    required TResult Function(BookError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookInitial value)? initial,
    TResult? Function(BookLoading value)? loading,
    TResult? Function(BookSuccess value)? success,
    TResult? Function(BookError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookInitial value)? initial,
    TResult Function(BookLoading value)? loading,
    TResult Function(BookSuccess value)? success,
    TResult Function(BookError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookStateCopyWith<$Res> {
  factory $BookStateCopyWith(BookState value, $Res Function(BookState) then) =
      _$BookStateCopyWithImpl<$Res, BookState>;
}

/// @nodoc
class _$BookStateCopyWithImpl<$Res, $Val extends BookState>
    implements $BookStateCopyWith<$Res> {
  _$BookStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BookInitialImplCopyWith<$Res> {
  factory _$$BookInitialImplCopyWith(
          _$BookInitialImpl value, $Res Function(_$BookInitialImpl) then) =
      __$$BookInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookInitialImplCopyWithImpl<$Res>
    extends _$BookStateCopyWithImpl<$Res, _$BookInitialImpl>
    implements _$$BookInitialImplCopyWith<$Res> {
  __$$BookInitialImplCopyWithImpl(
      _$BookInitialImpl _value, $Res Function(_$BookInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BookInitialImpl implements BookInitial {
  const _$BookInitialImpl();

  @override
  String toString() {
    return 'BookState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
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
    required TResult Function(BookInitial value) initial,
    required TResult Function(BookLoading value) loading,
    required TResult Function(BookSuccess value) success,
    required TResult Function(BookError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookInitial value)? initial,
    TResult? Function(BookLoading value)? loading,
    TResult? Function(BookSuccess value)? success,
    TResult? Function(BookError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookInitial value)? initial,
    TResult Function(BookLoading value)? loading,
    TResult Function(BookSuccess value)? success,
    TResult Function(BookError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BookInitial implements BookState {
  const factory BookInitial() = _$BookInitialImpl;
}

/// @nodoc
abstract class _$$BookLoadingImplCopyWith<$Res> {
  factory _$$BookLoadingImplCopyWith(
          _$BookLoadingImpl value, $Res Function(_$BookLoadingImpl) then) =
      __$$BookLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookLoadingImplCopyWithImpl<$Res>
    extends _$BookStateCopyWithImpl<$Res, _$BookLoadingImpl>
    implements _$$BookLoadingImplCopyWith<$Res> {
  __$$BookLoadingImplCopyWithImpl(
      _$BookLoadingImpl _value, $Res Function(_$BookLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BookLoadingImpl implements BookLoading {
  const _$BookLoadingImpl();

  @override
  String toString() {
    return 'BookState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
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
    required TResult Function(BookInitial value) initial,
    required TResult Function(BookLoading value) loading,
    required TResult Function(BookSuccess value) success,
    required TResult Function(BookError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookInitial value)? initial,
    TResult? Function(BookLoading value)? loading,
    TResult? Function(BookSuccess value)? success,
    TResult? Function(BookError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookInitial value)? initial,
    TResult Function(BookLoading value)? loading,
    TResult Function(BookSuccess value)? success,
    TResult Function(BookError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BookLoading implements BookState {
  const factory BookLoading() = _$BookLoadingImpl;
}

/// @nodoc
abstract class _$$BookSuccessImplCopyWith<$Res> {
  factory _$$BookSuccessImplCopyWith(
          _$BookSuccessImpl value, $Res Function(_$BookSuccessImpl) then) =
      __$$BookSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookSuccessImplCopyWithImpl<$Res>
    extends _$BookStateCopyWithImpl<$Res, _$BookSuccessImpl>
    implements _$$BookSuccessImplCopyWith<$Res> {
  __$$BookSuccessImplCopyWithImpl(
      _$BookSuccessImpl _value, $Res Function(_$BookSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BookSuccessImpl implements BookSuccess {
  const _$BookSuccessImpl();

  @override
  String toString() {
    return 'BookState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookInitial value) initial,
    required TResult Function(BookLoading value) loading,
    required TResult Function(BookSuccess value) success,
    required TResult Function(BookError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookInitial value)? initial,
    TResult? Function(BookLoading value)? loading,
    TResult? Function(BookSuccess value)? success,
    TResult? Function(BookError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookInitial value)? initial,
    TResult Function(BookLoading value)? loading,
    TResult Function(BookSuccess value)? success,
    TResult Function(BookError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class BookSuccess implements BookState {
  const factory BookSuccess() = _$BookSuccessImpl;
}

/// @nodoc
abstract class _$$BookErrorImplCopyWith<$Res> {
  factory _$$BookErrorImplCopyWith(
          _$BookErrorImpl value, $Res Function(_$BookErrorImpl) then) =
      __$$BookErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BookErrorImplCopyWithImpl<$Res>
    extends _$BookStateCopyWithImpl<$Res, _$BookErrorImpl>
    implements _$$BookErrorImplCopyWith<$Res> {
  __$$BookErrorImplCopyWithImpl(
      _$BookErrorImpl _value, $Res Function(_$BookErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BookErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BookErrorImpl implements BookError {
  const _$BookErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BookState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookErrorImplCopyWith<_$BookErrorImpl> get copyWith =>
      __$$BookErrorImplCopyWithImpl<_$BookErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BookInitial value) initial,
    required TResult Function(BookLoading value) loading,
    required TResult Function(BookSuccess value) success,
    required TResult Function(BookError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BookInitial value)? initial,
    TResult? Function(BookLoading value)? loading,
    TResult? Function(BookSuccess value)? success,
    TResult? Function(BookError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BookInitial value)? initial,
    TResult Function(BookLoading value)? loading,
    TResult Function(BookSuccess value)? success,
    TResult Function(BookError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BookError implements BookState {
  const factory BookError(final String message) = _$BookErrorImpl;

  String get message;

  /// Create a copy of BookState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookErrorImplCopyWith<_$BookErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
