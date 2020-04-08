// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_sub_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceSubStatusModel _$ServiceSubStatusModelFromJson(
    Map<String, dynamic> json) {
  return ServiceSubStatusModel(
    json['serviceSubStatusId'] as String,
    json['serviceSubStatusName'] as String,
    json['isDelegate'] as bool,
    json['isRequiredNotes'] as bool,
  );
}

Map<String, dynamic> _$ServiceSubStatusModelToJson(
        ServiceSubStatusModel instance) =>
    <String, dynamic>{
      'serviceSubStatusId': instance.serviceSubStatusId,
      'serviceSubStatusName': instance.serviceSubStatusName,
      'isRequiredNotes': instance.isRequiredNotes,
      'isDelegate': instance.isDelegate,
    };
