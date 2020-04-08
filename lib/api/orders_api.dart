import 'dart:io';

import 'package:dio/dio.dart';
import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/allowed_tracking_value.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/all_orders_model.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/order_model.dart';
import 'package:etteo_demo/model/order_detail/payment_mode_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:etteo_demo/providers/authentication_token.dart';

import 'package:meta/meta.dart';

class OrdersApi extends BaseApi {
  final String apiBaseUrl = AppConfig().appSettings.get(AppSetting.rootApiUrl);

  /// Get the App Settings
  Future<List<AllOrdersModel>> getAllOrders(
      {String customerId,
      @required String searchText,
      String filterText}) async {
    String url =
        appendSlashIfNotExists(url: apiBaseUrl, relativePath: 'api/orders/v1');
    Response response;

    Map<String, dynamic> params = Map();
    params.addAll({
      'CustomerId': customerId,
      'SearchText': searchText,
      'FilterText': filterText
    });

    try {
      response = await getDio().then((dio) => dio.get(url,
          queryParameters: params,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<AllOrdersModel> resultOrders = List();
      List orders = response.data["result"];
      print("OrdersApi getAllOrders:$orders");
      orders.forEach((f) => resultOrders.add(AllOrdersModel.fromJson(f)));

      return resultOrders;
    } catch (e) {
      throw e;
    }
  }

  /// Get the App Settings
  Future<OrderDetailModel> getOrderById({@required String orderId}) async {
    String url = appendSlashIfNotExists(
    url: apiBaseUrl, relativePath: 'api/orders/v1/' + orderId);


    
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      // List<RouteModel> resultOrders = List();
      var order = response.data["result"];
      print("orders api getOrderById:$order");
      OrderDetailModel orderDetailModel = OrderDetailModel.fromJson(order);
      // print(o);
      // orders.forEach((f) => resultOrders.add(RouteModel.fromJson(f)));

      return orderDetailModel;
    } catch (e) {
      throw e;
    }
  }

  /// Get the App Settings
  Future<List<AllowedTrackingValueModel>> getAllowedTrackingValue() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/allowed-tracking-value');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<AllowedTrackingValueModel> resultTrackingValues = List();
      // print('order Api result tracking values:$resultTrackingValues');
      print(resultTrackingValues);

      /// This scenario will only occur, when access is revoked and try to login with token
      /// that is not expired.
      if (checkUnAuthorized(response)) {
        return null;
      }

      print('response tracking values getAllowedTrackingValue():');
      print(response);

      List orders = response.data["result"];
      print("OrderApi getAllowedTrackingValue() LENGTH:${orders.length}");
      orders.forEach((f) => resultTrackingValues.add(AllowedTrackingValueModel.fromJson(f)));
       
      return resultTrackingValues;
    } catch (e) {
      print('AFTER ACCESS REVOKED');
      print(e);
      throw e;
    }
  }




  Future<dynamic> addServiceToOrder(
      {@required String orderId, @required ServicesModel service}) async {
    /// Get the App Settings

    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/' + orderId + '/service');
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
                "serviceTypeId": service.serviceTypeId,
                "serviceComponentId": service.serviceComponentId,
                "serviceDescription": service.serviceDescription,
                "serviceSku": ""
              }));

      // List<NotesModel> resultRoutes = List();
      var result = response.data['result'];
      // result.forEach((f) => resultRoutes.add(NotesModel.fromJson(f)));
      print(response);
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }








  Future<dynamic> addPartsToOrder(
      {@required String orderId, @required PartsModel part}) async {
    /// Get the App Settings

    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/' + orderId + '/unit');
    Response response;

    try {
      response = await getDio().then((dio) => dio.post(url,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer ' + AuthenticationToken().getAccessToken(),
              }, contentType: ContentType.json),
              data: {
                "make": part.make,
                "model": part.model,
                "serialNumber": part.serialNumber,
                "unitDescription": part.unitDescription,
                "unitTypeId": part.unitTypeId,
                "unitStatusId": part.unitStatusId,
                "estimatedTimeOfArrival": part.estimatedTimeOfArrival,
                "location": part.unitLocation
              }));

      // List<NotesModel> resultRoutes = List();
      var result = response.data['result'];
      // result.forEach((f) => resultRoutes.add(NotesModel.fromJson(f)));
      print(response);
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }







  /// Add Documents
  Future<dynamic> addDocumentToOrder(
      {@required String orderId, DocumentsModel document}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl,
        relativePath:
            'api/orders/v1/$orderId/document/${document.documentTypeId}');

    Response response;

    try {
      response = await getDio().then((dio) => dio.post(
            url,
            options: Options(headers: {
              HttpHeaders.authorizationHeader:
                  'Bearer ' + AuthenticationToken().getAccessToken(),
            }, contentType: ContentType.json),
            data: FormData.from({
              "file": UploadFileInfo(
                File(document.fileLocation),
                document.fileName,
              ),
              "documentDescription": document.documentDescription
            }),
            onSendProgress: (received, total) {
              if (total != -1) {
                print((received / total * 100).toStringAsFixed(0) + "%");
              }
            },
          ));

      var result = response.data['result'];
      print(response);
      return result;
    } catch (e) {
      print(e);
      throw e;
    }
  }




  /// Get the App Settings
  Future<bool> updateService(
      {@required String orderId, @required ServicesModel service}) async {
      
    String url = appendSlashIfNotExists(
        url: apiBaseUrl,
        relativePath:
            'api/orders/v1/$orderId/service/${service.serviceId}/resolve');
    Response response;

    try {
      response = await getDio().then((dio) => dio.put(url,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer ' + AuthenticationToken().getAccessToken(),
              }, contentType: ContentType.json),
              data: {
                "serviceStatusId": service.serviceStatusId,
                "serviceStatus": service.serviceStatus,
                "serviceSubStatusId": service.serviceSubStatusId,
                "serviceSubStatus": service.serviceSubStatus,
                "serviceCompletedDate": service.serviceCompletedDate,
              }));

      // List<ServiceStatusModel> resultRoutes = List();
      // var result = response.data["result"];
      // result.forEach((f) => resultRoutes.add(ServiceStatusModel.fromJson(f)));

      var flag = response.data["result"];
      print("OrderApi updateService flag:$flag ");
      return flag != null ? flag : false;
    } catch (e) {
      throw e;
    }
  }



  /// Get the App Settings
  Future<dynamic> updateFinaceInOrder(
      {@required String orderId, @required OrderFinanceModel finance}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/$orderId/finance');
    Response response;

    try {
      response = await getDio().then((dio) => dio.put(url,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    'Bearer ' + AuthenticationToken().getAccessToken(),
              }, contentType: ContentType.json),
              data: {
                "isServiceFeeCollected": finance.isServiceFeeCollected,
                "amountCollected": finance.amountCollected,
                "paymentModeId": finance.paymentModeId,
              }));

      var flag = response.data["result"];
      return flag != null ? flag : false;
    } catch (e) {
      throw e;
    }
  }






  Future<List<PaymentModeModel>> getPaymentModes() async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/finance/payment-mode');
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<PaymentModeModel> resultPaymentModes = List();
      List orders = response.data["result"];
      orders
          .forEach((f) => resultPaymentModes.add(PaymentModeModel.fromJson(f)));

      return resultPaymentModes;
    } catch (e) {
      throw e;
    }
  }



  Future<List<FlagsModel>> getAllFlags({@required String orderId}) async {
    String url = appendSlashIfNotExists(
        url: apiBaseUrl, relativePath: 'api/orders/v1/$orderId/flag');
        print(" orderId orderId orderId orderId orderId++++++@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@______________________________________:$orderId");
    Response response;

    try {
      response = await getDio().then((dio) => dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<FlagsModel> resultFlags = List();
      List flags = response.data["result"];

      print("OrderApi getAllFlags  flags result:$flags");
      flags
          .forEach((f) => resultFlags.add(FlagsModel.fromJson(f)));

      return resultFlags;
    } catch (e) {
      throw e;
    }
  }







Future<List<AllOrdersModel>> getAllOrdersDetails(
      // {String customerId,
      // @required String searchText,
      // String filterText}
    ) async {
    String url =
        appendSlashIfNotExists(url: apiBaseUrl, relativePath: 'api/orders/v1');
    Response response;

    Map<String, dynamic> params = Map();
    // params.addAll({
    //   'CustomerId': customerId,
    //   'SearchText': searchText,
    //   'FilterText': filterText
    // });

    try {
      response = await getDio().then((dio) => dio.get(url,
          // queryParameters: params,
          options: Options(headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ' + AuthenticationToken().getAccessToken()
          })));

      List<AllOrdersModel> resultOrders = List();
      List orders = response.data["result"];
      print("OrdersApi filtred order AllOrdersModel:$orders");
      orders.forEach((f) => resultOrders.add(AllOrdersModel.fromJson(f)));

      return resultOrders;
    } catch (e) {
      throw e;
    }
  }







}
