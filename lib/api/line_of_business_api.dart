import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/app_settings.dart';
import 'package:etteo_demo/model/order_detail/line_of_business_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';


class LineOfBusinessApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get All Line of Business
  Future<List<LineOfBusinessModel>> getAllLineOfBusiness() async {
    String url =
        appendSlashIfNotExists(url: apiBaseUrl, relativePath: 'api/lobs/v1');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<LineOfBusinessModel> lineofBusiness = List();
      var result = response.data["result"];
       print("lines of business api getAllLineOfBusiness result:$result");
      result
          .forEach((f) => lineofBusiness.add(LineOfBusinessModel.fromJson(f)));

      return lineofBusiness;
    } catch (e) {
      throw e;
    }
  }

  /// Get All ServiceComponents for Line of Business
  Future<List<ServiceComponentModel>> getAllServiceComponent(
      String lineofBusinessGuid) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl,
        relativePath:
            'api/lobs/v1/' + lineofBusinessGuid + '/service-components');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<ServiceComponentModel> resultServiceComponents = List();
      var result = response.data["result"];
       print("lines of business api getAllServiceComponent result:$result");
      result.forEach((f) =>
          resultServiceComponents.add(ServiceComponentModel.fromJson(f)));

      return resultServiceComponents;
    } catch (e) {
      throw e;
    }
  }

  /// Get All ServiceComponents for Line of Business
  Future<List<ServiceTypeModel>> getAllServiceType(
      String lineofBusinessGuid) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl,
        relativePath: 'api/lobs/v1/' + lineofBusinessGuid + '/service-types');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<ServiceTypeModel> resultServicetypes = List();
      var result = response.data["result"];
       print("lines of business api getAllServiceType result:$result");
      result
          .forEach((f) => resultServicetypes.add(ServiceTypeModel.fromJson(f)));

      return resultServicetypes;
    } catch (e) {
      throw e;
    }
  }
}
