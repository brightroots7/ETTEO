// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsModel _$PartsModelFromJson(Map<String, dynamic> json) {
  return PartsModel(
    json['unitId'] as String,
    json['make'] as String,
    json['model'] as String,
    json['serialNumber'] as String,
    json['unitDescription'] as String,
    json['unitTypeId'] as int,
    json['unitType'] as String,
    json['unitStatusId'] as int,
    json['unitStatus'] as String,
    json['estimatedTimeOfArrival'] as String,
    json['unitLocation'] as String,
  );
}

Map<String, dynamic> _$PartsModelToJson(PartsModel instance) =>
    <String, dynamic>{
      'unitId': instance.unitId,
      'make': instance.make,
      'model': instance.model,
      'serialNumber': instance.serialNumber,
      'unitDescription': instance.unitDescription,
      'unitTypeId': instance.unitTypeId,
      'unitType': instance.unitType,
      'unitStatusId': instance.unitStatusId,
      'unitStatus': instance.unitStatus,
      'estimatedTimeOfArrival': instance.estimatedTimeOfArrival,
      'unitLocation': instance.unitLocation,
    };
