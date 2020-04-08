// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataDBModel _$MasterDataDBModelFromJson(Map<String, dynamic> json) {
  return MasterDataDBModel(
    id: json['id'] as int,
    key: json['key'] as String,
    parentKey: json['parentKey'] as String,
    masterDataName: json['masterDataName'] as String,
    jsonData: json['jsonData'] as String,
    createdDate: json['createdDate'] as String,
  );
}

Map<String, dynamic> _$MasterDataDBModelToJson(MasterDataDBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'parentKey': instance.parentKey,
      'masterDataName': instance.masterDataName,
      'jsonData': instance.jsonData,
      'createdDate': instance.createdDate,
    };
