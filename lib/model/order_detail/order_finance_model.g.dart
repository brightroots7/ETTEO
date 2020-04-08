// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_finance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderFinanceModel _$OrderFinanceModelFromJson(Map<String, dynamic> json) {
  return OrderFinanceModel(
    json['isServiceFeeCollected'] as bool,
    (json['amountCollected'] as num)?.toDouble(),
    json['paymentModeId'] as String,
    json['summary'] as String,
  );
}

Map<String, dynamic> _$OrderFinanceModelToJson(OrderFinanceModel instance) =>
    <String, dynamic>{
      'isServiceFeeCollected': instance.isServiceFeeCollected,
      'amountCollected': instance.amountCollected,
      'paymentModeId': instance.paymentModeId,
      'summary': instance.summary,
    };
