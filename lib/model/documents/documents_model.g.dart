// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsModel _$DocumentsModelFromJson(Map<String, dynamic> json) {
  return DocumentsModel(
    json['documentMasterGuid'] as String,
    json['documentTypeId'] as String,
    json['documentType'] as String,
    json['documentDescription'] as String,
    json['fileLocation'] as String,
    json['fileName'] as String,
    json['createdDate'] as String,
  );
}

Map<String, dynamic> _$DocumentsModelToJson(DocumentsModel instance) =>
    <String, dynamic>{
      'documentMasterGuid': instance.documentMasterGuid,
      'documentTypeId': instance.documentTypeId,
      'documentType': instance.documentType,
      'documentDescription': instance.documentDescription,
      'fileLocation': instance.fileLocation,
      'fileName': instance.fileName,
      'createdDate': instance.createdDate,
    };
