import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/bloc/notes_event.dart';
import 'package:etteo_demo/bloc/notes_state.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/model/order_detail/order_detail_model.dart';
import 'package:etteo_demo/offline/sync/sync_queue%20.dart';



class NotesBloc extends Bloc<NotesEvent, NotesState> {
  OrderDetailModel orderDetailModel;
  OfflineApi _offlineApi = OfflineApi();

  List<NotesModel> notes = List();
  @override
  NotesState get initialState => InitialNotesState();

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    // if (event is FetchAllNotesForOrder) {
    //   yield NotesForOrderFetching();
    //   notes =
    //       await _notesProvider.readAllNotesFromOfflineStorage(event.orderId);
    //   // notes
    //   yield NotesForOrderFetched(notes: notes);
    // }

    if (event is CreateNewNote) {
      yield NotesCreating();

      int id = await _offlineApi.createNote(event.orderId, event.note);

      if (id != 0) {
        // if (id != 0) {
        notes.add(event.note);

        if (AppConfig().isOnline) {
          // This will create a post call from queu but does not stop the rending UI.
          Future(() => {SyncQueue().checkSyncQueue()});
        }

        orderDetailModel.addNoteList(notes);

        yield NotesCreated(notes: notes);
      }
    }
  }
}
