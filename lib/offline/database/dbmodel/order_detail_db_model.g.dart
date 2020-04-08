// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailDBModel _$OrderDetailDBModelFromJson(Map<String, dynamic> json) {
  return OrderDetailDBModel(
    id: json['id'] as int,
    orderId: json['orderId'] as String,
    orderDetailJson:
        OrderDetailDBModel._routeModelFromJson(json['orderDetailJson']),
    serviceDate: json['serviceDate'] as String,
    createdDate: json['createdDate'] as String,
    updatedDate: json['updatedDate'] as String,
    syncFlag: json['syncFlag'] as int,
  );
}

Map<String, dynamic> _$OrderDetailDBModelToJson(OrderDetailDBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'orderDetailJson':
          OrderDetailDBModel._routeModelToJson(instance.orderDetailJson),
      'serviceDate': instance.serviceDate,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'syncFlag': instance.syncFlag,
    };
