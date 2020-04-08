import 'dart:convert';

import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';

import 'package:json_annotation/json_annotation.dart';

part 'route_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteModel {
  int id;
  String routeId;
  int marketId;
  String marketName;
  String routeDate;
  String serviceProviderId;

  @JsonKey(
      name: 'order',
      fromJson: _routeOrderModelFromJson,
      toJson: _routeOrderModelToJson)
  RouteOrderModel order;

  RouteModel(this.id, this.routeId, this.marketId, this.marketName,
      this.routeDate, this.serviceProviderId, this.order);

  factory RouteModel.fromJson(Map<String, dynamic> j) =>
      _$RouteModelFromJson(j);

  Map<String, dynamic> toJson() => _$RouteModelToJson(this);

  static _routeOrderModelToJson(dynamic j) => json.encode(j);
  static _routeOrderModelFromJson(dynamic jsonString) {
    return RouteOrderModel.fromJson(getMap(jsonString));
  }

  bool operator ==(Object object) =>
      object is RouteModel && object.routeId == this.routeId;

  int _hashCode;
  @override
  int get hashCode {
    if (_hashCode == null) {
      _hashCode = routeId.hashCode;
    }
    return _hashCode;
  }
}
