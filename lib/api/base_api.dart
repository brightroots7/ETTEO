

import 'package:dio/dio.dart';
import 'package:etteo_demo/providers/providers.dart';

abstract class BaseApi {
  // final Dio dio = getDio();

  String appendSlashIfNotExists({String url, String relativePath}) {
    return url.endsWith('/') ? url + relativePath : url + '/' + relativePath;
  }

  /// Get dio instance without renew token for authentication and renewtoken invocation
  dio() {
    Dio dio = Dio();

    dio.options.connectTimeout = 60000; //5s
    dio.options.receiveTimeout = 60000;
    return dio;
  }

  /// Check if the token is expired on api call and renew token if expired before next service call.
  Future<bool> validateTokenForApi() async {
    if (AuthenticationToken().isExpired()) {
      AuthenticationProvider _authenticationPrvoder = AuthenticationProvider();
      Map map = await _authenticationPrvoder.renewToken(
          authToken: AuthenticationToken());
      AuthenticationToken().loadMap(map);

      return true;
    }
    return true;
  }

  /// Get dio instance with valid token for all the api call.
  Future<Dio> getDio() async {
    Dio dio;

    if (await validateTokenForApi()) {
      dio = Dio();

      dio.options.connectTimeout = 60000;
      dio.options.receiveTimeout = 60000;
      dio.options.validateStatus = (int status) {
        return status > 0;
      };
      return dio;
    }
  }

  bool checkUnAuthorized(response) {
    if (response.data == '' && response.statusCode == 401) {
      return true;
    }
    return false;
  }
}
