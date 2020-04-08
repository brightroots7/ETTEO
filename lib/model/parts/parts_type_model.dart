
import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parts_type_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class PartsTypeModel extends BaseModel {
  int unitTypeId;
  String unitTypeDescription;

  PartsTypeModel(this.unitTypeId, this.unitTypeDescription);

  factory PartsTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PartsTypeModelFromJson(json);

  toJson() {
    return _$PartsTypeModelToJson(this);
  }

  @override
  get key => unitTypeId;
}
