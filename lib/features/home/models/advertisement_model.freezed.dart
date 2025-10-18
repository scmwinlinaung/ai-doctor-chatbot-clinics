// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advertisement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdvertisementModel _$AdvertisementModelFromJson(Map<String, dynamic> json) {
  return _AdvertisementModel.fromJson(json);
}

/// @nodoc
mixin _$AdvertisementModel {
  String get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get fromDate => throw _privateConstructorUsedError;
  String get toDate => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  bool? get endingSoon => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  /// Serializes this AdvertisementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdvertisementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvertisementModelCopyWith<AdvertisementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvertisementModelCopyWith<$Res> {
  factory $AdvertisementModelCopyWith(
          AdvertisementModel value, $Res Function(AdvertisementModel) then) =
      _$AdvertisementModelCopyWithImpl<$Res, AdvertisementModel>;
  @useResult
  $Res call(
      {String name,
      String image,
      String fromDate,
      String toDate,
      int? amount,
      bool? endingSoon,
      String id});
}

/// @nodoc
class _$AdvertisementModelCopyWithImpl<$Res, $Val extends AdvertisementModel>
    implements $AdvertisementModelCopyWith<$Res> {
  _$AdvertisementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvertisementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? image = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? amount = freezed,
    Object? endingSoon = freezed,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      endingSoon: freezed == endingSoon
          ? _value.endingSoon
          : endingSoon // ignore: cast_nullable_to_non_nullable
              as bool?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdvertisementModelImplCopyWith<$Res>
    implements $AdvertisementModelCopyWith<$Res> {
  factory _$$AdvertisementModelImplCopyWith(_$AdvertisementModelImpl value,
          $Res Function(_$AdvertisementModelImpl) then) =
      __$$AdvertisementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String image,
      String fromDate,
      String toDate,
      int? amount,
      bool? endingSoon,
      String id});
}

/// @nodoc
class __$$AdvertisementModelImplCopyWithImpl<$Res>
    extends _$AdvertisementModelCopyWithImpl<$Res, _$AdvertisementModelImpl>
    implements _$$AdvertisementModelImplCopyWith<$Res> {
  __$$AdvertisementModelImplCopyWithImpl(_$AdvertisementModelImpl _value,
      $Res Function(_$AdvertisementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvertisementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? image = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? amount = freezed,
    Object? endingSoon = freezed,
    Object? id = null,
  }) {
    return _then(_$AdvertisementModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      endingSoon: freezed == endingSoon
          ? _value.endingSoon
          : endingSoon // ignore: cast_nullable_to_non_nullable
              as bool?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdvertisementModelImpl implements _AdvertisementModel {
  const _$AdvertisementModelImpl(
      {this.name = "",
      this.image = "",
      this.fromDate = "",
      this.toDate = "",
      this.amount,
      this.endingSoon,
      this.id = ""});

  factory _$AdvertisementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdvertisementModelImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final String fromDate;
  @override
  @JsonKey()
  final String toDate;
  @override
  final int? amount;
  @override
  final bool? endingSoon;
  @override
  @JsonKey()
  final String id;

  @override
  String toString() {
    return 'AdvertisementModel(name: $name, image: $image, fromDate: $fromDate, toDate: $toDate, amount: $amount, endingSoon: $endingSoon, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvertisementModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.endingSoon, endingSoon) ||
                other.endingSoon == endingSoon) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, image, fromDate, toDate, amount, endingSoon, id);

  /// Create a copy of AdvertisementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvertisementModelImplCopyWith<_$AdvertisementModelImpl> get copyWith =>
      __$$AdvertisementModelImplCopyWithImpl<_$AdvertisementModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdvertisementModelImplToJson(
      this,
    );
  }
}

abstract class _AdvertisementModel implements AdvertisementModel {
  const factory _AdvertisementModel(
      {final String name,
      final String image,
      final String fromDate,
      final String toDate,
      final int? amount,
      final bool? endingSoon,
      final String id}) = _$AdvertisementModelImpl;

  factory _AdvertisementModel.fromJson(Map<String, dynamic> json) =
      _$AdvertisementModelImpl.fromJson;

  @override
  String get name;
  @override
  String get image;
  @override
  String get fromDate;
  @override
  String get toDate;
  @override
  int? get amount;
  @override
  bool? get endingSoon;
  @override
  String get id;

  /// Create a copy of AdvertisementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvertisementModelImplCopyWith<_$AdvertisementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
