// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    json['addressId'] as int,
    json['addressTypeId'] as int,
    json['addressLine1'] as String,
    json['addressLine2'] as String,
    json['addressLine3'] as String,
    json['addressLine4'] as String,
    json['addressLine5'] as String,
    json['city'] as String,
    json['state'] as String,
    json['postalCode'] as String,
    json['country'] as String,
    json['latitude'] as String,
    json['longitude'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'addressTypeId': instance.addressTypeId,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressLine3': instance.addressLine3,
      'addressLine4': instance.addressLine4,
      'addressLine5': instance.addressLine5,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
