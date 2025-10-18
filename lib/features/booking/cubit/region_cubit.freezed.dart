// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RegionModel> clinics) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RegionModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RegionModel> clinics)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegionInitial value) initial,
    required TResult Function(RegionLoading value) loading,
    required TResult Function(RegionLoaded value) loaded,
    required TResult Function(RegionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegionInitial value)? initial,
    TResult? Function(RegionLoading value)? loading,
    TResult? Function(RegionLoaded value)? loaded,
    TResult? Function(RegionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegionInitial value)? initial,
    TResult Function(RegionLoading value)? loading,
    TResult Function(RegionLoaded value)? loaded,
    TResult Function(RegionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionStateCopyWith<$Res> {
  factory $RegionStateCopyWith(
          RegionState value, $Res Function(RegionState) then) =
      _$RegionStateCopyWithImpl<$Res, RegionState>;
}

/// @nodoc
class _$RegionStateCopyWithImpl<$Res, $Val extends RegionState>
    implements $RegionStateCopyWith<$Res> {
  _$RegionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegionInitialImplCopyWith<$Res> {
  factory _$$RegionInitialImplCopyWith(
          _$RegionInitialImpl value, $Res Function(_$RegionInitialImpl) then) =
      __$$RegionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegionInitialImplCopyWithImpl<$Res>
    extends _$RegionStateCopyWithImpl<$Res, _$RegionInitialImpl>
    implements _$$RegionInitialImplCopyWith<$Res> {
  __$$RegionInitialImplCopyWithImpl(
      _$RegionInitialImpl _value, $Res Function(_$RegionInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegionInitialImpl implements RegionInitial {
  const _$RegionInitialImpl();

  @override
  String toString() {
    return 'RegionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RegionModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RegionModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RegionModel> clinics)? loaded,
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
    required TResult Function(RegionInitial value) initial,
    required TResult Function(RegionLoading value) loading,
    required TResult Function(RegionLoaded value) loaded,
    required TResult Function(RegionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegionInitial value)? initial,
    TResult? Function(RegionLoading value)? loading,
    TResult? Function(RegionLoaded value)? loaded,
    TResult? Function(RegionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegionInitial value)? initial,
    TResult Function(RegionLoading value)? loading,
    TResult Function(RegionLoaded value)? loaded,
    TResult Function(RegionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RegionInitial implements RegionState {
  const factory RegionInitial() = _$RegionInitialImpl;
}

/// @nodoc
abstract class _$$RegionLoadingImplCopyWith<$Res> {
  factory _$$RegionLoadingImplCopyWith(
          _$RegionLoadingImpl value, $Res Function(_$RegionLoadingImpl) then) =
      __$$RegionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegionLoadingImplCopyWithImpl<$Res>
    extends _$RegionStateCopyWithImpl<$Res, _$RegionLoadingImpl>
    implements _$$RegionLoadingImplCopyWith<$Res> {
  __$$RegionLoadingImplCopyWithImpl(
      _$RegionLoadingImpl _value, $Res Function(_$RegionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegionLoadingImpl implements RegionLoading {
  const _$RegionLoadingImpl();

  @override
  String toString() {
    return 'RegionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RegionModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RegionModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RegionModel> clinics)? loaded,
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
    required TResult Function(RegionInitial value) initial,
    required TResult Function(RegionLoading value) loading,
    required TResult Function(RegionLoaded value) loaded,
    required TResult Function(RegionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegionInitial value)? initial,
    TResult? Function(RegionLoading value)? loading,
    TResult? Function(RegionLoaded value)? loaded,
    TResult? Function(RegionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegionInitial value)? initial,
    TResult Function(RegionLoading value)? loading,
    TResult Function(RegionLoaded value)? loaded,
    TResult Function(RegionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RegionLoading implements RegionState {
  const factory RegionLoading() = _$RegionLoadingImpl;
}

/// @nodoc
abstract class _$$RegionLoadedImplCopyWith<$Res> {
  factory _$$RegionLoadedImplCopyWith(
          _$RegionLoadedImpl value, $Res Function(_$RegionLoadedImpl) then) =
      __$$RegionLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RegionModel> clinics});
}

/// @nodoc
class __$$RegionLoadedImplCopyWithImpl<$Res>
    extends _$RegionStateCopyWithImpl<$Res, _$RegionLoadedImpl>
    implements _$$RegionLoadedImplCopyWith<$Res> {
  __$$RegionLoadedImplCopyWithImpl(
      _$RegionLoadedImpl _value, $Res Function(_$RegionLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinics = null,
  }) {
    return _then(_$RegionLoadedImpl(
      null == clinics
          ? _value._clinics
          : clinics // ignore: cast_nullable_to_non_nullable
              as List<RegionModel>,
    ));
  }
}

/// @nodoc

class _$RegionLoadedImpl implements RegionLoaded {
  const _$RegionLoadedImpl(final List<RegionModel> clinics)
      : _clinics = clinics;

  final List<RegionModel> _clinics;
  @override
  List<RegionModel> get clinics {
    if (_clinics is EqualUnmodifiableListView) return _clinics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinics);
  }

  @override
  String toString() {
    return 'RegionState.loaded(clinics: $clinics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionLoadedImpl &&
            const DeepCollectionEquality().equals(other._clinics, _clinics));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_clinics));

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionLoadedImplCopyWith<_$RegionLoadedImpl> get copyWith =>
      __$$RegionLoadedImplCopyWithImpl<_$RegionLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RegionModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(clinics);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RegionModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(clinics);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RegionModel> clinics)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(clinics);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegionInitial value) initial,
    required TResult Function(RegionLoading value) loading,
    required TResult Function(RegionLoaded value) loaded,
    required TResult Function(RegionError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegionInitial value)? initial,
    TResult? Function(RegionLoading value)? loading,
    TResult? Function(RegionLoaded value)? loaded,
    TResult? Function(RegionError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegionInitial value)? initial,
    TResult Function(RegionLoading value)? loading,
    TResult Function(RegionLoaded value)? loaded,
    TResult Function(RegionError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class RegionLoaded implements RegionState {
  const factory RegionLoaded(final List<RegionModel> clinics) =
      _$RegionLoadedImpl;

  List<RegionModel> get clinics;

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionLoadedImplCopyWith<_$RegionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegionErrorImplCopyWith<$Res> {
  factory _$$RegionErrorImplCopyWith(
          _$RegionErrorImpl value, $Res Function(_$RegionErrorImpl) then) =
      __$$RegionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RegionErrorImplCopyWithImpl<$Res>
    extends _$RegionStateCopyWithImpl<$Res, _$RegionErrorImpl>
    implements _$$RegionErrorImplCopyWith<$Res> {
  __$$RegionErrorImplCopyWithImpl(
      _$RegionErrorImpl _value, $Res Function(_$RegionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RegionErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegionErrorImpl implements RegionError {
  const _$RegionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RegionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionErrorImplCopyWith<_$RegionErrorImpl> get copyWith =>
      __$$RegionErrorImplCopyWithImpl<_$RegionErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RegionModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RegionModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RegionModel> clinics)? loaded,
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
    required TResult Function(RegionInitial value) initial,
    required TResult Function(RegionLoading value) loading,
    required TResult Function(RegionLoaded value) loaded,
    required TResult Function(RegionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegionInitial value)? initial,
    TResult? Function(RegionLoading value)? loading,
    TResult? Function(RegionLoaded value)? loaded,
    TResult? Function(RegionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegionInitial value)? initial,
    TResult Function(RegionLoading value)? loading,
    TResult Function(RegionLoaded value)? loaded,
    TResult Function(RegionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RegionError implements RegionState {
  const factory RegionError(final String message) = _$RegionErrorImpl;

  String get message;

  /// Create a copy of RegionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionErrorImplCopyWith<_$RegionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
