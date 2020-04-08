
import 'package:etteo_demo/api/service_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/services/service_status_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class ServiceStatusSync extends BaseSync<ServiceStatusModel> {
  ServiceApi _serviceApi = ServiceApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
     print("ServiceStatusSync getAll _serviceApi _serviceApi _serviceApi _serviceApi _serviceApi");
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.ServiceStatus.toString(),
        'masterDataName');

    List<ServiceStatusModel> returnResult = List();
    print("ServiceStatusSync getAll _serviceApi _serviceApi _serviceApi _serviceApi result:$result");
    result.forEach((f) =>
        returnResult.add(ServiceStatusModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _serviceApi.getServiceStatusAndItsSubStatus();
  }
}
