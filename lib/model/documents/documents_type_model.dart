
import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'documents_type_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class DocumentsTypeModel extends BaseModel {
  String orderDocumentTypeId;
  String serviceProviderId;
  String documentTypeId;
  String documentTypeName;
  bool isDelegate;

  DocumentsTypeModel(
    this.orderDocumentTypeId,
    this.serviceProviderId,
    this.documentTypeId,
    this.documentTypeName,
    this.isDelegate,
  );

  factory DocumentsTypeModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentsTypeModelFromJson(json);

  toJson() {
    return _$DocumentsTypeModelToJson(this);
  }

  @override
  get key => documentTypeId;
}
