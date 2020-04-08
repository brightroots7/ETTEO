import 'dart:convert';



import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/address_model.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/order_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_detail_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class OrderDetailModel {
  String orderId;
  int modelVersion;
  String createdDate;
  String orderStatus;

  @JsonKey(name: 'order', fromJson: _modelFromJson, toJson: _modelToJson)
  OrderModel order;

  OrderDetailModel(this.orderId, this.modelVersion, this.createdDate,
      this.orderStatus, this.order);

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  toJson() {
    return _$OrderDetailModelToJson(this);
  }

  static _modelToJson(dynamic j) => json.encode(j);
  static _modelFromJson(dynamic jsonString) {
    return OrderModel.fromJson(getMap(jsonString));
  }

  String phoneNumber() {
    if (order.contacts != null &&
        order.contacts.length > 0 &&
        order.contacts[0].phoneNos != null &&
        order.contacts[0].phoneNos.length > 0) {
      return order.contacts[0].phoneNos[0].phoneNumber;
    }
    return "";
  }

  AddressModel address() {
    if (order.contacts != null &&
        order.contacts.length > 0 &&
        order.contacts[0].addresses != null &&
        order.contacts[0].addresses.length > 0) {
      return order.contacts[0].addresses[0];
    }
    // return AddressModel();
  }

  String contactBusinessName() {
    if (order.contacts != null && order.contacts.length > 0) {
      return order.contacts[0].contactBusinessName;
    }
    return "";
  }

  addNoteList(List<NotesModel> notes) {
    if (order.notes == null) {
      order.notes = List();
    }
    notes.forEach((n) => {order.notes.add(n)});
  }

  void addServiceList(ServicesModel service) {
    if (order.services == null) {
      order.services = List();
    }
    order.services.add(service);
  }

  void addPartsList(PartsModel part) {
    if (order.units == null) {
      order.units = List();
    }
    order.units.add(part);
  }

  void addDocument(DocumentsModel document) {
    if (order.documents == null) {
      order.documents = List();
    }
    order.documents.add(document);
  }

  void addDocumentList(List<DocumentsModel> documents) {
    if (order.documents == null) {
      order.documents = List();
    }
    order.documents.addAll(documents);
  }

  void addFinance(OrderFinanceModel finance) {
    order.finance = finance;
  }
}
