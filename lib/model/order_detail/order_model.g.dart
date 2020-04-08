// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    json['etteoOrderId'] as String,
    OrderModel._lineofBusinessModelFromJson(json['lineOfBusiness']),
    OrderModel._marketModelFromJson(json['market']),
    OrderModel._orderSourceModelFromJson(json['orderSource']),
    OrderModel._ownerModelFromJson(json['owner']),
    OrderModel._contactsModelFromJson(json['contacts']),
    OrderModel._flagsModelFromJson(json['flags']),
    OrderModel._servicesModelFromJson(json['services']),
    OrderModel._ownerFinanceModelFromJson(json['finance']),
  )
    ..units = OrderModel._partsModelFromJson(json['units'])
    ..notes = OrderModel._notesModelFromJson(json['notes'])
    ..documents = OrderModel._documentsModelFromJson(json['documents']);
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'etteoOrderId': instance.etteoOrderId,
      'lineOfBusiness': OrderModel._modelToJson(instance.lineOfBusiness),
      'market': OrderModel._modelToJson(instance.market),
      'orderSource': OrderModel._modelToJson(instance.orderSource),
      'owner': OrderModel._modelToJson(instance.owner),
      'contacts': OrderModel._modelToJson(instance.contacts),
      'flags': OrderModel._modelToJson(instance.flags),
      'services': OrderModel._modelToJson(instance.services),
      'units': OrderModel._modelToJson(instance.units),
      'notes': OrderModel._modelToJson(instance.notes),
      'documents': OrderModel._modelToJson(instance.documents),
      'finance': OrderModel._modelToJson(instance.finance),
    };
