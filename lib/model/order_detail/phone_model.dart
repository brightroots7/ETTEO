import 'package:json_annotation/json_annotation.dart';

part 'phone_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class PhoneModel {
  int phoneId;
  String phoneNumber;
  int phoneNumberTypeId;

  PhoneModel(this.phoneId, this.phoneNumber, this.phoneNumberTypeId);

  factory PhoneModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneModelFromJson(json);

  toJson() {
    return _$PhoneModelToJson(this);
  }
}
