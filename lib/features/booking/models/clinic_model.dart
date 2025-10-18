import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/features/booking/models/doctor_model.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@freezed
class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    @JsonKey(name: '_id') @Default("") String id,
    @Default("") String title,
    @Default("") String description,
    @Default("") String image,
    @Default("") String city,
    @Default("") String region,
    @Default("") String username,
    @Default("") String password,
    @Default([]) List<DoctorModel> doctors,
    @Default("") String status,
    DateTime? createdAt,
    @JsonKey(name: '__v') int? version,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
}
