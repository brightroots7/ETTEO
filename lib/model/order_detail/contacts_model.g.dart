// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) {
  return ContactsModel(
    json['contactMasterGuid'] as String,
    json['contactTypeId'] as int,
    json['contactFirstName'] as String,
    json['contactLastName'] as String,
    json['contactBusinessName'] as String,
    json['contactEntityTypeId'] as int,
    ContactsModel._addressModelFromJson(json['addresses']),
    ContactsModel._emailModelFromJson(json['emails']),
    ContactsModel._phoneModelFromJson(json['phoneNos']),
    ContactsModel._websiteModelFromJson(json['websites']),
  );
}

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'contactMasterGuid': instance.contactMasterGuid,
      'contactTypeId': instance.contactTypeId,
      'contactFirstName': instance.contactFirstName,
      'contactLastName': instance.contactLastName,
      'contactBusinessName': instance.contactBusinessName,
      'contactEntityTypeId': instance.contactEntityTypeId,
      'addresses': ContactsModel._modelToJson(instance.addresses),
      'emails': ContactsModel._modelToJson(instance.emails),
      'phoneNos': ContactsModel._modelToJson(instance.phoneNos),
      'websites': ContactsModel._modelToJson(instance.websites),
    };
