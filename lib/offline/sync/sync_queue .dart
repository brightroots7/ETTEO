import 'dart:io';

import 'package:etteo_demo/api/orders_api.dart';
import 'package:etteo_demo/api/route_api.dart';
import 'package:etteo_demo/helpers/compress.dart';
import 'package:etteo_demo/helpers/globals.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/model/route/route_status_model.dart';
import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/sync_queue_db_model.dart';
import 'package:etteo_demo/providers/notes_provider.dart';


enum SyncEvent {
  ADD_NOTES,
  ADD_PART,
  ADD_DOCUMENT,
  ADD_SERVICE,
  UPDATE_ROUTE_STATUS,
  // NEW_ROUTE,
  // UPDATE_ROUTE,
  UPDATE_SERVICE,
  UPDATE_FINANCE
}

class SyncQueue {
  static final SyncQueue _singleton = new SyncQueue._internal();
  static bool retry = false;
  static int retryCount = 1;
  int retryMax = 3;
  SyncQueue._internal();

  factory SyncQueue() {
    return _singleton;
  }

  void checkSyncQueue() async {
    if (DatabaseClient().db == null) {
      DatabaseClient().init();
    }

    // Fetch sync queue data
    List<SyncQueueDBModel> queue = await getAllSyncQueueEvents();

    /// If no data found ignore sync.
    if (queue.isEmpty) {
      resetRetry();
      // Do nothing.
      print("SyncQueue is Empty");
      return;
    }
    queue.forEach((queueitem) async => await Future.delayed(
        Duration(seconds: 3), () => syncOfflineEvents(queueitem)));

    // Delete Expired records for routes and orders.
    deleteExpiredRoutes();
    deleteExpiredOrderDetail();
  }

  void checkSyncQueueWithState() async {
    if (DatabaseClient().db == null) {
      DatabaseClient().init();
    }

    // Fetch sync queue data
    List<SyncQueueDBModel> queue = await getAllSyncQueueEvents();

    /// If no data found ignore sync.
    if (queue.isEmpty) {
      resetRetry();
      // Do nothing.
      print("SyncQueue is Empty");
      return;
    }




    if (Globals().syncState == SyncState.IDLE) {
      Globals().setSyncState(SyncState.SCHEDULED);
      await Future.forEach(
              queue,
              (queueitem) async => await Future.delayed(
                  Duration(seconds: 3), () => syncOfflineEvents(queueitem)))
          .whenComplete(() => {Globals().setSyncState(SyncState.IDLE)});
    } else {
      // Globals().setSyncState(SyncState.SCHEDULED);
      print('scheduled - ignore the request');
    }


    

    // Delete Expired records for routes and orders.
    deleteExpiredRoutes();
    deleteExpiredOrderDetail();
  }


  

  resetRetry() {
    SyncQueue.retry = false;
    SyncQueue.retryCount = 1;
  }

  checkForRetry() {
    print('Retry flag - ${SyncQueue.retry}');
    print('Retry count - ${SyncQueue.retryCount}');
    if (SyncQueue.retry && SyncQueue.retryCount < retryMax) {
      // Fetch and sync with remote api one by one.
      print('RETRYING count -  ${SyncQueue.retryCount}');
      checkSyncQueue();

      SyncQueue.retryCount++;

      // print(response);
    } else {
      resetRetry();
    }
  }

  checkSyncQueueAfterOnline() async {
    await Future.delayed(Duration(seconds: 5), () => {checkSyncQueue()});
  }

  Future<List<SyncQueueDBModel>> getAllSyncQueueEvents() async {
    return await DatabaseHelper().getAll(SyncQueueDBModel());
  }



