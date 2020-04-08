// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncQueueDBModel _$SyncQueueDBModelFromJson(Map<String, dynamic> json) {
  return SyncQueueDBModel(
    id: json['id'] as int,
    key: json['key'] as String,
    value: json['value'] as String,
    event: json['event'] as String,
    jsonPostData: json['jsonPostData'] as String,
    createdDate: json['createdDate'] as String,
    error: json['error'] as String,
    syncFlag: json['syncFlag'] as int,
  );
}

Map<String, dynamic> _$SyncQueueDBModelToJson(SyncQueueDBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
      'event': instance.event,
      'jsonPostData': instance.jsonPostData,
      'error': instance.error,
      'syncFlag': instance.syncFlag,
      'createdDate': instance.createdDate,
    };
