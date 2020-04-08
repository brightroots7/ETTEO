// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteOrderModel _$RouteOrderModelFromJson(Map<String, dynamic> json) {
  return RouteOrderModel(
    orderId: json['orderId'] as String,
    etteoOrderId: json['etteoOrderId'] as String,
    customerId: json['customerId'] as String,
    customerName: json['customerName'] as String,
    customerAddress: json['customerAddress'] as String,
    customerPhoneNo: json['customerPhoneNo'] as String,
    customerCityStateZip: json['customerCityStateZip'] as String,
    customerEmailAddress: json['customerEmailAddress'] as String,
    orderSource: json['orderSource'] as String,
    sourceId: json['sourceId'] as String,
    orderStatus: json['orderStatus'] as String,
    lineOfBusiness: json['lineOfBusiness'] as String,
    lineOfBusinessId: json['lineOfBusinessId'] as String,
    flags: RouteOrderModel._routeflagModelFromJson(json['flags']),
  )..service = RouteOrderModel._routeServiceModelFromJson(json['service']);
}

Map<String, dynamic> _$RouteOrderModelToJson(RouteOrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'etteoOrderId': instance.etteoOrderId,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerAddress': instance.customerAddress,
      'customerPhoneNo': instance.customerPhoneNo,
      'customerCityStateZip': instance.customerCityStateZip,
      'customerEmailAddress': instance.customerEmailAddress,
      'orderSource': instance.orderSource,
      'sourceId': instance.sourceId,
      'orderStatus': instance.orderStatus,
      'lineOfBusiness': instance.lineOfBusiness,
      'lineOfBusinessId': instance.lineOfBusinessId,
      'flags': RouteOrderModel._modelToJson(instance.flags),
      'service': RouteOrderModel._routeServciceModelToJson(instance.service),
    };
