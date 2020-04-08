

import 'package:etteo_demo/api/parts_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class PartsTypeSync extends BaseSync<PartsTypeModel> {
  PartsApi _partsApi = PartsApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(), MasterTable.PartType.toString(), 'masterDataName');

    List<PartsTypeModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(PartsTypeModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _partsApi.getAllPartsType();
  }
}
