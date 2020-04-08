import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_type_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ServiceTypeModel extends BaseModel {
  String serviceTypeGuid;
  String serviceTypeName;
  int noOfHours;

  ServiceTypeModel(this.serviceTypeGuid, this.serviceTypeName, this.noOfHours);

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeModelFromJson(json);

  toJson() {
    return _$ServiceTypeModelToJson(this);
  }

  @override
  get key => serviceTypeGuid;
}
