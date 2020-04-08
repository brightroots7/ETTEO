import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ServiceState {}

class InitialServiceState extends ServiceState {}

class NewServiceAdding extends ServiceState {}

class NewServiceAdded extends ServiceState {
  final ServicesModel service;
  NewServiceAdded({@required this.service});
}

class AddNewServiceFailed extends ServiceState {
  final String error;
  AddNewServiceFailed({this.error});
}

class ServiceDropdownValuesFetching extends ServiceState {}

class ServiceDropdownValuesFetched extends ServiceState {}
