
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class AddressModel {
  int addressId;
  int addressTypeId;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String addressLine4;
  String addressLine5;
  String city;
  String state;
  String postalCode;
  String country;
  String latitude;
  String longitude;

  AddressModel(
      this.addressId,
      this.addressTypeId,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.addressLine4,
      this.addressLine5,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.latitude,
      this.longitude);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  toJson() {
    return _$AddressModelToJson(this);
  }

  cityStatePostalCode() {
    return checkEmpty(city) +
        ' ' +
        checkEmpty(state) +
        ' ' +
        checkEmpty(postalCode);
  }
}
