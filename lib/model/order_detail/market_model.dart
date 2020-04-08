import 'package:json_annotation/json_annotation.dart';
part 'market_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class MarketModel {
  int marketId;
  String marketName;

  MarketModel(this.marketId, this.marketName);

  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);

  toJson() {
    return _$MarketModelToJson(this);
  }
}
