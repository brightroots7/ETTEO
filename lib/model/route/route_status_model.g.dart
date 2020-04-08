// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteStatusModel _$RouteStatusModelFromJson(Map<String, dynamic> json) {
  return RouteStatusModel(
    json['routeStatusId'] as String,
    json['routeStatusDescription'] as String,
    json['routeStatusUpdatedTime'] as String,
    json['isDelegate'] as bool,
    json['routeIcon'] as String,
    json['createdUserId'] as String,
    json['createdDate'] as String,
  );
}

Map<String, dynamic> _$RouteStatusModelToJson(RouteStatusModel instance) =>
    <String, dynamic>{
      'routeStatusId': instance.routeStatusId,
      'routeStatusDescription': instance.routeStatusDescription,
      'routeStatusUpdatedTime': instance.routeStatusUpdatedTime,
      'isDelegate': instance.isDelegate,
      'routeIcon': instance.routeIcon,
      'createdUserId': instance.createdUserId,
      'createdDate': instance.createdDate,
    };
