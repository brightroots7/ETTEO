import 'dart:convert';

import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_db_model.dart';

part 'order_detail_db_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OrderDetailDBModel extends BaseDatabaseModel {
  int id;
  String orderId;

  @JsonKey(
      name: 'orderDetailJson',
      fromJson: _routeModelFromJson,
      toJson: _routeModelToJson)
  OrderDetailModel orderDetailJson;
  String serviceDate;
  String createdDate;
  String updatedDate;
  int syncFlag;

  OrderDetailDBModel(
      {this.id,
      this.orderId,
      this.orderDetailJson,
      this.serviceDate,
      this.createdDate,
      this.updatedDate,
      this.syncFlag = 0});

  factory OrderDetailDBModel.fromJson(Map<String, dynamic> j) =>
      _$OrderDetailDBModelFromJson(j);

  Map<String, dynamic> toJson() => _$OrderDetailDBModelToJson(this);

  static _routeModelFromJson(dynamic j) => OrderDetailModel.fromJson(decode(j));
  static _routeModelToJson(dynamic j) => json.encode(j);

  @override
  List<String> columns() {
    return [
      'id',
      'orderId',
      'orderDetailJson',
      'createdDate',
      'updatedDate',
      'syncFlag'
    ];
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return _$OrderDetailDBModelFromJson(map);
  }

  @override
  String tableName() {
    return "orderdetail";
  }

  @override
  Map<String, dynamic> toMap() {
    // return json.decode(json.encode(_$RouteDBModelToJson(this)));
    // return json.decode(json.encode(this));
    return _$OrderDetailDBModelToJson(this);
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'orderId': orderId,
      'orderDetailJson': OrderDetailDBModel._routeModelToJson(orderDetailJson),
      'updatedDate': updatedDate
    };
  }

  @override
  Future<void> deleteAll() async {
    await DatabaseHelper().deleteAll(this);
  }
}
