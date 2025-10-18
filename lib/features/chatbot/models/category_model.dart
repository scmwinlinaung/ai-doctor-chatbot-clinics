import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/chatbot/models/localized_string_model.dart';
import 'package:clinics/features/chatbot/models/subcategory_model.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @JsonKey(name: "_id") @Default("") String id,
    @Default(LocalizedStringModel(en: "", mm: "")) LocalizedStringModel name,
    @Default([]) List<SubcategoryModel> subcategories,
    int? v,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
