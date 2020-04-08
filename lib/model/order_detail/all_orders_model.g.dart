// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrdersModel _$AllOrdersModelFromJson(Map<String, dynamic> json) {
  return AllOrdersModel(
    json['orderId'] as String,
    json['ownerId'] as String,
    json['ownerName'] as String,
    json['orderNo'] as String,
    json['customerId'] as String,
    json['customerName'] as String,
    json['customerAddress'] as String,
    json['customerPhoneNo'] as String,
    json['customerEmailAddress'] as String,
    json['orderSource'] as String,
    json['orderSourceId'] as String,
    json['orderStatus'] as String,
    json['lineOfBusiness'] as String,
    json['flags'] as String,
    
  );
}

Map<String, dynamic> _$AllOrdersModelToJson(AllOrdersModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'ownerId':instance.ownerId,
      'ownerName':instance.ownerName,
      'orderNo': instance.orderNo,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerAddress': instance.customerAddress,
      'customerPhoneNo': instance.customerPhoneNo,
      'customerEmailAddress': instance.customerEmailAddress,
      'orderSource': instance.orderSource,
      'orderSourceId': instance.orderSourceId,
      'orderStatus': instance.orderStatus,
      'lineOfBusiness': instance.lineOfBusiness,
      'flags': instance.flags,
      

    };


/*
String orderId;
  String ownerId;
  String ownerName;
  String orderNo;
  String customerId;
  String customerName;
  String customerAddress;
  String customerPhoneNo;
  String customerEmailAddress;
  String orderSource;
  String orderSourceId;
  String orderStatus;
  String lineOfBusiness;
  String flags;

 */

