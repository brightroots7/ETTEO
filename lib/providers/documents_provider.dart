
import 'package:etteo_demo/api/documents_api.dart';
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:meta/meta.dart';

class DocumentsProvider {
  final DocumentsApi documentsApi = new DocumentsApi();

  // Future<int> saveDocumentsToOfflineStorage(
  //     String orderId, DocumentsModel newDocument) async {
  //   DocumentStorage document = DocumentStorage(
  //       createdDate: DateTime.now().toUtc().toString(),
  //       orderId: orderId,
  //       notesJson: newDocument,
  //       syncFlag: 0);
  //   return DatabaseHelper().save(document);
  // }

  // Future<List<DocumentsModel>> readAllDocumentsFromOfflineStorage(
  //     String orderId) async {
  //   List<DocumentStorage> fetchedRoutes = await DatabaseHelper()
  //       .getAllById<DocumentStorage>(DocumentStorage(), orderId, 'orderId');

  //   List<DocumentsModel> resultRoutes = List();
  //   fetchedRoutes.forEach((f) => resultRoutes.add(f.documentsJson));
  //   return resultRoutes;
  // }

  Future<List<DocumentsModel>> getAllDocumentsByOrderId({
    @required String orderId,
  }) async {
    return await documentsApi.getAllDocumentsByOrderId(orderId: orderId);
  }
}
