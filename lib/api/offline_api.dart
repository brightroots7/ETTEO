import 'package:etteo_demo/api/base_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';

import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/payment_mode_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:etteo_demo/model/services/service_component_model.dart';
import 'package:etteo_demo/model/services/service_status_model.dart';
import 'package:etteo_demo/model/services/service_type_model.dart';
import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/database/dbmodel/notes_db_model.dart';
import 'package:etteo_demo/offline/database/dbmodel/order_detail_db_model.dart';
import 'package:etteo_demo/offline/database/dbmodel/route_db_model.dart';
import 'package:etteo_demo/offline/sync/document_type_sync.dart';
import 'package:etteo_demo/offline/sync/flag_sync.dart';
import 'package:etteo_demo/offline/sync/line_of_business_sync.dart';
import 'package:etteo_demo/offline/sync/payment_mode_sync.dart';
import 'package:etteo_demo/offline/sync/service_component_sync.dart';
import 'package:etteo_demo/offline/sync/service_status_sync.dart';
import 'package:etteo_demo/offline/sync/service_type_sync.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';
import 'package:etteo_demo/offline/sync/unit_status_model.dart';
import 'package:etteo_demo/offline/sync/unit_type_sync.dart';
import 'package:etteo_demo/offline/sync/user_profile_sync.dart';
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';
import 'package:etteo_demo/offline/file_storage.dart';
import 'package:etteo_demo/offline/database/dbmodel/sync_queue_db_model.dart';
import 'package:etteo_demo/offline/sync/app_settings_sync.dart';
import 'package:etteo_demo/offline/sync/route_status_sync.dart';
import 'package:meta/meta.dart';

class OfflineApi extends BaseApi {
  LineOfBusinessSync _lobSync = LineOfBusinessSync();
  ServiceComponentSync _serviceComponentSync = ServiceComponentSync();
  ServiceTypeSync _serviceTypeSync = ServiceTypeSync();
  PartsStatusSync _partsStatusSync = PartsStatusSync();
  PartsTypeSync _partsTypeSync = PartsTypeSync();
  UserProfileSync _userProfileSync = UserProfileSync();
  AppSettingsSync _appSettingsSync = AppSettingsSync();
  ServiceStatusSync _serviceStatusSync = ServiceStatusSync();
  DocumentsTypeSync _documentsTypeSync = DocumentsTypeSync();
  RouteStatusSync _routeStatusSync = RouteStatusSync();
  PaymentModesSync _paymentModeSync = PaymentModesSync();
  //shruti
  FlagSync _flagSync = FlagSync();



  wipeAllMasterData() async {
    await MasterDataDBModel().deleteAll();

    print(await _lobSync.getAll());

    // Delete all records in master table.
  }




syncAllMasterData() async {
    /// Saving line of business
    await syncServiceComponent();

    await syncServiceType(); //getAllServiceType_Api

    /// Saving ServiceComponent for each lineofBusiness

    /// Parts Type.
    await syncPartType();

    /// Parts Status
    await syncPartStatus();

    /// Payment Modes
    await syncPaymentModes();

    /// All flags
    // await syncFlags();

    /// User Profile
    List<UserProfileModel> userProfile = await _userProfileSync.getApiData();
    await _userProfileSync.saveAll(model: userProfile, table: MasterTable.ProfileInfo);
    
        
        

    List<AppSettingsModel> appSettingsModel =await _appSettingsSync.getApiData();
        
    await _userProfileSync.saveAll(model: appSettingsModel, table: MasterTable.AppSettings);
        

    await syncServiceStatus();

    await syncDocumentType();

    await syncRouteStatus();

    print(await _routeStatusSync.getAll());
    print(await _serviceStatusSync.getAll());
    print(await _documentsTypeSync.getAll());
    print(await _paymentModeSync.getAll());
    return true;

    /// Sync all Master data to the latest from Remote Api.
  }



  

