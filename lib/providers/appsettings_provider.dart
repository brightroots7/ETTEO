import 'package:etteo_demo/api/api.dart';

class AppSettingsProvider {
  final AppSettingsApi appSettingsApi = AppSettingsApi();

  /// Get the App Settings.
  Future<Map> getAppSettings() {
    return appSettingsApi.getAppSettings();
  }
}