import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/service_event.dart';
import 'package:etteo_demo/bloc/service_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  // ServiceProvider _serviceProvider = ServiceProvider();
  // OrdersApi _ordersApi = OrdersApi();
  OfflineApi _offlineApi = OfflineApi();

  var requiredFLag = false;
  var componentDropdownValue;
  var serviceDropdownValue;
  var reasonDropdownValue;

  List<ServiceComponentModel> serviceComponents = List();
  List<ServiceTypeModel> serviceTypes = List();

  ServiceComponentModel selectedServiceComponentGuid;
  ServiceTypeModel selectedServiceTypeGuid;

  OrderDetailModel orderDetailModel;

  @override
  ServiceState get initialState => InitialServiceState();

  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is AddNewService) {
      yield NewServiceAdding();
      print(event.service);

      int serviceId = await _offlineApi.createService(
          orderId: event.orderId, service: event.service);

      if (serviceId != 0) {
        if (AppConfig().isOnline) {
          // This will create a post call from queu but does not stop the rending UI.
          Future(() => {SyncQueue().checkSyncQueue()});
        }
        orderDetailModel.addServiceList(event.service);

        yield NewServiceAdded(service: event.service);
      }
    }

    if (event is FetchServicesDropdownValues) {
      yield ServiceDropdownValuesFetching();

      selectedServiceComponentGuid = null;
      selectedServiceTypeGuid = null;
      serviceComponents =
          await _offlineApi.getAllServiceComponent(event.lineOfBusinessGuid);

      serviceTypes =
          await _offlineApi.getAllServiceType(event.lineOfBusinessGuid);

      yield ServiceDropdownValuesFetched();
    }
  }
}
