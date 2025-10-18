// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_and_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionAndAnswerModelImpl _$$QuestionAndAnswerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionAndAnswerModelImpl(
      id: json['_id'] as String? ?? "",
      question: json['question'] == null
          ? const LocalizedStringModel(en: "", mm: "")
          : LocalizedStringModel.fromJson(
              json['question'] as Map<String, dynamic>),
      categoryId: json['categoryId'] as String? ?? "",
      subcategoryId: json['subcategoryId'] as String? ?? "",
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      questionType: json['questionType'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuestionAndAnswerModelImplToJson(
        _$QuestionAndAnswerModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'categoryId': instance.categoryId,
      'subcategoryId': instance.subcategoryId,
      'answers': instance.answers,
      'questionType': instance.questionType,
      'createdAt': instance.createdAt?.toIso8601String(),
      'v': instance.v,
    };
