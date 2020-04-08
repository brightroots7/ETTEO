// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_of_business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineOfBusinessModel _$LineOfBusinessModelFromJson(Map<String, dynamic> json) {
  return LineOfBusinessModel(
    json['lineOfBusinessId'] as String,
    json['businessDescription'] as String,
    json['lineOfBusinessGuid'] as String,
    json['lineOfBusinessDescription'] as String,
  );
}

Map<String, dynamic> _$LineOfBusinessModelToJson(
        LineOfBusinessModel instance) =>
    <String, dynamic>{
      'lineOfBusinessId': instance.lineOfBusinessId,
      'businessDescription': instance.businessDescription,
      'lineOfBusinessGuid': instance.lineOfBusinessGuid,
      'lineOfBusinessDescription': instance.lineOfBusinessDescription,
    };
