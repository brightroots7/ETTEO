import 'dart:convert';

import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/contacts_model.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/line_of_business_model.dart';
import 'package:etteo_demo/model/order_detail/market_model.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/order_source_model.dart';
import 'package:etteo_demo/model/order_detail/owner_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OrderModel {
  String etteoOrderId;
  @JsonKey(
      name: 'lineOfBusiness',
      fromJson: _lineofBusinessModelFromJson,
      toJson: _modelToJson)
  LineOfBusinessModel lineOfBusiness;

  @JsonKey(name: 'market', fromJson: _marketModelFromJson, toJson: _modelToJson)
  MarketModel market;

  @JsonKey(
      name: 'orderSource',
      fromJson: _orderSourceModelFromJson,
      toJson: _modelToJson)
  OrderSourceModel orderSource;

  @JsonKey(name: 'owner', fromJson: _ownerModelFromJson, toJson: _modelToJson)
  OwnerModel owner;

  @JsonKey(
      name: 'contacts', fromJson: _contactsModelFromJson, toJson: _modelToJson)
  List<ContactsModel> contacts;

  @JsonKey(name: 'flags', fromJson: _flagsModelFromJson, toJson: _modelToJson)
  List<FlagsModel> flags;

  @JsonKey(
      name: 'services', fromJson: _servicesModelFromJson, toJson: _modelToJson)
  List<ServicesModel> services;

  @JsonKey(name: 'units', fromJson: _partsModelFromJson, toJson: _modelToJson)
  List<PartsModel> units;

  @JsonKey(name: 'notes', fromJson: _notesModelFromJson, toJson: _modelToJson)
  List<NotesModel> notes;

  @JsonKey(
      name: 'documents',
      fromJson: _documentsModelFromJson,
      toJson: _modelToJson)
  List<DocumentsModel> documents;

  @JsonKey(
      name: 'finance',
      fromJson: _ownerFinanceModelFromJson,
      toJson: _modelToJson)
  OrderFinanceModel finance;

  OrderModel(
      this.etteoOrderId,
      this.lineOfBusiness,
      this.market,
      this.orderSource,
      this.owner,
      this.contacts,
      this.flags,
      this.services,
      this.finance);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  static _modelToJson(dynamic j) => json.encode(j);

  static _lineofBusinessModelFromJson(dynamic jsonString) {
    return LineOfBusinessModel.fromJson(getMap(jsonString));
  }

  static _marketModelFromJson(dynamic jsonString) {
    return MarketModel.fromJson(getMap(jsonString));
  }

  static _orderSourceModelFromJson(dynamic jsonString) {
    return OrderSourceModel.fromJson(getMap(jsonString));
  }

  static _ownerModelFromJson(dynamic jsonString) {
    return OwnerModel.fromJson(getMap(jsonString));
  }

  static _ownerFinanceModelFromJson(dynamic jsonString) {
    return OrderFinanceModel.fromJson(getMap(jsonString));
  }

  static _contactsModelFromJson(dynamic jsonString) {
    List<ContactsModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(ContactsModel.fromJson(getMap(f))));

    return list;
  }

  static _notesModelFromJson(dynamic jsonString) {
    List<NotesModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(NotesModel.fromJson(getMap(f))));

    return list;
  }

  static _servicesModelFromJson(dynamic jsonString) {
    List<ServicesModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(ServicesModel.fromJson(getMap(f))));
    return list;
  }

  static _partsModelFromJson(dynamic jsonString) {
    List<PartsModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(PartsModel.fromJson(getMap(f))));
    return list;
  }

  static _flagsModelFromJson(dynamic jsonString) {
    List<FlagsModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(FlagsModel.fromJson(getMap(f))));
    return list;
  }

  static _documentsModelFromJson(dynamic jsonString) {
    List<DocumentsModel> list = List();
    List templist = List();

    if (jsonString is String) {
      templist = json.decode(jsonString);
    } else if (jsonString is List) {
      templist = jsonString;
    }
    templist.forEach((f) => list.add(DocumentsModel.fromJson(getMap(f))));
    return list;
  }
}
