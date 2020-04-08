import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/order_details_event.dart';
import 'package:etteo_demo/bloc/order_details_state.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/pages/widgets/generalInformation/flags.dart';
import 'package:etteo_demo/providers/orders_provider.dart';

import './bloc.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  bool routeFlag = true;
  OrderDetailModel orderDetails;
  List<FlagsModel> getAllFlagsDetails;

  OrderDetailsBloc();
  OfflineApi offlineApi = OfflineApi();

  @override
  dispose() {
    super.dispose();
  }



  OrdersProvider _ordersProvider = OrdersProvider();
  @override
  OrderDetailsState get initialState => InitialOrderDetailsState();

  @override
  Stream<OrderDetailsState> mapEventToState(
    OrderDetailsEvent event,
  ) async* {
    if (event is FetchLocalOrderDetail) {
      // Set order progressing
      yield LocalOrderDetailFetching();
      // Read from local db.
      if(AppConfig().isOnline)
      await offlineApi.syncFlags(event.orderId);

      orderDetails = await _ordersProvider.readOrderDetailFromOfflineStorage(orderId: event.orderId);
          

      getAllFlagsDetails = await _ordersProvider.getAllFlagsOffline(orderId: event.orderId);

      print("orderDetails bloc orderDetails________________&&&&&&&&&&&&&&&&&&&&&&&&:$orderDetails");
      
      for(int i =0; i<getAllFlagsDetails.length;i++){
        print("orderDetails bloc getAllFlagsDetails________________&&&&&&&&&&&&&&&&&&&&&&&&:${getAllFlagsDetails[i].flagTypeColor}");
      }

      if (orderDetails == null  || getAllFlagsDetails ==null) {
        dispatch(FetchOrderDetail(orderId: event.orderId));
        
        return;
      }

      yield OrderDetailFetched(orderDetails: orderDetails,getAllFlagsDetails:getAllFlagsDetails );
      // yield LocalOrderDetailFetched(orderDetails: orderDetails);
    }

    if (event is FetchOrderDetail) {
      print('FetchOrderDetail ${event.orderId}');

      yield OrderDetailFetching();

      orderDetails = await _ordersProvider.getOrderById(orderId: event.orderId);
      //shruti
      getAllFlagsDetails = await _ordersProvider.getAllFlags(orderId: event.orderId);
      print("getAllFlagsDetails______________________________________________----------@@@@@:$getAllFlagsDetails");
      _ordersProvider.saveOrderDetailToOfflineStorage(orderDetails);
      yield OrderDetailFetched(orderDetails: orderDetails ,getAllFlagsDetails:getAllFlagsDetails );
    }

    if (event is UpdateOrderDetail) {
      await _ordersProvider.updateOrderToOfflineStorage(
          event.orderDetailModel, event.orderDetailModel.orderId);
    }

    if (event is SetRouteFlag) {
      routeFlag = event.flag;
    }
  }
}
