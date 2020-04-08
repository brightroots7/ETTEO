// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteDBModel _$RouteDBModelFromJson(Map<String, dynamic> json) {
  return RouteDBModel(
    id: json['id'] as int,
    routeId: json['routeId'] as String,
    orderId: json['orderId'] as String,
    routeJson: RouteDBModel._routeModelFromJson(json['routeJson']),
    serviceDate: json['serviceDate'] as String,
    createdDate: json['createdDate'] as String,
    updatedDate: json['updatedDate'] as String,
    syncFlag: json['syncFlag'] as int,
  );
}

Map<String, dynamic> _$RouteDBModelToJson(RouteDBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeId': instance.routeId,
      'orderId': instance.orderId,
      'routeJson': RouteDBModel._routeModelToJson(instance.routeJson),
      'serviceDate': instance.serviceDate,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'syncFlag': instance.syncFlag,
    };
