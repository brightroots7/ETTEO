

import 'package:etteo_demo/api/parts_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class PartsStatusSync extends BaseSync<PartsStatusModel> {
  PartsApi _partsApi = PartsApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.PartStatus.toString(),
        'masterDataName');
      print("PartsStatusSync get data from offline database from  result:$result");
    List<PartsStatusModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(PartsStatusModel.fromJson(decode(f.jsonData))));
       
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _partsApi.getAllPartsStatus();
  }
}
