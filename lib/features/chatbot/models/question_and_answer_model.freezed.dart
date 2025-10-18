// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_and_answer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuestionAndAnswerModel _$QuestionAndAnswerModelFromJson(
    Map<String, dynamic> json) {
  return _QuestionAndAnswerModel.fromJson(json);
}

/// @nodoc
mixin _$QuestionAndAnswerModel {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  LocalizedStringModel get question => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get subcategoryId => throw _privateConstructorUsedError;
  List<AnswerModel> get answers => throw _privateConstructorUsedError;
  String get questionType => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get v => throw _privateConstructorUsedError;

  /// Serializes this QuestionAndAnswerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionAndAnswerModelCopyWith<QuestionAndAnswerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionAndAnswerModelCopyWith<$Res> {
  factory $QuestionAndAnswerModelCopyWith(QuestionAndAnswerModel value,
          $Res Function(QuestionAndAnswerModel) then) =
      _$QuestionAndAnswerModelCopyWithImpl<$Res, QuestionAndAnswerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      LocalizedStringModel question,
      String categoryId,
      String subcategoryId,
      List<AnswerModel> answers,
      String questionType,
      DateTime? createdAt,
      int? v});

  $LocalizedStringModelCopyWith<$Res> get question;
}

/// @nodoc
class _$QuestionAndAnswerModelCopyWithImpl<$Res,
        $Val extends QuestionAndAnswerModel>
    implements $QuestionAndAnswerModelCopyWith<$Res> {
  _$QuestionAndAnswerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? categoryId = null,
    Object? subcategoryId = null,
    Object? answers = null,
    Object? questionType = null,
    Object? createdAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategoryId: null == subcategoryId
          ? _value.subcategoryId
          : subcategoryId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerModel>,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalizedStringModelCopyWith<$Res> get question {
    return $LocalizedStringModelCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuestionAndAnswerModelImplCopyWith<$Res>
    implements $QuestionAndAnswerModelCopyWith<$Res> {
  factory _$$QuestionAndAnswerModelImplCopyWith(
          _$QuestionAndAnswerModelImpl value,
          $Res Function(_$QuestionAndAnswerModelImpl) then) =
      __$$QuestionAndAnswerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String id,
      LocalizedStringModel question,
      String categoryId,
      String subcategoryId,
      List<AnswerModel> answers,
      String questionType,
      DateTime? createdAt,
      int? v});

  @override
  $LocalizedStringModelCopyWith<$Res> get question;
}

/// @nodoc
class __$$QuestionAndAnswerModelImplCopyWithImpl<$Res>
    extends _$QuestionAndAnswerModelCopyWithImpl<$Res,
        _$QuestionAndAnswerModelImpl>
    implements _$$QuestionAndAnswerModelImplCopyWith<$Res> {
  __$$QuestionAndAnswerModelImplCopyWithImpl(
      _$QuestionAndAnswerModelImpl _value,
      $Res Function(_$QuestionAndAnswerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? categoryId = null,
    Object? subcategoryId = null,
    Object? answers = null,
    Object? questionType = null,
    Object? createdAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_$QuestionAndAnswerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as LocalizedStringModel,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subcategoryId: null == subcategoryId
          ? _value.subcategoryId
          : subcategoryId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerModel>,
      questionType: null == questionType
          ? _value.questionType
          : questionType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionAndAnswerModelImpl implements _QuestionAndAnswerModel {
  const _$QuestionAndAnswerModelImpl(
      {@JsonKey(name: "_id") this.id = "",
      this.question = const LocalizedStringModel(en: "", mm: ""),
      this.categoryId = "",
      this.subcategoryId = "",
      final List<AnswerModel> answers = const [],
      this.questionType = "",
      this.createdAt,
      this.v})
      : _answers = answers;

  factory _$QuestionAndAnswerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionAndAnswerModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  @JsonKey()
  final LocalizedStringModel question;
  @override
  @JsonKey()
  final String categoryId;
  @override
  @JsonKey()
  final String subcategoryId;
  final List<AnswerModel> _answers;
  @override
  @JsonKey()
  List<AnswerModel> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  @JsonKey()
  final String questionType;
  @override
  final DateTime? createdAt;
  @override
  final int? v;

  @override
  String toString() {
    return 'QuestionAndAnswerModel(id: $id, question: $question, categoryId: $categoryId, subcategoryId: $subcategoryId, answers: $answers, questionType: $questionType, createdAt: $createdAt, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionAndAnswerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.subcategoryId, subcategoryId) ||
                other.subcategoryId == subcategoryId) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.questionType, questionType) ||
                other.questionType == questionType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      question,
      categoryId,
      subcategoryId,
      const DeepCollectionEquality().hash(_answers),
      questionType,
      createdAt,
      v);

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionAndAnswerModelImplCopyWith<_$QuestionAndAnswerModelImpl>
      get copyWith => __$$QuestionAndAnswerModelImplCopyWithImpl<
          _$QuestionAndAnswerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionAndAnswerModelImplToJson(
      this,
    );
  }
}

abstract class _QuestionAndAnswerModel implements QuestionAndAnswerModel {
  const factory _QuestionAndAnswerModel(
      {@JsonKey(name: "_id") final String id,
      final LocalizedStringModel question,
      final String categoryId,
      final String subcategoryId,
      final List<AnswerModel> answers,
      final String questionType,
      final DateTime? createdAt,
      final int? v}) = _$QuestionAndAnswerModelImpl;

  factory _QuestionAndAnswerModel.fromJson(Map<String, dynamic> json) =
      _$QuestionAndAnswerModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  LocalizedStringModel get question;
  @override
  String get categoryId;
  @override
  String get subcategoryId;
  @override
  List<AnswerModel> get answers;
  @override
  String get questionType;
  @override
  DateTime? get createdAt;
  @override
  int? get v;

  /// Create a copy of QuestionAndAnswerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionAndAnswerModelImplCopyWith<_$QuestionAndAnswerModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
