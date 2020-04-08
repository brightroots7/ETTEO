import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'line_of_business_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class LineOfBusinessModel extends BaseModel {
  // Used in Masterdata
  String lineOfBusinessId;
  String businessDescription;

  String lineOfBusinessGuid;
  String lineOfBusinessDescription;

  LineOfBusinessModel(this.lineOfBusinessId, this.businessDescription,
      this.lineOfBusinessGuid, this.lineOfBusinessDescription);

  factory LineOfBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$LineOfBusinessModelFromJson(json);

  toJson() {
    return _$LineOfBusinessModelToJson(this);
  }

  @override
  get key => lineOfBusinessId;
}
