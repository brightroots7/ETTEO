import 'package:json_annotation/json_annotation.dart';

part 'order_finance_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OrderFinanceModel {
  bool isServiceFeeCollected;
  double amountCollected;
  String paymentModeId;
  String summary;

  OrderFinanceModel(this.isServiceFeeCollected, this.amountCollected,
      this.paymentModeId, this.summary);

  factory OrderFinanceModel.fromJson(Map<String, dynamic> json) =>
      _$OrderFinanceModelFromJson(json);

  toJson() {
    return _$OrderFinanceModelToJson(this);
  }
}
