import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_report_model.freezed.dart';
part 'clinic_report_model.g.dart';

@freezed
class ClinicReportModel with _$ClinicReportModel {
  const factory ClinicReportModel({
    String? clinicId,
    int? totalPointsRedeemed,
    int? totalRedemptions,
    List<RedemptionDetail>? redemptions,
  }) = _ClinicReportModel;

  factory ClinicReportModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicReportModelFromJson(json);
}

@freezed
class RedemptionDetail with _$RedemptionDetail {
  const factory RedemptionDetail({
    @JsonKey(name: '_id') String? id,
    ReportUser? user,
    ReportReward? reward,
    int? points,
    DateTime? redeemedAt,
  }) = _RedemptionDetail;

  factory RedemptionDetail.fromJson(Map<String, dynamic> json) =>
      _$RedemptionDetailFromJson(json);
}

@freezed
class ReportUser with _$ReportUser {
  const factory ReportUser({
    @JsonKey(name: '_id') String? id,
    String? username,
  }) = _ReportUser;

  factory ReportUser.fromJson(Map<String, dynamic> json) =>
      _$ReportUserFromJson(json);
}

@freezed
class ReportReward with _$ReportReward {
  const factory ReportReward({
    @JsonKey(name: '_id') String? id,
    String? title,
  }) = _ReportReward;

  factory ReportReward.fromJson(Map<String, dynamic> json) =>
      _$ReportRewardFromJson(json);
}
