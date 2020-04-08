import 'package:etteo_demo/model/models.dart';
import 'package:flutter/material.dart';
import 'package:etteo_demo/helpers/helpers.dart';

enum AppEnvironment { DEV, INT, PROD }

enum NetworkConnectivity { ONLINE, OFFLINE }

class AppConfig {
  static final AppConfig _singleton = new AppConfig._internal();

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  AppEnvironment appEnvironment;
  AppSettings appSettings;
  NetworkConnectivity networkConnectivity;
  UserProfileModel userProfile;
  String appName;
  String appSettingsUrl;
  String forgotPasswordUrl;
  String clientSecret;
  String oneSignalAppId;
  ThemeData themeData;
  bool loggingFirstTime = false;

  // Set app configuration with single function
  void setAppConfig(
      {AppEnvironment appEnvironment,
      String appName,
      String appSettingsUrl,
      String forgotPasswordUrl,
      String clientSecret,
      String oneSignalAppId,
      ThemeData themeData}) {
    this.appEnvironment = appEnvironment;
    this.appName = appName;
    this.appSettingsUrl = appSettingsUrl;
    this.forgotPasswordUrl = forgotPasswordUrl;
    this.clientSecret = clientSecret;
    this.themeData = themeData;
    this.oneSignalAppId = oneSignalAppId;
  }

  // Set app configuration with single function
  void resetUserProfile() {
    this.userProfile = null;
  }

  void setAppSettings(AppSettings appSettings) {
    this.appSettings = appSettings;
  }

  set setNetworkState(NetworkConnectivity state) {
    networkConnectivity = state;
  }

  String get oneSignlaAppId {
    return oneSignalAppId;
  }

  bool get isOnline {
    return networkConnectivity == NetworkConnectivity.ONLINE;
  }

  bool get isUserLoggedInFirstTime {
    return loggingFirstTime;
  }
}
