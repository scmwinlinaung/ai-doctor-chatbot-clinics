import 'package:freezed_annotation/freezed_annotation.dart';

part 'redemption_request_model.freezed.dart';
part 'redemption_request_model.g.dart';

@freezed
class RedemptionRequestModel with _$RedemptionRequestModel {
  const factory RedemptionRequestModel({
    required String redemptionCode,
  }) = _RedemptionRequestModel;

  factory RedemptionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RedemptionRequestModelFromJson(json);
}
