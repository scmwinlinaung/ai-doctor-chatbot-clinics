import 'package:clinics/features/reports/models/clinic_report_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState.initial() = _Initial;
  const factory ReportState.loading() = _Loading;
  const factory ReportState.success(ClinicReportModel data) = _Success;
  const factory ReportState.error(String message) = _Error;
}
