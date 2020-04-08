import 'package:json_annotation/json_annotation.dart';

part 'owner_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OwnerModel {
  String ownerId;
  String ownerName;

  OwnerModel(this.ownerId, this.ownerName);
  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  toJson() {
    return _$OwnerModelToJson(this);
  }
}
