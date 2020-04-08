
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OrderDetailsState {}

class InitialOrderDetailsState extends OrderDetailsState {}

class OrderDetailFetching extends OrderDetailsState {}

class OrderDetailFetched extends OrderDetailsState {
  final OrderDetailModel orderDetails;
  final List<FlagsModel> getAllFlagsDetails;
  OrderDetailFetched({@required this.orderDetails , this.getAllFlagsDetails});
}

class RouteFlag extends OrderDetailsState {
  final dynamic flag;
  RouteFlag({@required this.flag});
}

class LocalOrderDetailFetching extends OrderDetailsState {}

class LocalOrderDetailFetched extends OrderDetailsState {
  final OrderDetailModel orderDetails;
  LocalOrderDetailFetched({@required this.orderDetails});
}
