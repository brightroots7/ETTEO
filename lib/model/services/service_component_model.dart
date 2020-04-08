import 'package:etteo_demo/model/base_model.dart';

import 'package:json_annotation/json_annotation.dart';
part 'service_component_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ServiceComponentModel extends BaseModel {
  String serviceComponentGuid;
  String serviceComponentName;

  ServiceComponentModel(this.serviceComponentGuid, this.serviceComponentName);

  factory ServiceComponentModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceComponentModelFromJson(json);

  toJson() {
    return _$ServiceComponentModelToJson(this);
  }

  @override
  get key => serviceComponentGuid;
}
