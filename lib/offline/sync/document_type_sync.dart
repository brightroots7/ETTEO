
import 'package:etteo_demo/api/documents_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class DocumentsTypeSync extends BaseSync<DocumentsTypeModel> {
  DocumentsApi _documentsApi = DocumentsApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.DocumentType.toString(),
        'masterDataName');

    List<DocumentsTypeModel> returnResult = List();
    result.forEach((f) =>
        returnResult.add(DocumentsTypeModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  Future<List<dynamic>>
      getAllDocumentTypesForServiceProvider<T extends BaseModel>(
          String serviceProviderId) async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.DocumentType.toString(),
        'masterDataName');

    List<DocumentsTypeModel> returnResult = List();
    result.forEach((f) => {
          if (f.parentKey == serviceProviderId)
            {returnResult.add(DocumentsTypeModel.fromJson(decode(f.jsonData)))}
        });

    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _documentsApi.getAllDocumentType();
  }
}
