import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_db_model.dart';

part 'master_data_db_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class MasterDataDBModel extends BaseDatabaseModel {
  int id;
  String key;
  String parentKey;
  String masterDataName;
  String jsonData;
  String createdDate;

  MasterDataDBModel(
      {this.id,
      this.key,
      this.parentKey,
      this.masterDataName,
      this.jsonData,
      this.createdDate});

  factory MasterDataDBModel.fromJson(Map<String, dynamic> j) =>
      _$MasterDataDBModelFromJson(j);

  Map<String, dynamic> toJson() => _$MasterDataDBModelToJson(this);

  // static _routeModelFromJson(dynamic j) => NotesModel.fromJson(decode(j));
  // static _routeModelToJson(dynamic j) => json.encode(j);

  @override
  List<String> columns() {
    return [
      'id',
      'key',
      'parentKey',
      'masterDataName',
      'jsonData',
      'createdDate'
    ];
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return _$MasterDataDBModelFromJson(map);
  }

  @override
  String tableName() {
    return "masterdata";
  }

  @override
  Map<String, dynamic> toMap() {
    return _$MasterDataDBModelToJson(this);
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
