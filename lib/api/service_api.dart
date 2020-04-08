import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/services/service_status_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';



class ServiceApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get the App Settings
  Future<List<ServiceStatusModel>> getServiceStatusAndItsSubStatus() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/service-status');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<ServiceStatusModel> resultRoutes = List();
      var result = response.data["result"];
      print("Response service api:$result");
      result.forEach((f) => resultRoutes.add(ServiceStatusModel.fromJson(f)));
     

      return resultRoutes;
    } catch (e) {
      throw e;
    }
  }
}
