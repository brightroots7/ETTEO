
import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_sub_status_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ServiceSubStatusModel extends BaseModel {
  String serviceSubStatusId;
  String serviceSubStatusName;
  bool isRequiredNotes;
  bool isDelegate;

  ServiceSubStatusModel(this.serviceSubStatusId, this.serviceSubStatusName,
      this.isDelegate, this.isRequiredNotes);

  factory ServiceSubStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceSubStatusModelFromJson(json);

  toJson() {
    return _$ServiceSubStatusModelToJson(this);
  }

  @override
  get key => serviceSubStatusId;
}
