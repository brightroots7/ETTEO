import 'package:json_annotation/json_annotation.dart';

part 'email_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class EmailModel {
  int emailId;
  String emailAddress;
  int emailTypeId;

  EmailModel(this.emailId, this.emailAddress, this.emailTypeId);

  factory EmailModel.fromJson(Map<String, dynamic> json) =>
      _$EmailModelFromJson(json);

  toJson() {
    return _$EmailModelToJson(this);
  }
}
