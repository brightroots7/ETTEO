import 'package:json_annotation/json_annotation.dart';

part 'notes_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class NotesModel {
  String noteId;
  String noteData;
  String createdDate;
  // String fullName;
  String createdBy;
  String createdUserId;

  NotesModel(this.noteId, this.noteData, this.createdDate, this.createdBy,
      this.createdUserId);

  factory NotesModel.fromJson(Map<String, dynamic> json) =>
      _$NotesModelFromJson(json);

  toJson() {
    return _$NotesModelToJson(this);
  }

  // setSpliteNotesWithDate() {
  //   if (noteData.indexOf('--') != -1) {
  //     splitNotesWithDate = noteData.split('--');
  //   } else {
  //     // To fix the URC parse isse in dart
  //     if (createdDate.indexOf('.') != -1) {
  //       createdDate = createdDate.substring(0, createdDate.indexOf('.'));
  //     }

  //     splitNotesWithDate = [noteData, createdDate];
  //   }
  // }
}