  syncOfflineEvents(SyncQueueDBModel queue) async {
    /// On multithreaded sync check always the latest on this queueItem to avoid duplication issue.
    SyncQueueDBModel queueItem = await DatabaseHelper()
        .getByColumn(SyncQueueDBModel(), queue.id.toString(), 'id');

    if (queueItem == null) return;

    /// If Sync Event exists, work on it
    SyncEvent queueEvent = SyncEvent.values
      .firstWhere((e) => e.toString() == queueItem.event.toString());

    if (queueItem.syncFlag == 1) {
      // 1 - completed and marked for deletion from queue.
      print('QUEUE ITEM - IGNORE 1 - already processed.');
      return;
    }
    if (queueItem.syncFlag == 0) {
      // set to 999
      // inprogress picked by a dispatch event and to processed only once.
      queueItem.syncFlag = 999;
      await DatabaseHelper().update(queueItem, queueItem.id.toString(), 'id');
      print('QUEUE ITEM FLAG - ${queueItem.syncFlag}');
    } else if ((queueItem.syncFlag == 999 && queueItem.error == null) ||
        queueItem.syncFlag == 1) {
      // Ignore 999 , if error persists reprocess.

      /// Check if the created time of this event is greater than 10 minutes retry again
      DateTime createdDate = DateTime.parse(queueItem.createdDate);
      DateTime createdDatePlusTenMinutes = createdDate.add(Duration(minutes: 10));
       
      if (createdDatePlusTenMinutes.isBefore(DateTime.now())) {
        // reprocess after 10 mins.
        queueItem.syncFlag = 0;
        await DatabaseHelper().update(queueItem, queueItem.id.toString(), 'id');
      } else {
        return;
      }
    } else if (queueItem.syncFlag == 999 && queueItem.error != null) {
      queueItem.syncFlag = 999;
      queueItem.error = null;
      await DatabaseHelper().update(queueItem, queueItem.id.toString(), 'id');
      // deleting error for reprocessing.
    }

    switch (queueEvent) {
      case SyncEvent.ADD_DOCUMENT:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> note = postAddDocument(queueItem);
        note.then((n) => removeFromQueueIfNoError(n));

        break;

      case SyncEvent.ADD_NOTES:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> note = postAddNote(queueItem);
        note.then((n) => removeFromQueueIfNoError(n));
        break;

      case SyncEvent.ADD_PART:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> part = postAddPart(queueItem);
        part.then((p) => removeFromQueueIfNoError(p));
        break;

      case SyncEvent.ADD_SERVICE:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> service = postAddService(queueItem);
        service.then((s) => removeFromQueueIfNoError(queueItem));
        break;

      case SyncEvent.UPDATE_ROUTE_STATUS:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> routeStatus = updateRouteStatus(queueItem);
        routeStatus.then((p) => removeFromQueueIfNoError(p));
        break;

      // case SyncEvent.UPDATE_ROUTE:
      //   updateRoute(queueItem);
      //   break;
      case SyncEvent.UPDATE_SERVICE:
        // if (queueItem.syncFlag == 1) return;
        Future<SyncQueueDBModel> part = updateService(queueItem);
        part.then((p) => removeFromQueueIfNoError(p));
        break;

      case SyncEvent.UPDATE_FINANCE:
        Future<SyncQueueDBModel> part = updateFinance(queueItem);
        part.then((p) => removeFromQueueIfNoError(p));
        break;
    }
  }


