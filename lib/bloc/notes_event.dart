import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotesEvent {}

class CreateNewNote extends NotesEvent {
  final String orderId;
  final NotesModel note;
  CreateNewNote({@required this.orderId, this.note});
}

class FetchAllNotesForOrder extends NotesEvent {
  final String orderId;
  FetchAllNotesForOrder({@required this.orderId});
}
