

import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/providers/documents_provider.dart';
import 'package:etteo_demo/providers/orders_provider.dart';
import 'package:etteo_demo/providers/route_provider.dart';

class RouteSyncUtil {
  static RouteSyncUtil shared = RouteSyncUtil();

  RouteProvider routeProvider = RouteProvider();
  OrdersProvider _ordersProvider = OrdersProvider();
  DocumentsProvider _documentsProvider = DocumentsProvider();

  void updateRouteForDate({List<RouteModel> routes, String date}) async {
    // API call

    List<RouteModel> routeList = routes == null
        ? await routeProvider.getAllRoutes(serviceDate: date)
        : routes;

    if (checkToday(date)) {
      List<RouteModel> offlineRoutes = await routeProvider
          .getRoutesForServiceDate(getDateAloneFromString(date));

      if (offlineRoutes.isEmpty) {
        await routeProvider.saveRouteToOfflineStorage(routeList);
      } else {
        bool deleted;
        routeList.forEach((route) async => {
              if (offlineRoutes.contains(route))
                {
                  // update
                  await routeProvider.updateRouteOffline(route)
                }
              else if (!offlineRoutes.contains(route))
                {await routeProvider.saveRouteOffline(route)}
            });

        offlineRoutes.forEach((route) async => {
              if (!routeList.contains(route))
                {
                  // delete route
                  deleted = await removeRoute(route.routeId),
                  print('Deleted $deleted')
                }
            });
      }
    } else {
      await routeProvider
          .deleteRoutesForServiceDate(getDateAloneFromString(date));
      await routeProvider.saveRouteToOfflineStorage(routeList);
    }

    String orderId;

    await Future.forEach(
        routeList,
        (route) async => {
              orderId = route.order.orderId,
              await updateOrderDetail(orderId)
              // _ordersProvider.getOrderById(orderId: orderId).then((value) =>
              //     _ordersProvider.saveOrderDetailToOfflineStorage(value)),
            });
    print('routePublished completed');
  }




  // void updateRoute(String routeId) async {
  //   try {
  //     RouteModel routeModel =
  //         await routeProvider.getRouteById(routeId: routeId);

  //     if (routeModel == null) {
  //       return;
  //     }
  //     routeProvider.saveRouteOffline(routeModel);
  //     await updateOrderDetail(routeModel.order.orderId);
  //     print('Etteo Notification - updateRoute completed');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  String orderId;
  List<DocumentsModel> documents;
  Future<void> updateOrderDetail(String orderId) async {
    await _ordersProvider.getOrderById(orderId: orderId).then((value) async => {
          documents = await _documentsProvider.getAllDocumentsByOrderId(
              orderId: orderId),
          value.order.documents.clear(),
          value.addDocumentList(documents),
          _ordersProvider.saveOrderDetailToOfflineStorage(value),
        });
  }

  Future<bool> removeRoute(String routeId) async {
    bool deleted = await routeProvider.removeRoute(routeId);
    print("Deleted Route $deleted");
    return deleted;
  }
}
