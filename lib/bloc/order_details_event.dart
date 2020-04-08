
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OrderDetailsEvent {}

class FetchOrderDetail extends OrderDetailsEvent {
  final String orderId;
  FetchOrderDetail({@required this.orderId});
}

class FetchLocalOrderDetail extends OrderDetailsEvent {
  final String orderId;
  FetchLocalOrderDetail({@required this.orderId});
}

class SetRouteFlag extends OrderDetailsEvent {
  final bool flag;
  SetRouteFlag({@required this.flag});
}

class UpdateOrderDetail extends OrderDetailsEvent {
  final OrderDetailModel orderDetailModel;
  UpdateOrderDetail(this.orderDetailModel);
}

class GetRouteFlag extends OrderDetailsEvent {}
