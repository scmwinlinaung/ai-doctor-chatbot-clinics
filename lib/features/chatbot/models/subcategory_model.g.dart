// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubcategoryModelImpl _$$SubcategoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubcategoryModelImpl(
      id: json['_id'] as String? ?? "",
      name: json['name'] == null
          ? const LocalizedStringModel(en: "", mm: "")
          : LocalizedStringModel.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SubcategoryModelImplToJson(
        _$SubcategoryModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
