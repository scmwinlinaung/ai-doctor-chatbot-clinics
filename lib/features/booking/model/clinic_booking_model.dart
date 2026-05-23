import 'package:clinics/features/auth/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_booking_model.freezed.dart';
part 'clinic_booking_model.g.dart';

enum BookingStatus {
  @JsonValue('booking')
  booking,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('unconfirmed')
  unconfirmed,
  @JsonValue('unreadcancelled')
  unreadcancelled,
  @JsonValue('unknown')
  unknown;

  static BookingStatus get defaultValue => BookingStatus.unknown;

  static BookingStatus fromJson(dynamic value) {
    if (value == null) return defaultValue;

    for (var status in BookingStatus.values) {
      // Get the JSON value from @JsonValue annotation
      final jsonValue = _toJsonValue(status);
      if (jsonValue == value.toString()) {
        return status;
      }
    }
    return defaultValue;
  }

  static String _toJsonValue(BookingStatus status) {
    switch (status) {
      case BookingStatus.booking:
        return 'booking';
      case BookingStatus.confirmed:
        return 'confirmed';
      case BookingStatus.unconfirmed:
        return 'unconfirmed';
      case BookingStatus.unreadcancelled:
        return 'unreadcancelled';
      case BookingStatus.unknown:
        return 'unknown';
    }
  }
}

@freezed
class ClinicBookingModel with _$ClinicBookingModel {
  const factory ClinicBookingModel(
      {@JsonKey(name: '_id') String? id,
      String? clinic, // This is the clinic ID
      UserModel? user,
      BookingStatus? status,
      bool? paid,
      String? confirmedDate,
      String? time,
      String? doctorName,
      String? patientName,
      int? age,
      String? date,
      String? createdAt,
      bool? isReadByClinic}) = _ClinicBookingModel;

  factory ClinicBookingModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicBookingModelFromJson(json);
}
