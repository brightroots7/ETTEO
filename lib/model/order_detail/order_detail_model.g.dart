// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) {
  return OrderDetailModel(
    json['orderId'] as String,
    json['modelVersion'] as int,
    json['createdDate'] as String,
    json['orderStatus'] as String,
    OrderDetailModel._modelFromJson(json['order']),
  );
}

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'modelVersion': instance.modelVersion,
      'createdDate': instance.createdDate,
      'orderStatus': instance.orderStatus,
      'order': OrderDetailModel._modelToJson(instance.order),
    };
