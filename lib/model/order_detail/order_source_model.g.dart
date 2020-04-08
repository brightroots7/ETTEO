// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSourceModel _$OrderSourceModelFromJson(Map<String, dynamic> json) {
  return OrderSourceModel(
    json['orderSourceId'] as String,
    json['externalOrderId'] as String,
    json['orderSourceName'] as String,
  );
}

Map<String, dynamic> _$OrderSourceModelToJson(OrderSourceModel instance) =>
    <String, dynamic>{
      'orderSourceId': instance.orderSourceId,
      'externalOrderId': instance.externalOrderId,
      'orderSourceName': instance.orderSourceName,
    };
