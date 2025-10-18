// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorModelImpl _$$DoctorModelImplFromJson(Map<String, dynamic> json) =>
    _$DoctorModelImpl(
      id: json['_id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      specialization: json['specialization'] as String? ?? "",
      clinic: json['clinic'] as String? ?? "",
    );

Map<String, dynamic> _$$DoctorModelImplToJson(_$DoctorModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'specialization': instance.specialization,
      'clinic': instance.clinic,
    };
