import 'dart:convert';

//// AppSetting enum constants.
enum AppSetting {
  stsAuthority,
  rootApiUrl,
  clientRoot,
  clientId,
  helloSignTestMode
  
}

/// This class will be used to store Appsettings like auth url, root url
/// at global level as a singleton class to serve all over the place in app.
class AppSettings {
  static AppSettings _singleton = new AppSettings._internal();

  factory AppSettings() {
    return _singleton;
  }

  AppSettings._internal();

  Map<String, dynamic> appSettings = Map<String, dynamic>();

  AppSettings loadAppSettingsJson(String appSettingsJson) {
    Map<String, dynamic> map = json.decode(appSettingsJson);
    appSettings.addAll(map);
    return _singleton;
  }

  AppSettings loadMap(Map map) {
    appSettings.clear();
    appSettings.addAll(map);
    return _singleton;
  }

  dynamic get(AppSetting key) => appSettings[key.toString().split('.').last];
}
