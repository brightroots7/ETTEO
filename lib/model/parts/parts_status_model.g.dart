// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsStatusModel _$PartsStatusModelFromJson(Map<String, dynamic> json) {
  return PartsStatusModel(
    json['unitStatusId'] as int,
    json['unitStatusDescription'] as String,
  );
}

Map<String, dynamic> _$PartsStatusModelToJson(PartsStatusModel instance) =>
    <String, dynamic>{
      'unitStatusId': instance.unitStatusId,
      'unitStatusDescription': instance.unitStatusDescription,
    };
