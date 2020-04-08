// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_mode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModeModel _$PaymentModeModelFromJson(Map<String, dynamic> json) {
  return PaymentModeModel(
    json['paymentModeId'] as String,
    json['paymentMode'] as String,
  );
}

Map<String, dynamic> _$PaymentModeModelToJson(PaymentModeModel instance) =>
    <String, dynamic>{
      'paymentModeId': instance.paymentModeId,
      'paymentMode': instance.paymentMode,
    };
