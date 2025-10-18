// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) {
  return _DoctorModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get specialization => throw _privateConstructorUsedError;
  String get clinic => throw _privateConstructorUsedError;

  /// Serializes this DoctorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorModelCopyWith<DoctorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorModelCopyWith<$Res> {
  factory $DoctorModelCopyWith(
          DoctorModel value, $Res Function(DoctorModel) then) =
      _$DoctorModelCopyWithImpl<$Res, DoctorModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String specialization,
      String clinic});
}

/// @nodoc
class _$DoctorModelCopyWithImpl<$Res, $Val extends DoctorModel>
    implements $DoctorModelCopyWith<$Res> {
  _$DoctorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specialization = null,
    Object? clinic = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specialization: null == specialization
          ? _value.specialization
          : specialization // ignore: cast_nullable_to_non_nullable
              as String,
      clinic: null == clinic
          ? _value.clinic
          : clinic // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorModelImplCopyWith<$Res>
    implements $DoctorModelCopyWith<$Res> {
  factory _$$DoctorModelImplCopyWith(
          _$DoctorModelImpl value, $Res Function(_$DoctorModelImpl) then) =
      __$$DoctorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String specialization,
      String clinic});
}

/// @nodoc
class __$$DoctorModelImplCopyWithImpl<$Res>
    extends _$DoctorModelCopyWithImpl<$Res, _$DoctorModelImpl>
    implements _$$DoctorModelImplCopyWith<$Res> {
  __$$DoctorModelImplCopyWithImpl(
      _$DoctorModelImpl _value, $Res Function(_$DoctorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specialization = null,
    Object? clinic = null,
  }) {
    return _then(_$DoctorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specialization: null == specialization
          ? _value.specialization
          : specialization // ignore: cast_nullable_to_non_nullable
              as String,
      clinic: null == clinic
          ? _value.clinic
          : clinic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorModelImpl implements _DoctorModel {
  const _$DoctorModelImpl(
      {@JsonKey(name: '_id') this.id = "",
      this.name = "",
      this.specialization = "",
      this.clinic = ""});

  factory _$DoctorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String specialization;
  @override
  @JsonKey()
  final String clinic;

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, specialization: $specialization, clinic: $clinic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.specialization, specialization) ||
                other.specialization == specialization) &&
            (identical(other.clinic, clinic) || other.clinic == clinic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, specialization, clinic);

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      __$$DoctorModelImplCopyWithImpl<_$DoctorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorModelImplToJson(
      this,
    );
  }
}

abstract class _DoctorModel implements DoctorModel {
  const factory _DoctorModel(
      {@JsonKey(name: '_id') final String id,
      final String name,
      final String specialization,
      final String clinic}) = _$DoctorModelImpl;

  factory _DoctorModel.fromJson(Map<String, dynamic> json) =
      _$DoctorModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get specialization;
  @override
  String get clinic;

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
