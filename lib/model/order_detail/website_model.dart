import 'package:json_annotation/json_annotation.dart';

part 'website_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class WebsiteModel {
  int websiteId;
  String websiteUrl;
  String websiteDescription;

  WebsiteModel(this.websiteId, this.websiteUrl, this.websiteDescription);

  factory WebsiteModel.fromJson(Map<String, dynamic> json) =>
      _$WebsiteModelFromJson(json);

  toJson() {
    return _$WebsiteModelToJson(this);
  }
}
