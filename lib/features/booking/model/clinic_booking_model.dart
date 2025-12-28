import 'package:clinics/features/auth/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_booking_model.freezed.dart';
part 'clinic_booking_model.g.dart';

enum BookingStatus { booking, confirmed, expire }

@freezed
class ClinicBookingModel with _$ClinicBookingModel {
  const factory ClinicBookingModel({
    @JsonKey(name: '_id') String? id,
    String? clinic, // This is the clinic ID
    UserModel? user,
    BookingStatus? status,
    bool? paid,
    String? confirmedDate,
    String? time,
    String? doctorName,
    String? date,
    String? createdAt,
  }) = _ClinicBookingModel;

  factory ClinicBookingModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicBookingModelFromJson(json);
}
