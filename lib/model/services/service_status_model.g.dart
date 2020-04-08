// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceStatusModel _$ServiceStatusModelFromJson(Map<String, dynamic> json) {
  return ServiceStatusModel(
    json['serviceStatusId'] as String,
    json['serviceStatusName'] as String,
    json['isDelegate'] as bool,
    json['isRequiredNotes'] as bool,
  )..serviceSubStatuses = (json['serviceSubStatuses'] as List)
      ?.map((e) => e == null
          ? null
          : ServiceSubStatusModel.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$ServiceStatusModelToJson(ServiceStatusModel instance) =>
    <String, dynamic>{
      'serviceStatusId': instance.serviceStatusId,
      'serviceStatusName': instance.serviceStatusName,
      'isRequiredNotes': instance.isRequiredNotes,
      'isDelegate': instance.isDelegate,
      'serviceSubStatuses':
          instance.serviceSubStatuses?.map((e) => e?.toJson())?.toList(),
    };
