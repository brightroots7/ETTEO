// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteServiceModel _$RouteServiceModelFromJson(Map<String, dynamic> json) {
  return RouteServiceModel(
    json['service'] as String,
    json['serviceComponent'] as String,
    json['serviceType'] as String,
    json['description'] as String,
    json['scheduleDate'] as String,
    json['serviceStatus'] as String,
    json['routeStatusId'] as String,
    json['routeStatus'] as String,
    json['serviceProviderName'] as String,
    json['serviceProviderId'] as String,
    json['resourceName'] as String,
    json['resourceId'] as String,
    json['timeStart'] as String,
    json['timeEnd'] as String,
  );
}

Map<String, dynamic> _$RouteServiceModelToJson(RouteServiceModel instance) =>
    <String, dynamic>{
      'service': instance.service,
      'serviceComponent': instance.serviceComponent,
      'serviceType': instance.serviceType,
      'description': instance.description,
      'scheduleDate': instance.scheduleDate,
      'serviceStatus': instance.serviceStatus,
      'routeStatusId': instance.routeStatusId,
      'routeStatus': instance.routeStatus,
      'serviceProviderName': instance.serviceProviderName,
      'serviceProviderId': instance.serviceProviderId,
      'resourceName': instance.resourceName,
      'resourceId': instance.resourceId,
      'timeStart': instance.timeStart,
      'timeEnd': instance.timeEnd,
    };
