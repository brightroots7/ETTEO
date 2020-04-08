// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesModel _$NotesModelFromJson(Map<String, dynamic> json) {
  return NotesModel(
    json['noteId'] as String,
    json['noteData'] as String,
    json['createdDate'] as String,
    json['createdBy'] as String,
    json['createdUserId'] as String,
  );
}

Map<String, dynamic> _$NotesModelToJson(NotesModel instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'noteData': instance.noteData,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'createdUserId': instance.createdUserId,
    };
