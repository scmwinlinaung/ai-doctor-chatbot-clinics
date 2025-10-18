import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_string_model.freezed.dart';
part 'localized_string_model.g.dart';

@freezed
class LocalizedStringModel with _$LocalizedStringModel {
  const factory LocalizedStringModel({
    @Default("") String en,
    @Default("") String mm,
  }) = _LocalizedStringModel;

  factory LocalizedStringModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedStringModelFromJson(json);
}
