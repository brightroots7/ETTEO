import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/providers/providers.dart';
import 'package:meta/meta.dart';

class RouteApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get the App Settings
  Future<List<RouteModel>> getAllRoutes({@required String serviceDate}) async {
    String url = appendSlashIfNotExists( url: apiBaseUrl, relativePath: 'api/routes/v1/resource/' + serviceDate); 
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<RouteModel> resultRoutes = List();
      var result = response.data["result"];
      print("route api response getAllRoutes result:$result");
      result.forEach((f) => resultRoutes.add(RouteModel.fromJson(f)));
       print("route api response getAllRoutes:$resultRoutes");
      return resultRoutes;
    } catch (e) {
      throw e;
    }
  }

  Future<RouteModel> getRouteById({String routeId}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/routes/v1/$routeId/resource');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      if (response.data == "") {
        return null;
      }
     
      var result = response.data["result"];
       print("RouteApi getRouteById() result:$result ");
      return RouteModel.fromJson(result);
    } catch (e) {
      throw e;
    }
  }

  Future<List<RouteStatusModel>> getAllRouteStatus() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/routes/v1/route-status');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<RouteStatusModel> routeStatuses = List();
      var result = response.data["result"];
       print("route api response getAllRouteStatus result:$result");
      result.forEach((f) => routeStatuses.add(RouteStatusModel.fromJson(f)));
      print("route api response getAllRouteStatus:${routeStatuses.length}");
      return routeStatuses;
    } catch (e) {
      throw e;
    }
  }

  /// Get the App Settings
  Future<bool> updateRouteStatus(
      {@required String routeId, @required RouteStatusModel rsm}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/routes/v1/$routeId/route-status');
    Response response;

    try {
      response = await getDio().then((dio) => dio.put(url,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer ' + AuthenticationToken().getAccessToken(),
              }, contentType: ContentType.json),
              data: {
                "routeStatusId": rsm.routeStatusId,
                "routeStatus": rsm.routeStatusDescription,
                "routeStatusUpdatedTime": rsm.routeStatusUpdatedTime
              }));

      var flag = response.data["result"];
      print("Route api updateRouteStatus flag:$flag");
      return flag != null ? flag : false;
    } catch (e) {
      throw e;
    }
  }
}
