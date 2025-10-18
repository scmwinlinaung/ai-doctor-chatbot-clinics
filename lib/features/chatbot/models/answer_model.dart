import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/chatbot/models/localized_string_model.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    @JsonKey(name: "_id") @Default("") String id,
    @Default(LocalizedStringModel(mm: "", en: "")) LocalizedStringModel text,
    DateTime? createdAt,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}
