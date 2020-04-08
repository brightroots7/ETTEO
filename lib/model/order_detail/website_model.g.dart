// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteModel _$WebsiteModelFromJson(Map<String, dynamic> json) {
  return WebsiteModel(
    json['websiteId'] as int,
    json['websiteUrl'] as String,
    json['websiteDescription'] as String,
  );
}

Map<String, dynamic> _$WebsiteModelToJson(WebsiteModel instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'websiteUrl': instance.websiteUrl,
      'websiteDescription': instance.websiteDescription,
    };
