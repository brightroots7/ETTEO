import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ServiceEvent {}

class FetchServicesDropdownValues extends ServiceEvent {
  final String lineOfBusinessGuid;
  FetchServicesDropdownValues({@required this.lineOfBusinessGuid});
}

class AddNewService extends ServiceEvent {
  final String orderId;
  final ServicesModel service;
  AddNewService({this.orderId, @required this.service});
}
