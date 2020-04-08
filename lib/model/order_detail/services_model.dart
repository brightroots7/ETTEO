import 'package:json_annotation/json_annotation.dart';

part 'services_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ServicesModel {
  String serviceId;
  String serviceProviderId;
  String serviceTypeId;
  String serviceType;
  String serviceComponentId;
  String serviceComponent;
  String serviceDescription;
  String serviceStatus;
  String serviceStatusId;
  String serviceSubStatusId;
  String serviceSubStatus;
  String serviceSku;
  int serviceQuantity;
  String serviceCost;
  String routeGuid;
  String serviceDate;
  int serviceTime;
  String serviceProvider;
  String resourceId;
  String resource;
  String timeStart;
  String timeEnd;
  String serviceCompletedDate;

  ServicesModel(
      this.serviceId,
      this.serviceProviderId,
      this.serviceTypeId,
      this.serviceType,
      this.serviceComponentId,
      this.serviceComponent,
      this.serviceDescription,
      this.serviceStatus,
      this.serviceStatusId,
      this.serviceSubStatus,
      this.serviceSubStatusId,
      this.serviceSku,
      this.serviceQuantity,
      this.serviceCost,
      this.routeGuid,
      this.serviceDate,
      this.serviceTime,
      this.serviceProvider,
      this.resourceId,
      this.resource,
      this.timeStart,
      this.timeEnd,
      this.serviceCompletedDate);

  factory ServicesModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesModelFromJson(json);

  toJson() {
    return _$ServicesModelToJson(this);
  }
}
