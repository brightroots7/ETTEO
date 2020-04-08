// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) {
  return ServicesModel(
    json['serviceId'] as String,
    json['serviceProviderId'] as String,
    json['serviceTypeId'] as String,
    json['serviceType'] as String,
    json['serviceComponentId'] as String,
    json['serviceComponent'] as String,
    json['serviceDescription'] as String,
    json['serviceStatus'] as String,
    json['serviceStatusId'] as String,
    json['serviceSubStatus'] as String,
    json['serviceSubStatusId'] as String,
    json['serviceSku'] as String,
    json['serviceQuantity'] as int,
    json['serviceCost'] as String,
    json['routeGuid'] as String,
    json['serviceDate'] as String,
    json['serviceTime'] as int,
    json['serviceProvider'] as String,
    json['resourceId'] as String,
    json['resource'] as String,
    json['timeStart'] as String,
    json['timeEnd'] as String,
    json['serviceCompletedDate'] as String,
  );
}

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceProviderId': instance.serviceProviderId,
      'serviceTypeId': instance.serviceTypeId,
      'serviceType': instance.serviceType,
      'serviceComponentId': instance.serviceComponentId,
      'serviceComponent': instance.serviceComponent,
      'serviceDescription': instance.serviceDescription,
      'serviceStatus': instance.serviceStatus,
      'serviceStatusId': instance.serviceStatusId,
      'serviceSubStatusId': instance.serviceSubStatusId,
      'serviceSubStatus': instance.serviceSubStatus,
      'serviceSku': instance.serviceSku,
      'serviceQuantity': instance.serviceQuantity,
      'serviceCost': instance.serviceCost,
      'routeGuid': instance.routeGuid,
      'serviceDate': instance.serviceDate,
      'serviceTime': instance.serviceTime,
      'serviceProvider': instance.serviceProvider,
      'resourceId': instance.resourceId,
      'resource': instance.resource,
      'timeStart': instance.timeStart,
      'timeEnd': instance.timeEnd,
      'serviceCompletedDate': instance.serviceCompletedDate,
    };
