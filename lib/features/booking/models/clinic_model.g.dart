// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicModelImpl _$$ClinicModelImplFromJson(Map<String, dynamic> json) =>
    _$ClinicModelImpl(
      id: json['_id'] as String? ?? "",
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      image: json['image'] as String? ?? "",
      city: json['city'] as String? ?? "",
      region: json['region'] as String? ?? "",
      username: json['username'] as String? ?? "",
      password: json['password'] as String? ?? "",
      doctors: (json['doctors'] as List<dynamic>?)
              ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: json['status'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ClinicModelImplToJson(_$ClinicModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'city': instance.city,
      'region': instance.region,
      'username': instance.username,
      'password': instance.password,
      'doctors': instance.doctors,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      '__v': instance.version,
    };
