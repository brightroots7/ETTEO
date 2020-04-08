import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_db_model.dart';

part 'sync_queue_db_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class SyncQueueDBModel extends BaseDatabaseModel {
  int id;
  String key;
  String value;
  String event;
  String jsonPostData;
  String error;
  int syncFlag;
  String createdDate;

  SyncQueueDBModel(
      {this.id,
      this.key,
      this.value,
      this.event,
      this.jsonPostData,
      this.createdDate,
      this.error,
      this.syncFlag});

  factory SyncQueueDBModel.fromJson(Map<String, dynamic> j) =>
      _$SyncQueueDBModelFromJson(j);

  Map<String, dynamic> toJson() => _$SyncQueueDBModelToJson(this);

  // static _routeModelFromJson(dynamic j) => NotesModel.fromJson(decode(j));
  // static _routeModelToJson(dynamic j) => json.encode(j);

  @override
  List<String> columns() {
    return [
      'id',
      'key',
      'value',
      'event',
      'jsonPostData',
      'createdDate',
      'error',
      'syncFlag'
    ];
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return _$SyncQueueDBModelFromJson(map);
  }

  @override
  String tableName() {
    return "syncqueue";
  }

  @override
  Map<String, dynamic> toMap() {
    return _$SyncQueueDBModelToJson(this);
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    return {
      'error': error,
      'syncFlag': syncFlag,
    };
  }

  @override
  Future<void> deleteAll() async {
    await DatabaseHelper().deleteAll(this);
  }
}
