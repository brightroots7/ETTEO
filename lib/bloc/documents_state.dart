
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DocumentsState {}

class InitialDocumentsState extends DocumentsState {}

class DocumentsForOrderFetched extends DocumentsState {
  final List<DocumentsModel> documents;
  DocumentsForOrderFetched({@required this.documents});
}

class DocumentsCreated extends DocumentsState {
  final List<DocumentsModel> documents;
  DocumentsCreated({@required this.documents});
}

class AddDocumentsInOrder extends DocumentsState {
  final List<DocumentsModel> documents;
  AddDocumentsInOrder({@required this.documents});
}

class DocumentsForOrderFetching extends DocumentsState {}

class DocumentsCreating extends DocumentsState {}

class DocumentDropdownValuesFetching extends DocumentsState {}

class DocumentDropdownValuesFetched extends DocumentsState {}
