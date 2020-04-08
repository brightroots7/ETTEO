import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'all_orders_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class AllOrdersModel extends BaseModel {
  String orderId;
  String ownerId;
  String ownerName;
  String orderNo;
  String customerId;
  String customerName;
  String customerAddress;
  String customerPhoneNo;
  String customerEmailAddress;
  String orderSource;
  String orderSourceId;
  String orderStatus;
  String lineOfBusiness;
  String flags;

  AllOrdersModel(this.orderId,this.ownerId, this.ownerName, this.orderNo, this.customerId,
     this.customerName, this.customerAddress , this.customerPhoneNo, this.customerEmailAddress, this.orderSource,
     this.orderSourceId, this.orderStatus, this.lineOfBusiness, this.flags);

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersModelFromJson(json);

  toJson() {
    return _$AllOrdersModelToJson(this);
  }

  @override
  // TODO: implement key
  get key => null;
}



