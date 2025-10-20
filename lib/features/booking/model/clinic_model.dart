import 'package:clinics/features/booking/model/doctor_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

// Using an enum for status is more type-safe than a raw string.
enum ClinicStatus { active, inactive }

@freezed
class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? description,
    String? image,
    String? city,
    String? region,
    String? username,
    // Note: 'password' is omitted for security best practices.
    List<DoctorModel>? doctors,
    ClinicStatus? status,
    String? createdAt,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
}
