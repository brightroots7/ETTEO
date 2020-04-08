
import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_mode_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class PaymentModeModel extends BaseModel {
  String paymentModeId;
  String paymentMode;

  PaymentModeModel(this.paymentModeId, this.paymentMode);

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModeModelFromJson(json);

  toJson() {
    return _$PaymentModeModelToJson(this);
  }

  @override
  get key => this.paymentMode;
}
