import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/services/service_sub_status_model.dart';

import 'package:json_annotation/json_annotation.dart';
part 'service_status_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ServiceStatusModel extends BaseModel {
  String serviceStatusId;
  String serviceStatusName;
  bool isRequiredNotes;
  bool isDelegate;

  List<ServiceSubStatusModel> serviceSubStatuses;

  ServiceStatusModel(this.serviceStatusId, this.serviceStatusName,
      this.isDelegate, this.isRequiredNotes);

  factory ServiceStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceStatusModelFromJson(json);

  toJson() {
    return _$ServiceStatusModelToJson(this);
  }

  @override
  get key => serviceStatusId;
}
