import 'dart:convert';
import 'dart:core';

import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/order_detail/address_model.dart';
import 'package:etteo_demo/model/order_detail/email_model.dart';
import 'package:etteo_demo/model/order_detail/phone_model.dart';
import 'package:etteo_demo/model/order_detail/website_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class ContactsModel {
  String contactMasterGuid;
  int contactTypeId;
  String contactFirstName;
  String contactLastName;
  String contactBusinessName;
  int contactEntityTypeId;

  @JsonKey(
      name: 'addresses', fromJson: _addressModelFromJson, toJson: _modelToJson)
  List<AddressModel> addresses;

  @JsonKey(name: 'emails', fromJson: _emailModelFromJson, toJson: _modelToJson)
  List<EmailModel> emails;

  @JsonKey(
      name: 'phoneNos', fromJson: _phoneModelFromJson, toJson: _modelToJson)
  List<PhoneModel> phoneNos;

  @JsonKey(
      name: 'websites', fromJson: _websiteModelFromJson, toJson: _modelToJson)
  List<WebsiteModel> websites;

  ContactsModel(
      this.contactMasterGuid,
      this.contactTypeId,
      this.contactFirstName,
      this.contactLastName,
      this.contactBusinessName,
      this.contactEntityTypeId,
      this.addresses,
      this.emails,
      this.phoneNos,
      this.websites);

  factory ContactsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactsModelFromJson(json);

  toJson() {
    return _$ContactsModelToJson(this);
  }

  static _modelToJson(dynamic j) => encode(j);

  static _addressModelFromJson(dynamic jsonString) {
    List<AddressModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(AddressModel.fromJson(getMap(f))));

    return list;
  }

  static _emailModelFromJson(dynamic jsonString) {
    List<EmailModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(EmailModel.fromJson(getMap(f))));

    return list;
  }

  static _phoneModelFromJson(dynamic jsonString) {
    List<PhoneModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(PhoneModel.fromJson(getMap(f))));

    return list;
  }

  static _websiteModelFromJson(dynamic jsonString) {
    List<WebsiteModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(WebsiteModel.fromJson(getMap(f))));

    return list;
  }
}
