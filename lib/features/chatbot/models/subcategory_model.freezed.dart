// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subcategory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubcategoryModel _$SubcategoryModelFromJson(Map<String, dynamic> json) {
  return _SubcategoryModel.fromJson(json);
}

/// @nodoc
mixin _$SubcategoryModel {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  LocalizedStringModel get name => throw _privateConstructorUsedError;

  /// Serializes this SubcategoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubcategoryModelCopyWith<SubcategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubcategoryModelCopyWith<$Res> {
  factory $SubcategoryModelCopyWith(
          SubcategoryModel value, $Res Function(SubcategoryModel) then) =
      _$SubcategoryModelCopyWithImpl<$Res, SubcategoryModel>;
  @useResult
  $Res call({@JsonKey(name: "_id") String id, LocalizedStringModel name});

  $LocalizedStringModelCopyWith<$Res> get name;
}

/// @nodoc
class _$SubcategoryModelCopyWithImpl<$Res, $Val extends SubcategoryModel>
    implements $SubcategoryModelCopyWith<$Res> {
  _$SubcategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
    ) as $Val);
  }

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalizedStringModelCopyWith<$Res> get name {
    return $LocalizedStringModelCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubcategoryModelImplCopyWith<$Res>
    implements $SubcategoryModelCopyWith<$Res> {
  factory _$$SubcategoryModelImplCopyWith(_$SubcategoryModelImpl value,
          $Res Function(_$SubcategoryModelImpl) then) =
      __$$SubcategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "_id") String id, LocalizedStringModel name});

  @override
  $LocalizedStringModelCopyWith<$Res> get name;
}

/// @nodoc
class __$$SubcategoryModelImplCopyWithImpl<$Res>
    extends _$SubcategoryModelCopyWithImpl<$Res, _$SubcategoryModelImpl>
    implements _$$SubcategoryModelImplCopyWith<$Res> {
  __$$SubcategoryModelImplCopyWithImpl(_$SubcategoryModelImpl _value,
      $Res Function(_$SubcategoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$SubcategoryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubcategoryModelImpl implements _SubcategoryModel {
  const _$SubcategoryModelImpl(
      {@JsonKey(name: "_id") this.id = "",
      this.name = const LocalizedStringModel(en: "", mm: "")});

  factory _$SubcategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubcategoryModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  @JsonKey()
  final LocalizedStringModel name;

  @override
  String toString() {
    return 'SubcategoryModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubcategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubcategoryModelImplCopyWith<_$SubcategoryModelImpl> get copyWith =>
      __$$SubcategoryModelImplCopyWithImpl<_$SubcategoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubcategoryModelImplToJson(
      this,
    );
  }
}

abstract class _SubcategoryModel implements SubcategoryModel {
  const factory _SubcategoryModel(
      {@JsonKey(name: "_id") final String id,
      final LocalizedStringModel name}) = _$SubcategoryModelImpl;

  factory _SubcategoryModel.fromJson(Map<String, dynamic> json) =
      _$SubcategoryModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  LocalizedStringModel get name;

  /// Create a copy of SubcategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubcategoryModelImplCopyWith<_$SubcategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
