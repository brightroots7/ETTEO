import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/providers/providers.dart';

class UserProfileApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get All ServiceComponents for Line of Business
  Future<UserProfileModel> getUserProfile() async {
    String url = appendSlashIfNotExists(url: apiBaseUrl, relativePath: 'api/users/v1/profile/');   
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ' + AuthenticationToken().getAccessToken()
              
          }
        )
      ));
      

      var result = response.data["result"];
      print("USERRRR_PROFILE_RESULT$result");
      return UserProfileModel.fromJson(result);
      
    } catch (e) {
      throw e;
    }
  }
}
