// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsTypeModel _$DocumentsTypeModelFromJson(Map<String, dynamic> json) {
  return DocumentsTypeModel(
    json['orderDocumentTypeId'] as String,
    json['serviceProviderId'] as String,
    json['documentTypeId'] as String,
    json['documentTypeName'] as String,
    json['isDelegate'] as bool,
  );
}

Map<String, dynamic> _$DocumentsTypeModelToJson(DocumentsTypeModel instance) =>
    <String, dynamic>{
      'orderDocumentTypeId': instance.orderDocumentTypeId,
      'serviceProviderId': instance.serviceProviderId,
      'documentTypeId': instance.documentTypeId,
      'documentTypeName': instance.documentTypeName,
      'isDelegate': instance.isDelegate,
    };
