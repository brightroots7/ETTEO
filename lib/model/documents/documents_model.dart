import 'dart:typed_data';


import 'package:etteo_demo/helpers/file_helper.dart';
import 'package:json_annotation/json_annotation.dart';
part 'documents_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class DocumentsModel {
  String documentMasterGuid;
  String documentTypeId;
  String documentType;
  String documentDescription;
  String fileLocation;
  String fileName;
  String createdDate;

  DocumentsModel(
      this.documentMasterGuid,
      this.documentTypeId,
      this.documentType,
      this.documentDescription,
      this.fileLocation,
      this.fileName,
      this.createdDate);

  factory DocumentsModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentsModelFromJson(json);

  toJson() {
    return _$DocumentsModelToJson(this);
  }

  Future<String> getFileLocation(ByteData byteData, String name) async {
    return (await saveFile(byteData, name)).absolute.path;
  }

  setFileName(String name) {
    String srcFileName = name.substring(0, name.lastIndexOf('.'));
    String extn = name.substring(name.lastIndexOf("."), name.length);
    if (extn.toLowerCase().contains('heic')) {
      this.fileName = srcFileName + '.jpeg';
    } else {
      this.fileName = name;
    }
  }
}
