import 'package:etteo_demo/model/order_detail/all_orders_model.dart';
import 'package:etteo_demo/model/route/route_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OrdersState {}

class InitialOrderState extends OrdersState {}

class OrdersFetched extends OrdersState {
  final List<RouteModel> orders;
  OrdersFetched({@required this.orders});
}

class OrderFetching extends OrdersState {}

class OrdersSearching extends OrdersState {}

class OrdersSearched extends OrdersState {
  final List<AllOrdersModel> orders;
  OrdersSearched({@required this.orders});
}
