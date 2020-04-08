
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GeneralInformationEvent {}

class FetchDropDownValues extends GeneralInformationEvent {}

class AddServiceFee extends GeneralInformationEvent {
  final OrderFinanceModel finance;

  final String orderId;

  AddServiceFee({this.finance, this.orderId});
}
