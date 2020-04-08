import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/general_information_event.dart';
import 'package:etteo_demo/bloc/general_information_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/order_detail/payment_mode_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';

class GeneralInformationBloc
    extends Bloc<GeneralInformationEvent, GeneralInformationState> {
  @override
  GeneralInformationState get initialState => InitialGeneralInformationState();

  OfflineApi _offlineApi = OfflineApi();

  OrderDetailModel orderDetailModel;
  List<PaymentModeModel> paymentModes;
  PaymentModeModel selectedPaymentMode;

  @override
  Stream<GeneralInformationState> mapEventToState(
    GeneralInformationEvent event,
  ) async* {
    if (event is FetchDropDownValues) {
      paymentModes = await _offlineApi.getAllPaymentModes();

      yield DropdownValuesFetched();
    }

    if (event is AddServiceFee) {
      int id =
          await _offlineApi.updateFinanceInOrder(event.orderId, event.finance);
      if (id != 0) {
        if (AppConfig().isOnline) {
          orderDetailModel.addFinance(event.finance);
          // This will create a post call from queu but does not stop the rending UI.
          Future(() => {SyncQueue().checkSyncQueue()});
        }
      }
    }
  }

  void setPaymentMode(String paymentModeId) {
    if (paymentModeId == null) {
      return;
    }
    selectedPaymentMode =
        paymentModes?.firstWhere((pm) => pm.paymentModeId == paymentModeId);
  }
}
