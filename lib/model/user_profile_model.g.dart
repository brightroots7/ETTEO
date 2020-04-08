// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return UserProfileModel(
    json['firstName'] as String,
    json['lastName'] as String,
    json['emailAddress'] as String,
    json['phoneNumber'] as String,
    json['contactId'] as String,
    json['userId'] as String,
    json['resourceId'] as String,
    json['timeZoneId'] as String,
    json['timeZoneName'] as String,
    json['timeZoneTime'] as String,
    json['profileImage'] as String,
    json['address'] == null
        ? null
        : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    json['website'] == null
        ? null
        : WebsiteModel.fromJson(json['website'] as Map<String, dynamic>),
    
    (json['roles'] as List)?.map((e) => e as String)?.toList(),
    (json['permissions'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'contactId': instance.contactId,
      'resourceId': instance.resourceId,
      'userId': instance.userId,
      // 'address': instance.address?.toJson(),
      // 'website': instance.website?.toJson(),
      'roles': instance.roles,
      'permissions': instance.permissions,
      'timeZoneId': instance.timeZoneId,
      'timeZoneName': instance.timeZoneName,
      'timeZoneTime': instance.timeZoneTime,
      'profileImage': instance.profileImage,
    };
