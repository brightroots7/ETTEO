import 'package:json_annotation/json_annotation.dart';
part 'parts_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class PartsModel {
  String unitId;
  String make;
  String model;
  String serialNumber;
  String unitDescription;
  int unitTypeId;
  String unitType;
  int unitStatusId;
  String unitStatus;
  String estimatedTimeOfArrival;
  String unitLocation;

  PartsModel(
      this.unitId,
      this.make,
      this.model,
      this.serialNumber,
      this.unitDescription,
      this.unitTypeId,
      this.unitType,
      this.unitStatusId,
      this.unitStatus,
      this.estimatedTimeOfArrival,
      this.unitLocation);

  factory PartsModel.fromJson(Map<String, dynamic> json) =>
      _$PartsModelFromJson(json);

  toJson() {
    return _$PartsModelToJson(this);
  }
}
