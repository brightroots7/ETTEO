import 'package:etteo_demo/model/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_status_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteStatusModel extends BaseModel {
  String routeStatusId;
  String routeStatusDescription;
  String routeStatusUpdatedTime;
  bool isDelegate;
  String routeIcon;
  String createdUserId;
  String createdDate;

  RouteStatusModel(
    this.routeStatusId,
    this.routeStatusDescription,
    this.routeStatusUpdatedTime,
    this.isDelegate,
    this.routeIcon,
    this.createdUserId,
    this.createdDate,
  );

  factory RouteStatusModel.fromJson(Map<String, dynamic> j) =>
      _$RouteStatusModelFromJson(j);

  Map<String, dynamic> toJson() => _$RouteStatusModelToJson(this);

  @override
  get key => routeStatusId;
}
