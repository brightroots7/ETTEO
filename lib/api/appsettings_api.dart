import 'package:dio/dio.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/helpers/app_config.dart';

class AppSettingsApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettingsUrl;

  AppSettingsApi();

  String _configurl() =>
      appendSlashIfNotExists(url: apiBaseUrl, relativePath: 'api/settings');

  /// Get the App Settings
  Future<Map> getAppSettings() async {
    print(_configurl());
    Response response;
    try {
      response = await getDio().then((dio) => dio.get(_configurl()));
      print("AppSetting response Data:${response.data}");
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}