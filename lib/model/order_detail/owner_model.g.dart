// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) {
  return OwnerModel(
    json['ownerId'] as String,
    json['ownerName'] as String,
  );
}

Map<String, dynamic> _$OwnerModelToJson(OwnerModel instance) =>
    <String, dynamic>{
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
    };
