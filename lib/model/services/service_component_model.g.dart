// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_component_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceComponentModel _$ServiceComponentModelFromJson(
    Map<String, dynamic> json) {
  return ServiceComponentModel(
    json['serviceComponentGuid'] as String,
    json['serviceComponentName'] as String,
  );
}

Map<String, dynamic> _$ServiceComponentModelToJson(
        ServiceComponentModel instance) =>
    <String, dynamic>{
      'serviceComponentGuid': instance.serviceComponentGuid,
      'serviceComponentName': instance.serviceComponentName,
    };
