// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerModelImpl _$$AnswerModelImplFromJson(Map<String, dynamic> json) =>
    _$AnswerModelImpl(
      id: json['_id'] as String? ?? "",
      text: json['text'] == null
          ? const LocalizedStringModel(mm: "", en: "")
          : LocalizedStringModel.fromJson(json['text'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AnswerModelImplToJson(_$AnswerModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'text': instance.text,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
