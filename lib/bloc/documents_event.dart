
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DocumentsEvent {}

class CreateNewDocument extends DocumentsEvent {
  final String orderId;
  final DocumentsModel document;
  CreateNewDocument({@required this.orderId, this.document});
}

class CreateNewMultipleDocuments extends DocumentsEvent {
  final String orderId;
  final List<DocumentsModel> documents;
  CreateNewMultipleDocuments({@required this.orderId, this.documents});
}

class FetchAllDocumentsForOrder extends DocumentsEvent {
  final String orderId;
  FetchAllDocumentsForOrder({@required this.orderId});
}

class FetchDocumentDropdownValues extends DocumentsEvent {}
