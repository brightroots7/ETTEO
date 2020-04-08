import 'package:meta/meta.dart';

@immutable
abstract class OrdersEvent {}

class FetchOrders extends OrdersEvent {}

class OrdersSearch extends OrdersEvent {
  final String searchText;
  OrdersSearch({@required this.searchText});
}
