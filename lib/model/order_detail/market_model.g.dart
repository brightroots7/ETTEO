// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketModel _$MarketModelFromJson(Map<String, dynamic> json) {
  return MarketModel(
    json['marketId'] as int,
    json['marketName'] as String,
  );
}

Map<String, dynamic> _$MarketModelToJson(MarketModel instance) =>
    <String, dynamic>{
      'marketId': instance.marketId,
      'marketName': instance.marketName,
    };
