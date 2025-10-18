import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_model.freezed.dart';
part 'region_model.g.dart';

@freezed
class RegionModel with _$RegionModel {
  const factory RegionModel(
      {@JsonKey(name: '_id') @Default("") String id,
      @Default("") String name,
      @Default("") String city}) = _RegionModel;

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);
}
