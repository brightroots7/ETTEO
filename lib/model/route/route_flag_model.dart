import 'package:json_annotation/json_annotation.dart';

part 'route_flag_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteFlagModel {
  String color;

  RouteFlagModel(this.color);

  factory RouteFlagModel.fromJson(Map<String, dynamic> j) =>
      _$RouteFlagModelFromJson(j);

  Map<String, dynamic> toJson() => _$RouteFlagModelToJson(this);
}
