
import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parts_status_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class PartsStatusModel extends BaseModel {
  int unitStatusId;
  String unitStatusDescription;

  PartsStatusModel(this.unitStatusId, this.unitStatusDescription);

  factory PartsStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PartsStatusModelFromJson(json);

  toJson() {
    return _$PartsStatusModelToJson(this);
  }

  @override
  get key => unitStatusId;
}
