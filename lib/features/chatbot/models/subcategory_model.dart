import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/chatbot/models/localized_string_model.dart';

part 'subcategory_model.freezed.dart';
part 'subcategory_model.g.dart';

@freezed
class SubcategoryModel with _$SubcategoryModel {
  const factory SubcategoryModel({
    @JsonKey(name: "_id") @Default("") String id,
    @Default(LocalizedStringModel(en: "", mm: "")) LocalizedStringModel name,
  }) = _SubcategoryModel;

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);
}
