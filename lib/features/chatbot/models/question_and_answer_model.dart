import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/chatbot/models/answer_model.dart';
import 'package:clinics/features/chatbot/models/localized_string_model.dart';

part 'question_and_answer_model.freezed.dart';
part 'question_and_answer_model.g.dart';

@freezed
class QuestionAndAnswerModel with _$QuestionAndAnswerModel {
  const factory QuestionAndAnswerModel({
    @JsonKey(name: "_id") @Default("") String id,
    @Default(LocalizedStringModel(en: "", mm: ""))
    LocalizedStringModel question,
    @Default("") String categoryId,
    @Default("") String subcategoryId,
    @Default([]) List<AnswerModel> answers,
    @Default("") String questionType,
    DateTime? createdAt,
    int? v,
  }) = _QuestionAndAnswerModel;

  factory QuestionAndAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionAndAnswerModelFromJson(json);
}
