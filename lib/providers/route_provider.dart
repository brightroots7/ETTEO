
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/api/route_api.dart';
import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:etteo_demo/model/route/route_status_model.dart';
import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/route_db_model.dart';
import 'package:meta/meta.dart';

class RouteProvider {
  final RouteApi routeApi = new RouteApi();
  final OfflineApi offlineApi = new OfflineApi();

  Future<List<RouteModel>> getAllRoutes({@required String serviceDate}) async {
    return await routeApi.getAllRoutes(serviceDate: serviceDate);
  }

  Future<List<RouteStatusModel>> getAllRouteStatus() async {
    return await routeApi.getAllRouteStatus();
  }

  Future<List<RouteStatusModel>> getRouteStatusOffline() async {
    return await offlineApi.getAllRouteStatus();
  }

  Future<RouteModel> getRouteById({@required String routeId}) async {
    return await routeApi.getRouteById(routeId: routeId);
  }

  Future<int> updateRouteStatus(
      {@required String routeId, @required RouteStatusModel routeModel}) {
    return offlineApi.updateRouteStatus(routeId, routeModel);
  }

  saveRouteToOfflineStorage(List<RouteModel> routes) async {
    if (routes.isEmpty) {
      return;
    }

    List<RouteDBModel> routesToSave = List();
    // DatabaseHelper().s
    routes.forEach((o) => routesToSave.add(RouteDBModel(
        routeId: o.routeId,
        orderId: o.order.orderId,
        createdDate: DateTime.now().toUtc().toString(),
        serviceDate: getDateAloneFromString(o.order.service.scheduleDate),
        routeJson: o,
        syncFlag: 0)));
    DatabaseHelper().saveBatch(routesToSave);
  }

  saveRouteOffline(RouteModel routeModel) {
    RouteDBModel routeDBModel = RouteDBModel(
        routeId: routeModel.routeId,
        orderId: routeModel.order.orderId,
        createdDate: DateTime.now().toUtc().toString(),
        serviceDate:
            getDateAloneFromString(routeModel.order.service.scheduleDate),
        routeJson: routeModel,
        syncFlag: 0);
    DatabaseHelper().save(routeDBModel);
  }

  Future<List<RouteModel>> getRoutesForServiceDate(String serviceDate) async {
    List<RouteDBModel> fetchedRoutes = await DatabaseHelper()
        .getAllById<RouteDBModel>(RouteDBModel(), serviceDate, 'serviceDate');

    List<RouteModel> resultRoutes = List();
    fetchedRoutes.forEach((f) => resultRoutes.add(f.routeJson));
    return resultRoutes;
  }

  Future<int> deleteRoutesForServiceDate(String serviceDate) async {
    int deletedRoutes = await DatabaseHelper()
        .delete(RouteDBModel(), serviceDate, 'serviceDate');

    // List<RouteModel> resultRoutes = List();
    // fetchedRoutes.forEach((f) => resultRoutes.add(f.routeJson));
    return deletedRoutes;
  }

  Future<bool> removeRoute(String routeId) async {
    int deleted =
        await DatabaseHelper().delete(RouteDBModel(), routeId, 'routeId');
    return deleted > 0 ? true : false;
  }

  Future<int> updateRouteOffline(RouteModel routeModel) async {
    RouteDBModel routeDBModel = RouteDBModel(
        routeId: routeModel.routeId,
        updatedDate: DateTime.now().toUtc().toString(),
        routeJson: routeModel);
    return DatabaseHelper().update(routeDBModel, routeModel.routeId, 'routeId');
  }
}
