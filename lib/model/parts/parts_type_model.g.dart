// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsTypeModel _$PartsTypeModelFromJson(Map<String, dynamic> json) {
  return PartsTypeModel(
    json['unitTypeId'] as int,
    json['unitTypeDescription'] as String,
  );
}

Map<String, dynamic> _$PartsTypeModelToJson(PartsTypeModel instance) =>
    <String, dynamic>{
      'unitTypeId': instance.unitTypeId,
      'unitTypeDescription': instance.unitTypeDescription,
    };