  Future syncServiceComponent() async {
    /// Saving line of business
    List<LineOfBusinessModel> lobs = await _lobSync.getApiData();
    await _lobSync.saveAll(
        model: lobs, table: MasterTable.LineOfBusiness, parentKey: "");

    _serviceComponentSync.deleteAll(MasterTable.ServiceComponents);

    /// Saving ServiceComponent for each lineofBusiness
    Map<String, String> params;
    List<ServiceComponentModel> sc;
    lobs.forEach((f) async => {
          params = Map<String, String>(),
          params['lineOfBusinessId'] = f.lineOfBusinessId,
          sc = await _serviceComponentSync.getApiData(params: params)
              as List<ServiceComponentModel>,
          await _serviceComponentSync.saveAll(
              model: sc,
              table: MasterTable.ServiceComponents,
              parentKey: f.lineOfBusinessId)
        });
  }

  

  Future syncServiceType() async {
    /// Saving line of business
    List<LineOfBusinessModel> lobs = await _lobSync.getApiData();
    await _lobSync.saveAll(
        model: lobs, table: MasterTable.LineOfBusiness, parentKey: "");

    await _serviceTypeSync.deleteAll(MasterTable.ServiceTypes);

    /// Saving ServiceComponent for each lineofBusiness
    Map<String, String> params;
    List<ServiceTypeModel> st;
    lobs.forEach((f) async => {
          params = Map<String, String>(),
          params['lineOfBusinessId'] = f.lineOfBusinessId,
          st = await _serviceTypeSync.getApiData(params: params)
              as List<ServiceTypeModel>,
          await _serviceTypeSync.saveAll(
              model: st,
              table: MasterTable.ServiceTypes,
              parentKey: f.lineOfBusinessId)
        });
  }



  Future syncPartType() async {
    /// Parts Type.
    List<PartsTypeModel> partTypes = await _partsTypeSync.getApiData();
    await _partsTypeSync.deleteAll(MasterTable.PartType);
    await _partsTypeSync.saveAll(model: partTypes, table: MasterTable.PartType);
  }

  Future syncPartStatus() async {
    /// Parts Status
    List<PartsStatusModel> partStatus = await _partsStatusSync.getApiData();
    print("offline partStatus :${partStatus.length}");
    await _partsStatusSync.deleteAll(MasterTable.PartStatus);
    await _partsStatusSync.saveAll(model: partStatus, table: MasterTable.PartStatus);
       
  }

  Future syncPaymentModes() async {
    /// Payment Mode
    List<PaymentModeModel> paymentModes = await _paymentModeSync.getApiData();
    await _partsStatusSync.deleteAll(MasterTable.PaymentMode);
    await _partsStatusSync.saveAll(
        model: paymentModes, table: MasterTable.PaymentMode);
  }


  Future syncFlags(String orderId) async {
    /// save all Flags into master table 
    List<FlagsModel> flags = await _flagSync.getApiData(orderId: orderId);
    for(int i=0 ; i<flags.length; i ++){
      print("OFFLINEEEEEEEEEE___________APAAAPPPPIIIIII:${flags[i].flagTypeColor}");
    }
   
    await _flagSync.deleteAll(MasterTable.Flags);
    await _flagSync.saveAll(
        model: flags, table: MasterTable.Flags);
  }



  Future syncServiceStatus() async {
    List<ServiceStatusModel> serviceStatusModel =
        await _serviceStatusSync.getApiData();

    await _serviceStatusSync.deleteAll(MasterTable.ServiceStatus);

    // Filter only isDelegate flag is true
    List<ServiceStatusModel> isDelegateServiceStatusModel =
        serviceStatusModel.where((ss) => ss.isDelegate == true).toList();
    await _serviceStatusSync.saveAll(
        model: isDelegateServiceStatusModel, table: MasterTable.ServiceStatus);
  }

  Future syncRouteStatus() async {
    List<RouteStatusModel> routeStatusus = await _routeStatusSync.getApiData();

    await _routeStatusSync.deleteAll(MasterTable.RouteStatus);

    await _routeStatusSync.saveAll(
        model: routeStatusus, table: MasterTable.RouteStatus, parentKey: "");
  }

