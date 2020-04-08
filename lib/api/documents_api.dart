import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/helpers/app_settings.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';

import 'package:meta/meta.dart';

class DocumentsApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get Documents
  Future<List<DocumentsModel>> getAllDocumentsByOrderId(
      {@required String orderId}) async {
        print("orderIDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD:$orderId");
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/$orderId/document');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(
            url,
            options: Options(headers: {
              HttpHeaders.authorizationHeader:
                  'Bearer ' + AuthenticationToken().getAccessToken(),
            }, contentType: ContentType.json),
          ));

      List<DocumentsModel> resultDocuments = List();
      var result = response.data['result'];
      print("Documents Api getAllDocumentsByOrderId result :$result");
      result.forEach((f) => resultDocuments.add(DocumentsModel.fromJson(f)));
      print(response);
      return resultDocuments;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /// Get All DocumentTypes
  Future<List<DocumentsTypeModel>> getAllDocumentType() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/documentType');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<DocumentsTypeModel> resultServicetypes = List();
      var result = response.data["result"];
       print("Documents Api getAllDocumentType result :$result");
      result.forEach(
          (f) => resultServicetypes.add(DocumentsTypeModel.fromJson(f)));

      return resultServicetypes;
    } catch (e) {
      throw e;
    }
  }
}
