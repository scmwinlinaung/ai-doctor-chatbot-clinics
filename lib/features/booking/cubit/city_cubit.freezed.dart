// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CityModel> clinics) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CityModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CityModel> clinics)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityInitial value) initial,
    required TResult Function(CityLoading value) loading,
    required TResult Function(CityLoaded value) loaded,
    required TResult Function(CityError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityInitial value)? initial,
    TResult? Function(CityLoading value)? loading,
    TResult? Function(CityLoaded value)? loaded,
    TResult? Function(CityError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityInitial value)? initial,
    TResult Function(CityLoading value)? loading,
    TResult Function(CityLoaded value)? loaded,
    TResult Function(CityError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityStateCopyWith<$Res> {
  factory $CityStateCopyWith(CityState value, $Res Function(CityState) then) =
      _$CityStateCopyWithImpl<$Res, CityState>;
}

/// @nodoc
class _$CityStateCopyWithImpl<$Res, $Val extends CityState>
    implements $CityStateCopyWith<$Res> {
  _$CityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CityInitialImplCopyWith<$Res> {
  factory _$$CityInitialImplCopyWith(
          _$CityInitialImpl value, $Res Function(_$CityInitialImpl) then) =
      __$$CityInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CityInitialImplCopyWithImpl<$Res>
    extends _$CityStateCopyWithImpl<$Res, _$CityInitialImpl>
    implements _$$CityInitialImplCopyWith<$Res> {
  __$$CityInitialImplCopyWithImpl(
      _$CityInitialImpl _value, $Res Function(_$CityInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CityInitialImpl implements CityInitial {
  const _$CityInitialImpl();

  @override
  String toString() {
    return 'CityState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CityInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CityModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CityModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CityModel> clinics)? loaded,
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
    required TResult Function(CityInitial value) initial,
    required TResult Function(CityLoading value) loading,
    required TResult Function(CityLoaded value) loaded,
    required TResult Function(CityError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityInitial value)? initial,
    TResult? Function(CityLoading value)? loading,
    TResult? Function(CityLoaded value)? loaded,
    TResult? Function(CityError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityInitial value)? initial,
    TResult Function(CityLoading value)? loading,
    TResult Function(CityLoaded value)? loaded,
    TResult Function(CityError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CityInitial implements CityState {
  const factory CityInitial() = _$CityInitialImpl;
}

/// @nodoc
abstract class _$$CityLoadingImplCopyWith<$Res> {
  factory _$$CityLoadingImplCopyWith(
          _$CityLoadingImpl value, $Res Function(_$CityLoadingImpl) then) =
      __$$CityLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CityLoadingImplCopyWithImpl<$Res>
    extends _$CityStateCopyWithImpl<$Res, _$CityLoadingImpl>
    implements _$$CityLoadingImplCopyWith<$Res> {
  __$$CityLoadingImplCopyWithImpl(
      _$CityLoadingImpl _value, $Res Function(_$CityLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CityLoadingImpl implements CityLoading {
  const _$CityLoadingImpl();

  @override
  String toString() {
    return 'CityState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CityLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CityModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CityModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CityModel> clinics)? loaded,
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
    required TResult Function(CityInitial value) initial,
    required TResult Function(CityLoading value) loading,
    required TResult Function(CityLoaded value) loaded,
    required TResult Function(CityError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityInitial value)? initial,
    TResult? Function(CityLoading value)? loading,
    TResult? Function(CityLoaded value)? loaded,
    TResult? Function(CityError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityInitial value)? initial,
    TResult Function(CityLoading value)? loading,
    TResult Function(CityLoaded value)? loaded,
    TResult Function(CityError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CityLoading implements CityState {
  const factory CityLoading() = _$CityLoadingImpl;
}

/// @nodoc
abstract class _$$CityLoadedImplCopyWith<$Res> {
  factory _$$CityLoadedImplCopyWith(
          _$CityLoadedImpl value, $Res Function(_$CityLoadedImpl) then) =
      __$$CityLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CityModel> clinics});
}

/// @nodoc
class __$$CityLoadedImplCopyWithImpl<$Res>
    extends _$CityStateCopyWithImpl<$Res, _$CityLoadedImpl>
    implements _$$CityLoadedImplCopyWith<$Res> {
  __$$CityLoadedImplCopyWithImpl(
      _$CityLoadedImpl _value, $Res Function(_$CityLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinics = null,
  }) {
    return _then(_$CityLoadedImpl(
      null == clinics
          ? _value._clinics
          : clinics // ignore: cast_nullable_to_non_nullable
              as List<CityModel>,
    ));
  }
}

/// @nodoc

class _$CityLoadedImpl implements CityLoaded {
  const _$CityLoadedImpl(final List<CityModel> clinics) : _clinics = clinics;

  final List<CityModel> _clinics;
  @override
  List<CityModel> get clinics {
    if (_clinics is EqualUnmodifiableListView) return _clinics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clinics);
  }

  @override
  String toString() {
    return 'CityState.loaded(clinics: $clinics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityLoadedImpl &&
            const DeepCollectionEquality().equals(other._clinics, _clinics));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_clinics));

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityLoadedImplCopyWith<_$CityLoadedImpl> get copyWith =>
      __$$CityLoadedImplCopyWithImpl<_$CityLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CityModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(clinics);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CityModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(clinics);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CityModel> clinics)? loaded,
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
    required TResult Function(CityInitial value) initial,
    required TResult Function(CityLoading value) loading,
    required TResult Function(CityLoaded value) loaded,
    required TResult Function(CityError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityInitial value)? initial,
    TResult? Function(CityLoading value)? loading,
    TResult? Function(CityLoaded value)? loaded,
    TResult? Function(CityError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityInitial value)? initial,
    TResult Function(CityLoading value)? loading,
    TResult Function(CityLoaded value)? loaded,
    TResult Function(CityError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CityLoaded implements CityState {
  const factory CityLoaded(final List<CityModel> clinics) = _$CityLoadedImpl;

  List<CityModel> get clinics;

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityLoadedImplCopyWith<_$CityLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CityErrorImplCopyWith<$Res> {
  factory _$$CityErrorImplCopyWith(
          _$CityErrorImpl value, $Res Function(_$CityErrorImpl) then) =
      __$$CityErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CityErrorImplCopyWithImpl<$Res>
    extends _$CityStateCopyWithImpl<$Res, _$CityErrorImpl>
    implements _$$CityErrorImplCopyWith<$Res> {
  __$$CityErrorImplCopyWithImpl(
      _$CityErrorImpl _value, $Res Function(_$CityErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CityErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CityErrorImpl implements CityError {
  const _$CityErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CityState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityErrorImplCopyWith<_$CityErrorImpl> get copyWith =>
      __$$CityErrorImplCopyWithImpl<_$CityErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CityModel> clinics) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CityModel> clinics)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CityModel> clinics)? loaded,
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
    required TResult Function(CityInitial value) initial,
    required TResult Function(CityLoading value) loading,
    required TResult Function(CityLoaded value) loaded,
    required TResult Function(CityError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityInitial value)? initial,
    TResult? Function(CityLoading value)? loading,
    TResult? Function(CityLoaded value)? loaded,
    TResult? Function(CityError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityInitial value)? initial,
    TResult Function(CityLoading value)? loading,
    TResult Function(CityLoaded value)? loaded,
    TResult Function(CityError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CityError implements CityState {
  const factory CityError(final String message) = _$CityErrorImpl;

  String get message;

  /// Create a copy of CityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityErrorImplCopyWith<_$CityErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
