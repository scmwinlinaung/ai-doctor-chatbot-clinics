// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionModelImpl _$$RegionModelImplFromJson(Map<String, dynamic> json) =>
    _$RegionModelImpl(
      id: json['_id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      city: json['city'] as String? ?? "",
    );

Map<String, dynamic> _$$RegionModelImplToJson(_$RegionModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'city': instance.city,
    };
