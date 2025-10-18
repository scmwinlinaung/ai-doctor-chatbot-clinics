// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      id: json['_id'] as String? ?? "",
      name: json['name'] == null
          ? const LocalizedStringModel(en: "", mm: "")
          : LocalizedStringModel.fromJson(json['name'] as Map<String, dynamic>),
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'subcategories': instance.subcategories,
      'v': instance.v,
    };
