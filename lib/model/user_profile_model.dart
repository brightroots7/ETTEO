import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/order_detail/address_model.dart';
import 'package:etteo_demo/model/order_detail/website_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class UserProfileModel extends BaseModel {
  String firstName;
  String lastName;

  String emailAddress;
  String phoneNumber;
  String contactId;
  String resourceId;
  String userId;
  AddressModel address;
  WebsiteModel website;
  List<String> roles;
  List<String> permissions;

  String timeZoneId;
  String timeZoneName;
  String timeZoneTime;
  String profileImage;

  UserProfileModel(
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.contactId,
    this.userId,
    this.resourceId,
    this.timeZoneId,
    this.timeZoneName,
    this.timeZoneTime,
    this.profileImage,
    this.address,
    this.website,
    this.roles,
    this.permissions
  );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  toJson() {
    return _$UserProfileModelToJson(this);
  }

  String get fullName {
    return this.firstName + ' ' + this.lastName;
  }

  get fullname => firstName + ' ' + lastName;

  @override
  get key => userId;
}
