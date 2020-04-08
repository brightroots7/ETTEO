import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/documents_event.dart';
import 'package:etteo_demo/bloc/documents_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/documents/documents_type_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';
import 'package:etteo_demo/providers/documents_provider.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsProvider _documentsProvider = DocumentsProvider();
  OfflineApi _offlineApi = OfflineApi();
  OrderDetailModel orderDetail;

  List<DocumentsModel> documents = List();

  List<DocumentsTypeModel> documentTypes = List();

  DocumentsTypeModel selectedDocumentType;

  @override
  DocumentsState get initialState => InitialDocumentsState();

  @override
  Stream<DocumentsState> mapEventToState(
    DocumentsEvent event,
  ) async* {
    if (event is FetchAllDocumentsForOrder) {
      yield DocumentsForOrderFetching();
      // if (!documentLoaded) {
      documents = await _documentsProvider.getAllDocumentsByOrderId(
          orderId: event.orderId);
      // }

      orderDetail.order.documents.clear();
      orderDetail.addDocumentList(documents);

      yield DocumentsForOrderFetched(documents: documents);
    }

    if (event is FetchDocumentDropdownValues) {
      yield DocumentDropdownValuesFetching();

      selectedDocumentType = null;

      documentTypes = await _offlineApi.getAllDocumentTypeforServiceProvider(
          orderDetail.order.owner.ownerId);

      yield DocumentDropdownValuesFetched();
    }

    if (event is CreateNewDocument) {
      yield DocumentsCreating();

      int id = await _offlineApi.createDocument(event.orderId, event.document);

      if (id != 0) {
        if (AppConfig().isOnline) {
          // This will create a post call from queu but does not stop the rending UI.
          Future(() => {SyncQueue().checkSyncQueue()});
        }

        orderDetail.addDocument(event.document);

        yield DocumentsCreated(documents: List.filled(1, event.document));
      }
    }

    if (event is CreateNewMultipleDocuments) {
      yield DocumentsCreating();

      await _offlineApi.createMultipleDocuments(event.orderId, event.documents);

      if (AppConfig().isOnline) {
        // This will create a post call from queu but does not stop the rending UI.
        Future(() => {SyncQueue().checkSyncQueue()});
      }

      event.documents.forEach((d) => orderDetail.addDocument(d));

      yield DocumentsCreated(documents: event.documents);
    }
  }
}
