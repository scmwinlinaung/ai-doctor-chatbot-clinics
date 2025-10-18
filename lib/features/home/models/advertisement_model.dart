import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertisement_model.freezed.dart';
part 'advertisement_model.g.dart';

@freezed
class AdvertisementModel with _$AdvertisementModel {
  const factory AdvertisementModel({
    @Default("") String name,
    @Default("") String image,
    @Default("") String fromDate,
    @Default("") String toDate,
    int? amount,
    bool? endingSoon,
    @Default("") String id,
  }) = _AdvertisementModel;

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementModelFromJson(json);
}
