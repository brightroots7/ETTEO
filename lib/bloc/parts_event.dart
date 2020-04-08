import 'package:etteo_demo/model/parts/parts_model.dart';

import 'package:meta/meta.dart';

@immutable
abstract class PartsEvent {}

class PartsFetchDropdownValues extends PartsEvent {}

class AddNewParts extends PartsEvent {
  final String orderId;
  final PartsModel part;
  AddNewParts({this.orderId, @required this.part});
}
