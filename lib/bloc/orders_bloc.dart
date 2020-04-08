import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/bloc/orders_event.dart';
import 'package:etteo_demo/bloc/orders_state.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/order_detail/all_orders_model.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:etteo_demo/providers/orders_provider.dart';




class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersProvider orderProvider = new OrdersProvider();
  List<AllOrdersModel> searchedOrder = List();
  List<AllOrdersModel> orders= List();
  
   var searchFieldFlag = true;
  @override
  OrdersState get initialState => InitialOrderState();

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if(AppConfig().isOnline){
      searchFieldFlag =true;
    }else{
      searchFieldFlag =false;
    }

    if (event is OrdersSearch) {
      yield OrdersSearching();
       orders = await orderProvider.getAllOrders(searchText: event.searchText);
        

      for(int i=0; i<orders.length;i++){
        print("OrderNO No No NO nOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO:${orders.length} ${orders[i].customerName}");
      }
         

      // Persist in local database
      //  this will be removed and add it to router fetch call.
      // orderProvider.saveRouteToOfflineStorage(orders);
    //   var searchedText = event.searchText;
    //   searchedOrder.clear();
    //   if (searchedText.isEmpty) {
      
    //    return;
    //   }
    //  orders.forEach((data) {
    //   if (data.marketName.toLowerCase().startsWith(searchedText.toLowerCase()))
    //     searchedOrder.add(data);
       

    //   });



      yield OrdersSearched(orders: orders);
      
    }
  }
}

