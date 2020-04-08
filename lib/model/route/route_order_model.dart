import 'dart:convert';

import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_order_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteOrderModel {
  String orderId;
  String etteoOrderId;
  String customerId;
  String customerName;
  String customerAddress;
  String customerPhoneNo;
  String customerCityStateZip;
  String customerEmailAddress;
  String orderSource;
  String sourceId;
  String orderStatus;
  String lineOfBusiness;
  String lineOfBusinessId;

  @JsonKey(
      name: 'flags', fromJson: _routeflagModelFromJson, toJson: _modelToJson)
  List<RouteFlagModel> flags;

  @JsonKey(
      name: 'service',
      fromJson: _routeServiceModelFromJson,
      toJson: _routeServciceModelToJson)
  RouteServiceModel service;

  RouteOrderModel(
      {this.orderId,
      this.etteoOrderId,
      this.customerId,
      this.customerName,
      this.customerAddress,
      this.customerPhoneNo,
      this.customerCityStateZip,
      this.customerEmailAddress,
      this.orderSource,
      this.sourceId,
      this.orderStatus,
      this.lineOfBusiness,
      this.lineOfBusinessId,
      this.flags});

  factory RouteOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RouteOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteOrderModelToJson(this);

  static _routeServiceModelFromJson(dynamic jsonString) {
    return RouteServiceModel.fromJson(getMap(jsonString));
  }

  static _routeServciceModelToJson(dynamic j) => json.encode(j);

  static _routeflagModelFromJson(dynamic jsonString) {
    List<RouteFlagModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(RouteFlagModel.fromJson(getMap(f))));

    return list;
  }

  static _modelToJson(dynamic j) => json.encode(j);
}
