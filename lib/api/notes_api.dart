import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';
import 'package:meta/meta.dart';

class NotesApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get the App Settings
  Future<dynamic> createNoteForOrder(
      {@required String orderId, NotesModel note}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/' + orderId + '/note');
    Response response;

    // String body = note.toRequest();
    // print(body);

    try {
      response = await getDio().then((dio) => dio.post(url,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer ' + AuthenticationToken().getAccessToken(),
              }, contentType: ContentType.json),
              data: {
                "noteData": note.noteData,
              }));

      // List<NotesModel> resultRoutes = List();
      var result = response.data['result'];
      print(" NotesApi createNoteForOrder result:$result");
      // result.forEach((f) => resultRoutes.add(NotesModel.fromJson(f)));
      print(response);
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
