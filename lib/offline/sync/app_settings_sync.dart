import 'package:etteo_demo/api/appsettings_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class AppSettingsSync extends BaseSync<AppSettingsModel> {
  AppSettingsApi _appSettingsApi = AppSettingsApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.AppSettings.toString(),
        'masterDataName');

    List<AppSettingsModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(AppSettingsModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    Map map = await _appSettingsApi.getAppSettings();
    AppSettingsModel appSettingsModel = AppSettingsModel.fromJson(map);
    return Future(() => List<AppSettingsModel>.filled(1, appSettingsModel));
  }
}
