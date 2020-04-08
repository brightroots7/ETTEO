import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/api/orders_api.dart';
import 'package:etteo_demo/bloc/bloc.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/model/models.dart';
// import 'package:etteo_demo/offline/sync/sync_queue.dart';
// import 'package:etteo_demo/models/allowed_tracking_value.dart';
// import 'package:etteo_demo/offline/database/dbmodel/sync_queue_db_model.dart';
import 'package:etteo_demo/offline/file_storage.dart';
import 'package:etteo_demo/offline/database/dbmodel/sync_queue_db_model.dart';
import 'package:etteo_demo/offline/master_data_sync.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';
// import 'package:etteo_demo/offline/master_data_sync.dart';
// import 'package:etteo_demo/offline/sync/sync_queue.dart';
// import './bloc.dart';
class OfflineBloc extends Bloc<OfflineEvent, OfflineState> {
  OfflineApi _offlineApi = OfflineApi();
   OrdersApi _ordersApi = OrdersApi();

  int queueCount = 0;
  List<SyncQueueDBModel> queueData;

  @override
  OfflineState get initialState => InitialOfflineState();

  @override
  Stream<OfflineState> mapEventToState(
    OfflineEvent event,
  ) async* {
    if (event is CheckMasterTableUpdate) {
      if (!AppConfig().isOnline) {
        //get offline master table
        yield SyncAllMasterDataCompleted();
      }

      List<AllowedTrackingValueModel> trackingValues = await _ordersApi.getAllowedTrackingValue();
      print("Offline bloc trackingValues trackingValues:$trackingValues");
         

      if (trackingValues == null) {
        /// This scenario will happen only if access is revoked for the technician.
        /// Unauthorized and no renew token existsredirect to login page
        await _offlineApi.wipeAllOfflineTables();
        yield DeleteAllOfflineDataCompleted();
      }

      String syncFile =  await FileStorage().readFile(filename: MASTER_DATA_SYNC_FILENAME);
      print("Offline bloc class while app offline or online syncFile :$syncFile");
          
      if (syncFile == null || syncFile == '') {
        
        await _offlineApi.resyncAllOfflineTables(); //fetch data from online save into offline database
      } else {
        // From local
        List<AllowedTrackingValueModel> localTrackingValues = readTrackingValues(syncFile);
        print("FALSEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE syncFile:$syncFile");
         print("FALSEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE localTrackingValues length:${localTrackingValues.length}");

        // /**
        //  * Used to update exist master data
        //  */
        await masterDataSyncUpdate(trackingValues, localTrackingValues, _offlineApi);
            

        // /**
        //  * Used only update new master data with alredy existing in device.
        //  * 
        //  */
        await checkNewMasterDataAndSyncIt(localTrackingValues, trackingValues, _offlineApi);
            
      }
      writeTrackingValues(trackingValues);
      yield SyncAllMasterDataCompleted();
    }



    if (event is SyncAllMasterTable) { //resync offline data from settings page 
      yield OfflineOperationInProgress();
      await _offlineApi.resyncAllOfflineTables(); 
      yield SyncAllMasterDataCompleted();
    }

    if (event is GetOfflineQueueData) {
     
      List<SyncQueueDBModel> queue = await _offlineApi.getQueue();
      queueData = queue;
      print("Sync Queue from offline bloc:$queue");
     
      queueCount = queue.length;

      yield OfflineQueueDataFetched(count: queue.length);
    }

    if (event is DeleteAllOfflineData) {
      yield OfflineOperationInProgress();

      _offlineApi.wipeAllOfflineTables();
      AppConfig().resetUserProfile();
      Future.delayed(Duration(seconds: 2));
      yield DeleteAllOfflineDataCompleted();
    }

    if (event is DeleteOfflineMasterData) {
      yield OfflineOperationInProgress();
      Future.delayed(Duration(seconds: 2));
      _offlineApi.wipeAllMasterData();
      yield DeleteOfflineMasterDataCompleted();
    }

    if (event is SyncOfflineQueue) {
      if (AppConfig().isOnline) {
        SyncQueue().checkSyncQueueWithState();
      }
      dispatch(GetOfflineQueueData());
      yield OfflineQueueSynched();
    }
  }
}
