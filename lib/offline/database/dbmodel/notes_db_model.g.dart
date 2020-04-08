// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesDBModel _$NotesDBModelFromJson(Map<String, dynamic> json) {
  return NotesDBModel(
    id: json['id'] as int,
    orderId: json['orderId'] as String,
    notesJson: NotesDBModel._routeModelFromJson(json['notesJson']),
    createdDate: json['createdDate'] as String,
    syncFlag: json['syncFlag'] as int,
  );
}

Map<String, dynamic> _$NotesDBModelToJson(NotesDBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'notesJson': NotesDBModel._routeModelToJson(instance.notesJson),
      'createdDate': instance.createdDate,
      'syncFlag': instance.syncFlag,
    };
