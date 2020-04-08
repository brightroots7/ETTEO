import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/parts_event.dart';
import 'package:etteo_demo/bloc/parts_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';


class PartsBloc extends Bloc<PartsEvent, PartsState> {
  OfflineApi _offlineApi = OfflineApi();
  @override
  PartsState get initialState => InitialPartsState();

  List<PartsTypeModel> partsType = List();
  List<PartsStatusModel> partsStatus = List();

  PartsTypeModel selectedPartTypeModel;
  PartsStatusModel selectedPartStatusModel;

  OrderDetailModel orderDetailModel;

  @override
  Stream<PartsState> mapEventToState(
    PartsEvent event,
  ) async* {
    if (event is AddNewParts) {
      yield NewPartsAdding();
      print(event.part);

      int id = await _offlineApi.createPart(event.orderId, event.part);
      if (id != 0) {
        if (AppConfig().isOnline) {
          // This will create a post call from queu but does not stop the rending UI.
          Future(() => {SyncQueue().checkSyncQueue()});
        }
        orderDetailModel.addPartsList(event.part);
      }

      yield NewPartsAdded(part: event.part);
    }

    if (event is PartsFetchDropdownValues) {
      yield PartsDropdownValuesFetching();

      selectedPartStatusModel = null;
      selectedPartTypeModel = null;

      partsType = await _offlineApi.getAllPartsType();
      partsStatus = await _offlineApi.getAllPartsStatus();

      yield PartsDropdownValuesFetched();
    }
  }
}
