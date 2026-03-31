import 'package:freezed_annotation/freezed_annotation.dart';

part 'redemption_response_model.freezed.dart';
part 'redemption_response_model.g.dart';

@freezed
class RedemptionResponseModel with _$RedemptionResponseModel {
  const factory RedemptionResponseModel({
    required String msg,
    required String user,
    required String reward,
  }) = _RedemptionResponseModel;

  factory RedemptionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RedemptionResponseModelFromJson(json);
}
