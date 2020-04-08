import 'package:etteo_demo/api/route_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class RouteStatusSync extends BaseSync<RouteStatusModel> {
  RouteApi _routeProviderApi = RouteApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.RouteStatus.toString(),
        'masterDataName');
     
    List<RouteStatusModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(RouteStatusModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _routeProviderApi.getAllRouteStatus();
  }
}

