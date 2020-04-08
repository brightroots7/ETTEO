import 'package:json_annotation/json_annotation.dart';

part 'order_source_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OrderSourceModel {
  String orderSourceId;
  String externalOrderId;
  String orderSourceName;

  OrderSourceModel(
      this.orderSourceId, this.externalOrderId, this.orderSourceName);

  factory OrderSourceModel.fromJson(Map<String, dynamic> json) =>
      _$OrderSourceModelFromJson(json);

  toJson() {
    return _$OrderSourceModelToJson(this);
  }
}
