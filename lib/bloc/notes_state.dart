import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotesState {}

class InitialNotesState extends NotesState {}

class NotesForOrderFetched extends NotesState {
  final List<NotesModel> notes;
  NotesForOrderFetched({@required this.notes});
}

class NotesCreated extends NotesState {
  final List<NotesModel> notes;
  NotesCreated({@required this.notes});
}

class AddNotesInOrder extends NotesState {
  final List<NotesModel> notes;
  AddNotesInOrder({@required this.notes});
}

class NotesForOrderFetching extends NotesState {}

class NotesCreating extends NotesState {}
