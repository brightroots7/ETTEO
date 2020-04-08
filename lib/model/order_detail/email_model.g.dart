// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailModel _$EmailModelFromJson(Map<String, dynamic> json) {
  return EmailModel(
    json['emailId'] as int,
    json['emailAddress'] as String,
    json['emailTypeId'] as int,
  );
}

Map<String, dynamic> _$EmailModelToJson(EmailModel instance) =>
    <String, dynamic>{
      'emailId': instance.emailId,
      'emailAddress': instance.emailAddress,
      'emailTypeId': instance.emailTypeId,
    };
