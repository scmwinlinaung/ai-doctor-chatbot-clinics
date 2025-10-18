// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdvertisementModelImpl _$$AdvertisementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdvertisementModelImpl(
      name: json['name'] as String? ?? "",
      image: json['image'] as String? ?? "",
      fromDate: json['fromDate'] as String? ?? "",
      toDate: json['toDate'] as String? ?? "",
      amount: (json['amount'] as num?)?.toInt(),
      endingSoon: json['endingSoon'] as bool?,
      id: json['id'] as String? ?? "",
    );

Map<String, dynamic> _$$AdvertisementModelImplToJson(
        _$AdvertisementModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'amount': instance.amount,
      'endingSoon': instance.endingSoon,
      'id': instance.id,
    };
