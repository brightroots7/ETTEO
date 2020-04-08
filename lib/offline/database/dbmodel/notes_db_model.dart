import 'dart:convert';


import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_db_model.dart';

part 'notes_db_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class NotesDBModel extends BaseDatabaseModel {
  int id;
  String orderId;

  @JsonKey(
      name: 'notesJson',
      fromJson: _routeModelFromJson,
      toJson: _routeModelToJson)
  NotesModel notesJson;
  String createdDate;
  int syncFlag;

  NotesDBModel(
      {this.id,
      this.orderId,
      this.notesJson,
      this.createdDate,
      this.syncFlag = 0});

  factory NotesDBModel.fromJson(Map<String, dynamic> j) =>
      _$NotesDBModelFromJson(j);

  Map<String, dynamic> toJson() => _$NotesDBModelToJson(this);

  static _routeModelFromJson(dynamic j) => NotesModel.fromJson(decode(j));
  static _routeModelToJson(dynamic j) => json.encode(j);

  @override
  List<String> columns() {
    return ['id', 'orderId', 'notesJson', 'createdDate', 'syncFlag'];
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return _$NotesDBModelFromJson(map);
  }

  @override
  String tableName() {
    return "notes";
  }

  @override
  Map<String, dynamic> toMap() {
    return _$NotesDBModelToJson(this);
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    return {};
  }

  @override
  Future<void> deleteAll() async {
    await DatabaseHelper().deleteAll(this);
  }
}
