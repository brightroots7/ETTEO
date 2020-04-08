import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/app_settings.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';


class PartsApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  // / Get All ServiceComponents for Line of Business
  Future<List<PartsStatusModel>> getAllPartsStatus() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/parts/v1/status');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<PartsStatusModel> resultServiceComponents = List();
      var result = response.data["result"];
      print("Parts Api getAllPartsStatus result:$result");
      result.forEach(
          (f) => resultServiceComponents.add(PartsStatusModel.fromJson(f)));

      return resultServiceComponents;
    } catch (e) {
      throw e;
    }
  }

  /// Get All ServiceComponents for Line of Business
  Future<List<PartsTypeModel>> getAllPartsType() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/parts/v1/types');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<PartsTypeModel> resultServicetypes = List();
      var result = response.data["result"];
      print("Parts Api getAllPartsType result:$result");
      result.forEach((f) => resultServicetypes.add(PartsTypeModel.fromJson(f)));

      return resultServicetypes;
    } catch (e) {
      throw e;
    }
  }
}
