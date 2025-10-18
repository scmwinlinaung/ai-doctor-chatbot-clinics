import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    @JsonKey(name: '_id') @Default("") String id,
    @Default("") String name,
    @Default("") String specialization,
    @Default("") String clinic,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}
