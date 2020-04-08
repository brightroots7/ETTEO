// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneModel _$PhoneModelFromJson(Map<String, dynamic> json) {
  return PhoneModel(
    json['phoneId'] as int,
    json['phoneNumber'] as String,
    json['phoneNumberTypeId'] as int,
  );
}

Map<String, dynamic> _$PhoneModelToJson(PhoneModel instance) =>
    <String, dynamic>{
      'phoneId': instance.phoneId,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberTypeId': instance.phoneNumberTypeId,
    };
