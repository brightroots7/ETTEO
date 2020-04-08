// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) {
  return RouteModel(
    json['id'] as int,
    json['routeId'] as String,
    json['marketId'] as int,
    json['marketName'] as String,
    json['routeDate'] as String,
    json['serviceProviderId'] as String,
    RouteModel._routeOrderModelFromJson(json['order']),
  );
}

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'marketId': instance.marketId,
      'marketName': instance.marketName,
      'routeDate': instance.routeDate,
      'serviceProviderId': instance.serviceProviderId,
      'order': RouteModel._routeOrderModelToJson(instance.order),
    };
