// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) {
  return _ClinicModel.fromJson(json);
}

/// @nodoc
mixin _$ClinicModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  List<DoctorModel> get doctors => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int? get version => throw _privateConstructorUsedError;

  /// Serializes this ClinicModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicModelCopyWith<ClinicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicModelCopyWith<$Res> {
  factory $ClinicModelCopyWith(
          ClinicModel value, $Res Function(ClinicModel) then) =
      _$ClinicModelCopyWithImpl<$Res, ClinicModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String description,
      String image,
      String city,
      String region,
      String username,
      String password,
      List<DoctorModel> doctors,
      String status,
      DateTime? createdAt,
      @JsonKey(name: '__v') int? version});
}

/// @nodoc
class _$ClinicModelCopyWithImpl<$Res, $Val extends ClinicModel>
    implements $ClinicModelCopyWith<$Res> {
  _$ClinicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? city = null,
    Object? region = null,
    Object? username = null,
    Object? password = null,
    Object? doctors = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      doctors: null == doctors
          ? _value.doctors
          : doctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicModelImplCopyWith<$Res>
    implements $ClinicModelCopyWith<$Res> {
  factory _$$ClinicModelImplCopyWith(
          _$ClinicModelImpl value, $Res Function(_$ClinicModelImpl) then) =
      __$$ClinicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String description,
      String image,
      String city,
      String region,
      String username,
      String password,
      List<DoctorModel> doctors,
      String status,
      DateTime? createdAt,
      @JsonKey(name: '__v') int? version});
}

/// @nodoc
class __$$ClinicModelImplCopyWithImpl<$Res>
    extends _$ClinicModelCopyWithImpl<$Res, _$ClinicModelImpl>
    implements _$$ClinicModelImplCopyWith<$Res> {
  __$$ClinicModelImplCopyWithImpl(
      _$ClinicModelImpl _value, $Res Function(_$ClinicModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? city = null,
    Object? region = null,
    Object? username = null,
    Object? password = null,
    Object? doctors = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? version = freezed,
  }) {
    return _then(_$ClinicModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      doctors: null == doctors
          ? _value._doctors
          : doctors // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicModelImpl implements _ClinicModel {
  const _$ClinicModelImpl(
      {@JsonKey(name: '_id') this.id = "",
      this.title = "",
      this.description = "",
      this.image = "",
      this.city = "",
      this.region = "",
      this.username = "",
      this.password = "",
      final List<DoctorModel> doctors = const [],
      this.status = "",
      this.createdAt,
      @JsonKey(name: '__v') this.version})
      : _doctors = doctors;

  factory _$ClinicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String region;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String password;
  final List<DoctorModel> _doctors;
  @override
  @JsonKey()
  List<DoctorModel> get doctors {
    if (_doctors is EqualUnmodifiableListView) return _doctors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doctors);
  }

  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey(name: '__v')
  final int? version;

  @override
  String toString() {
    return 'ClinicModel(id: $id, title: $title, description: $description, image: $image, city: $city, region: $region, username: $username, password: $password, doctors: $doctors, status: $status, createdAt: $createdAt, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            const DeepCollectionEquality().equals(other._doctors, _doctors) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      image,
      city,
      region,
      username,
      password,
      const DeepCollectionEquality().hash(_doctors),
      status,
      createdAt,
      version);

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicModelImplCopyWith<_$ClinicModelImpl> get copyWith =>
      __$$ClinicModelImplCopyWithImpl<_$ClinicModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicModelImplToJson(
      this,
    );
  }
}

abstract class _ClinicModel implements ClinicModel {
  const factory _ClinicModel(
      {@JsonKey(name: '_id') final String id,
      final String title,
      final String description,
      final String image,
      final String city,
      final String region,
      final String username,
      final String password,
      final List<DoctorModel> doctors,
      final String status,
      final DateTime? createdAt,
      @JsonKey(name: '__v') final int? version}) = _$ClinicModelImpl;

  factory _ClinicModel.fromJson(Map<String, dynamic> json) =
      _$ClinicModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get image;
  @override
  String get city;
  @override
  String get region;
  @override
  String get username;
  @override
  String get password;
  @override
  List<DoctorModel> get doctors;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(name: '__v')
  int? get version;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicModelImplCopyWith<_$ClinicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
