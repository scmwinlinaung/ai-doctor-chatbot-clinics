// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String? ?? "",
      username: json['username'] as String? ?? "",
      phoneno: json['phoneno'] as String? ?? "",
      role: json['role'] as String? ?? "",
      password: json['password'] as String? ?? "",
      region: json['region'] as String? ?? "",
      city: json['city'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      version: (json['version'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phoneno': instance.phoneno,
      'role': instance.role,
      'password': instance.password,
      'region': instance.region,
      'city': instance.city,
      'createdAt': instance.createdAt?.toIso8601String(),
      'version': instance.version,
    };