  //save all flags
  Future syncAllFlags() async {
    List<RouteStatusModel> flags = await _flagSync.getApiData();

    await _flagSync.deleteAll(MasterTable.RouteStatus);

    await _flagSync.saveAll(
        model: flags, table: MasterTable.Flags, parentKey: "");
  }




  

  Future syncDocumentType() async {
    List<DocumentsTypeModel> documentTypeModel =
        await _documentsTypeSync.getApiData();

    await _documentsTypeSync.deleteAll(MasterTable.DocumentType);

    documentTypeModel.forEach((dt) async => {
          await _documentsTypeSync.save(
              model: dt,
              table: MasterTable.DocumentType,
              parentKey: dt.serviceProviderId)
        });
  }



   


  resyncSpecificTableData(MasterTable tableName) async {}



  wipeAllOfflineTables() async {
    /// Wipe all offline tables.
    /// MasterData
    await wipeAllMasterData();
    await MasterDataDBModel().deleteAll();

    await NotesDBModel().deleteAll();
    await OrderDetailDBModel().deleteAll();
    await RouteDBModel().deleteAll();
    await SyncQueueDBModel().deleteAll();

    await DatabaseHelper().vacuum();

    FileStorage().removeFile(filename: AUTH_TOKEN_FILENAME);
    FileStorage().removeFile(filename: LOGGED_IN_FILENAME);
    FileStorage().removeFile(filename: MASTER_DATA_SYNC_FILENAME);
    DatabaseClient().close();
    FileStorage().removeFile(filename: OFFLINE_DB_FILENAME);
    FileStorage().removeFile(filename: CACHED_IMAGE_SQFLITE_FILENAME);

    /// Route

    /// Orderdetail
    /// service
    /// parts
    /// notes
    ///
  }


  
  resyncAllOfflineTables() async {
    await wipeAllMasterData();
    await syncAllMasterData();
  }

  Future<int> createSyncQueue(SyncQueueDBModel dbmodel) async {
    return await DatabaseHelper().save(dbmodel);
  }


  Future<void> createAllSyncQueue(List<SyncQueueDBModel> dbmodel) async {
    return await DatabaseHelper().saveBatch(dbmodel);
  }