  Future<SyncQueueDBModel> postAddDocument(SyncQueueDBModel queueItem) async {
    String orderId = queueItem.value;
    DocumentsModel document =
        DocumentsModel.fromJson(decode(queueItem.jsonPostData));
    print("Document Json");
    print(encode(document));

    OrdersApi _orderApi = OrdersApi();

    // Compressing the file.
    File compressedFile = await compressImageFile(File(document.fileLocation));
    document.fileLocation = compressedFile.absolute.path;

    try {
      String documentApi = await _orderApi.addDocumentToOrder(
          orderId: orderId, document: document);
      print("Documents synced using background fetch  - $documentApi");
      if (documentApi != null) queueItem.syncFlag = 1;
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Document error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }
  

  Future<SyncQueueDBModel> postAddNote(SyncQueueDBModel queueItem) async {
    String orderId = queueItem.value;
    NotesModel note = NotesModel.fromJson(decode(queueItem.jsonPostData));
    print("Note Json");
    print(encode(note));

    NotesProvider _notesProvider = NotesProvider();

    try {
      String noteFromApi =
          await _notesProvider.createNoteForOrder(orderId: orderId, note: note);
      print("Note synced using background fetch  - $noteFromApi");
      if (noteFromApi != null) queueItem.syncFlag = 1;
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Note error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }


  Future<SyncQueueDBModel> postAddPart(SyncQueueDBModel queueItem) async {
    OrdersApi _orderApi = OrdersApi();

    String orderId = queueItem.value;
    PartsModel part = PartsModel.fromJson(decode(queueItem.jsonPostData));
    print("Document Json");
    print(encode(part));
    try {
      String addedParts =
          await _orderApi.addPartsToOrder(orderId: orderId, part: part);
      print("Part synced using background fetch $addedParts");
      if (addedParts != null) queueItem.syncFlag = 1;
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Part error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }


  void getNewRoute(SyncQueueDBModel queueItem) {}

  Future<SyncQueueDBModel> updateRouteStatus(SyncQueueDBModel queueItem) async {
    RouteApi _routeApi = RouteApi();

    String routeId = queueItem.value;
    RouteStatusModel routeStatusModel =RouteStatusModel.fromJson(decode(queueItem.jsonPostData));
        
    print(encode(routeStatusModel));

    try {
      bool updatedRouteStatus = await _routeApi.updateRouteStatus(
          routeId: routeId, rsm: routeStatusModel);
      print("Route Status updated using background fetch $updatedRouteStatus");
      if (updatedRouteStatus) {
        queueItem.syncFlag = 1;
      } else {
        queueItem.error = "updated failed";
      }
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Update Route status error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }



  Future<SyncQueueDBModel> postAddService(SyncQueueDBModel queueItem) async {
    OrdersApi _orderApi = OrdersApi();

    String orderId = queueItem.value;
    ServicesModel service =
        ServicesModel.fromJson(decode(queueItem.jsonPostData));
    print("Service Json");
    print(encode(service));

    try {
      String addedService =
          await _orderApi.addServiceToOrder(orderId: orderId, service: service);
      print("Service synced using background fetch $addedService");
      if (addedService != null) queueItem.syncFlag = 1;
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Service error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }

  void deleteExpiredRoutes() {}

  void deleteExpiredOrderDetail() {}

  removeFromQueueIfNoError(SyncQueueDBModel queueItem) async {
    if (queueItem.syncFlag == 1) {
      await DatabaseHelper().delete(queueItem, queueItem.id.toString(), 'id');
    } else if (queueItem.error != null) {
      await DatabaseHelper().update(queueItem, queueItem.id.toString(), 'id');
      SyncQueue.retry = true;
    } else {
      SyncQueue.retry = true;
    }
  }

  Future<SyncQueueDBModel> updateService(SyncQueueDBModel queueItem) async {
    OrdersApi _orderApi = OrdersApi();

    String orderId = queueItem.value;
    ServicesModel service =
        ServicesModel.fromJson(decode(queueItem.jsonPostData));
    print(encode(service));

    try {
      bool updatedService =
          await _orderApi.updateService(orderId: orderId, service: service);
      print("Service Updated using background fetch $updatedService");
      if (updatedService) {
        queueItem.syncFlag = 1;
      } else {
        queueItem.error = "updated failed";
      }
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Service error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }



  Future<SyncQueueDBModel> updateFinance(SyncQueueDBModel queueItem) async {
    OrdersApi _orderApi = OrdersApi();

    String orderId = queueItem.value;
    OrderFinanceModel financeModel =
        OrderFinanceModel.fromJson(decode(queueItem.jsonPostData));
    print(encode(financeModel));

    try {
      String updatedFinance = await _orderApi.updateFinaceInOrder(
          orderId: orderId, finance: financeModel);
      print("Update finance using background fetch $updatedFinance");
      if (updatedFinance != null) {
        queueItem.syncFlag = 1;
      } else {
        queueItem.error = "updated failed";
      }
      return Future(() => queueItem);
    } catch (e) {
      queueItem.error = e.toString();
      print("Update finance error - ${queueItem.error}");
      return Future(() => queueItem);
    }
  }
}
