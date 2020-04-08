import 'dart:convert';


import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_db_model.dart';

part 'route_db_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteDBModel extends BaseDatabaseModel {
  int id;
  String routeId;
  String orderId;

  @JsonKey(
      name: 'routeJson',
      fromJson: _routeModelFromJson,
      toJson: _routeModelToJson)
  RouteModel routeJson;
  String serviceDate;
  String createdDate;
  String updatedDate;
  int syncFlag;

  RouteDBModel(
      {this.id,
      this.routeId,
      this.orderId,
      this.routeJson,
      this.serviceDate,
      this.createdDate,
      this.updatedDate,
      this.syncFlag = 0});

  factory RouteDBModel.fromJson(Map<String, dynamic> j) =>
      _$RouteDBModelFromJson(j);

  Map<String, dynamic> toJson() => _$RouteDBModelToJson(this);

  static _routeModelFromJson(dynamic j) => RouteModel.fromJson(decode(j));
  static _routeModelToJson(dynamic j) => json.encode(j);

  @override
  List<String> columns() {
    return [
      'id',
      'routeId',
      'orderId',
      'routeJson',
      'serviceDate',
      'createdDate',
      'updatedDate',
      'syncFlag'
    ];
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return _$RouteDBModelFromJson(map);
  }

  @override
  String tableName() {
    return "routes";
  }

  @override
  Map<String, dynamic> toMap() {
    return _$RouteDBModelToJson(this);
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    return {
      'routeId': routeId,
      'routeJson': RouteDBModel._routeModelToJson(routeJson),
      'updatedDate': updatedDate
    };
  }

  @override
  Future<void> deleteAll() async {
    await DatabaseHelper().deleteAll(this);
  }
}
