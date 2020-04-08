// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceTypeModel _$ServiceTypeModelFromJson(Map<String, dynamic> json) {
  return ServiceTypeModel(
    json['serviceTypeGuid'] as String,
    json['serviceTypeName'] as String,
    json['noOfHours'] as int,
  );
}

Map<String, dynamic> _$ServiceTypeModelToJson(ServiceTypeModel instance) =>
    <String, dynamic>{
      'serviceTypeGuid': instance.serviceTypeGuid,
      'serviceTypeName': instance.serviceTypeName,
      'noOfHours': instance.noOfHours,
    };
