import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_report_state.freezed.dart';

@freezed
class BookingReportState with _$BookingReportState {
  const factory BookingReportState.initial() = _Initial;
  const factory BookingReportState.loading() = _Loading;
  const factory BookingReportState.success(List<ClinicBookingModel> bookings) = _Success;
  const factory BookingReportState.error(String message) = _Error;
}