  Future<int> createNote(String orderId, NotesModel note) {
    print("CREATE NOTE : $orderId for ${note.noteData}");
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'orderId',
      value: orderId,
      jsonPostData: encode(note),
      syncFlag: 0,
      event: SyncEvent.ADD_NOTES.toString(),
    ));
  }


  Future<int> createPart(String orderId, PartsModel part) {
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'orderId',
      value: orderId,
      jsonPostData: encode(part),
      syncFlag: 0,
      event: SyncEvent.ADD_PART.toString(),
    ));
  }


  Future<int> createDocument(String orderId, DocumentsModel document) {
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'orderId',
      value: orderId,
      jsonPostData: encode(document),
      syncFlag: 0,
      event: SyncEvent.ADD_DOCUMENT.toString(),
    ));
  }


  Future<void> createMultipleDocuments(
      String orderId, List<DocumentsModel> documents) {
    List<SyncQueueDBModel> syncQueueDocModel = List();
    documents.forEach((d) => {
          syncQueueDocModel.add(SyncQueueDBModel(
            createdDate: DateTime.now().toUtc().toString(),
            key: 'orderId',
            value: orderId,
            jsonPostData: encode(d),
            syncFlag: 0,
            event: SyncEvent.ADD_DOCUMENT.toString(),
          ))
        });

    return createAllSyncQueue(syncQueueDocModel);
  }




  // Future<int> createMultipleDocuments(
  //     String orderId, List<DocumentsModel> documents) {
  //   return createSyncQueue(SyncQueueDBModel(
  //     createdDate: DateTime.now().toUtc().toString(),
  //     key: 'orderId',
  //     value: orderId,
  //     jsonPostData: encode(document),
  //     syncFlag: 0,
  //     event: SyncEvent.ADD_DOCUMENT.toString(),
  //   ));
  // }


  

  Future<int> updateRouteStatus(String routeId, RouteStatusModel routeModel) {
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'routeId',
      value: routeId,
      jsonPostData: encode(routeModel),
      syncFlag: 0,
      event: SyncEvent.UPDATE_ROUTE_STATUS.toString(),
    ));
  }



  Future<int> updateFinanceInOrder(
      String orderId, OrderFinanceModel financeModel) {
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'orderId',
      value: orderId,
      jsonPostData: encode(financeModel),
      syncFlag: 0,
      event: SyncEvent.UPDATE_FINANCE.toString(),
    ));
  }

  Future<int> createService(
      {String orderId, ServicesModel service, bool update: false}) {
    return createSyncQueue(SyncQueueDBModel(
      createdDate: DateTime.now().toUtc().toString(),
      key: 'orderId',
      value: orderId,
      jsonPostData: encode(service),
      syncFlag: 0,
      event: update
          ? SyncEvent.UPDATE_SERVICE.toString()
          : SyncEvent.ADD_SERVICE.toString(),
    ));
  }




  Future<List<PartsStatusModel>> getAllPartsStatus() async {
    return await _partsStatusSync.getAll() as List<PartsStatusModel>;
  }

  Future<List<RouteStatusModel>> getAllRouteStatus() async {
    return await _routeStatusSync.getAll() as List<RouteStatusModel>;
  }


  //get all flags from offline table
  Future<List<FlagsModel>> getAllFlags({@required String orderId}) async {
    
    return await _flagSync.getAll() as List<FlagsModel>;

  }




  Future<List<PartsTypeModel>> getAllPartsType() async {
    return await _partsTypeSync.getAll() as List<PartsTypeModel>;
  }

  Future<List<ServiceComponentModel>> getAllServiceComponent(
      String lineOfBusinessId) async {
    return await _serviceComponentSync.getAllForLineofBusiness(lineOfBusinessId)
        as List<ServiceComponentModel>;
    // return _serviceComponentSync.getAll() as List<ServiceComponentModel>;
  }

  Future<List<ServiceTypeModel>> getAllServiceType(
      String lineOfBusinessId) async {
    return await _serviceTypeSync.getAllForLineofBusiness(lineOfBusinessId)
        as List<ServiceTypeModel>;
    // return serviceTypes;
    // return _serviceComponentSync.getAll() as List<ServiceComponentModel>;
  }


  Future<UserProfileModel> getUserProfile() async {

    List<UserProfileModel> up =  await _userProfileSync.getAll() as List<UserProfileModel>;
    print("Offline user profile dataaaa:$up");
    return up.isEmpty ? null : up[0];
  }


  Future<AppSettingsModel> getAppSettings() async {
    List<AppSettingsModel> as =  await _appSettingsSync.getAll() as List<AppSettingsModel>;
    return as.isEmpty ? null : as[0];
  }

  Future<List<ServiceStatusModel>> getAllServiceStatusAndItsSubStatus() async {
    return await _serviceStatusSync.getAll() as List<ServiceStatusModel>;
  }
  

  Future<List<DocumentsTypeModel>> getAllDocumentTypeforServiceProvider(
      String serviceProviderId) async {
    return await _documentsTypeSync.getAllDocumentTypesForServiceProvider(
        serviceProviderId) as List<DocumentsTypeModel>;
  }

  updateRoute(RouteModel routeModel) {}

  // updateOrderDetail(OrderDetailModel orderDetailModel) {}

  wipeOutExpiredRecords() {
    // Delete the records in orderdetail and route table createddate is more than 7 days.
  }

  updateSettings() {}

  Future<List<SyncQueueDBModel>> getQueue() async {
    return await DatabaseHelper().getAll(SyncQueueDBModel());
  }

  Future<List<PaymentModeModel>> getAllPaymentModes() async {
    return await _paymentModeSync.getAll() as List<PaymentModeModel>;
  }

  loadAllMasterData() {
    _lobSync.getAll();
    /// Load all master data in memory, so that it will be faster.
  }
}
