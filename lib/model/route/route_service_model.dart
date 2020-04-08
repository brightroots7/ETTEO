import 'package:json_annotation/json_annotation.dart';

part 'route_service_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RouteServiceModel implements Comparable<RouteServiceModel> {
  String service;
  String serviceComponent;
  String serviceType;
  String description;
  String scheduleDate;
  String serviceStatus;
  String routeStatusId;
  String routeStatus;
  String serviceProviderName;
  String serviceProviderId;
  String resourceName;
  String resourceId;
  String timeStart;
  String timeEnd;

  RouteServiceModel(
      this.service,
      this.serviceComponent,
      this.serviceType,
      this.description,
      this.scheduleDate,
      this.serviceStatus,
      this.routeStatusId,
      this.routeStatus,
      this.serviceProviderName,
      this.serviceProviderId,
      this.resourceName,
      this.resourceId,
      this.timeStart,
      this.timeEnd);

  factory RouteServiceModel.fromJson(Map<String, dynamic> json) =>
      _$RouteServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteServiceModelToJson(this);

  @override
  int compareTo(RouteServiceModel other) {
    // Returns a negative value if this is ordered before other,
    // a positive value if this is ordered after other,
    // or zero if this and other are equivalent.

    int ret;

    bool isStartAm = timeStart.contains('am');
    bool isOtherAm = other.timeStart.contains('am');

    int startTime = isStartAm
        ? int.parse(timeStart.substring(0, timeStart.indexOf('am')))
        : int.parse(timeStart.substring(0, timeStart.indexOf('pm')));

    int otherStartTime = isOtherAm
        ? int.parse(other.timeStart.substring(0, other.timeStart.indexOf('am')))
        : int.parse(
            other.timeStart.substring(0, other.timeStart.indexOf('pm')));

    if (isStartAm && isOtherAm) {
      if (startTime < otherStartTime) {
        ret = -1;
      } else if (startTime == otherStartTime) {
        ret = 0;
      } else if (startTime > otherStartTime) {
        ret = 1;
      }
    } else if (!isStartAm && !isOtherAm) {
      if (otherStartTime == 12 || startTime > otherStartTime) {
        return 1;
      } else if (startTime == 12 || startTime < otherStartTime) {
        ret = -1;
      } else if (startTime == otherStartTime) {
        ret = 0;
      }
    } else if (isStartAm && !isOtherAm) {
      ret = -1;
    } else if (!isStartAm && isOtherAm) {
      if (startTime == 12 || startTime < otherStartTime) {
        return 1;
      } else if (startTime == otherStartTime) {
        ret = 0;
      } else if (startTime > otherStartTime) {
        ret = -1;
      }
    }
    return ret;
  }
}
