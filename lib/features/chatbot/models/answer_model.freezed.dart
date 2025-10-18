// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) {
  return _AnswerModel.fromJson(json);
}

/// @nodoc
mixin _$AnswerModel {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  LocalizedStringModel get text => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AnswerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerModelCopyWith<AnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerModelCopyWith<$Res> {
  factory $AnswerModelCopyWith(
          AnswerModel value, $Res Function(AnswerModel) then) =
      _$AnswerModelCopyWithImpl<$Res, AnswerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      LocalizedStringModel text,
      DateTime? createdAt});

  $LocalizedStringModelCopyWith<$Res> get text;
}

/// @nodoc
class _$AnswerModelCopyWithImpl<$Res, $Val extends AnswerModel>
    implements $AnswerModelCopyWith<$Res> {
  _$AnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalizedStringModelCopyWith<$Res> get text {
    return $LocalizedStringModelCopyWith<$Res>(_value.text, (value) {
      return _then(_value.copyWith(text: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnswerModelImplCopyWith<$Res>
    implements $AnswerModelCopyWith<$Res> {
  factory _$$AnswerModelImplCopyWith(
          _$AnswerModelImpl value, $Res Function(_$AnswerModelImpl) then) =
      __$$AnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      LocalizedStringModel text,
      DateTime? createdAt});

  @override
  $LocalizedStringModelCopyWith<$Res> get text;
}

/// @nodoc
class __$$AnswerModelImplCopyWithImpl<$Res>
    extends _$AnswerModelCopyWithImpl<$Res, _$AnswerModelImpl>
    implements _$$AnswerModelImplCopyWith<$Res> {
  __$$AnswerModelImplCopyWithImpl(
      _$AnswerModelImpl _value, $Res Function(_$AnswerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AnswerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerModelImpl implements _AnswerModel {
  const _$AnswerModelImpl(
      {@JsonKey(name: "_id") this.id = "",
      this.text = const LocalizedStringModel(mm: "", en: ""),
      this.createdAt});

  factory _$AnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  @JsonKey()
  final LocalizedStringModel text;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AnswerModel(id: $id, text: $text, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, createdAt);

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerModelImplCopyWith<_$AnswerModelImpl> get copyWith =>
      __$$AnswerModelImplCopyWithImpl<_$AnswerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerModelImplToJson(
      this,
    );
  }
}

abstract class _AnswerModel implements AnswerModel {
  const factory _AnswerModel(
      {@JsonKey(name: "_id") final String id,
      final LocalizedStringModel text,
      final DateTime? createdAt}) = _$AnswerModelImpl;

  factory _AnswerModel.fromJson(Map<String, dynamic> json) =
      _$AnswerModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  LocalizedStringModel get text;
  @override
  DateTime? get createdAt;

  /// Create a copy of AnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerModelImplCopyWith<_$AnswerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
