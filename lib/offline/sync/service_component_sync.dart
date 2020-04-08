

import 'package:etteo_demo/api/line_of_business_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class ServiceComponentSync extends BaseSync<ServiceComponentModel> {
  LineOfBusinessApi _lineOfBusinessApi = LineOfBusinessApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.ServiceComponents.toString(),
        'masterDataName');

    List<ServiceComponentModel> returnResult = List();
    result.forEach((f) =>
        returnResult.add(ServiceComponentModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  Future<List<dynamic>> getAllForLineofBusiness<T extends BaseModel>(
      String lineOfBusinessId) async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.ServiceComponents.toString(),
        'masterDataName');

    List<ServiceComponentModel> returnResult = List();
    result.forEach((f) => {
          if (f.parentKey == lineOfBusinessId)
            {
              returnResult
                  .add(ServiceComponentModel.fromJson(decode(f.jsonData)))
            }
        });

    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _lineOfBusinessApi
        .getAllServiceComponent(params['lineOfBusinessId']);
  }
}
