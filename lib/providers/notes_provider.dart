
import 'package:etteo_demo/api/notes_api.dart';
import 'package:etteo_demo/model/order_detail/notes_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/notes_db_model.dart';
import 'package:meta/meta.dart';

class NotesProvider {
  final NotesApi notesApi = new NotesApi();

  Future<int> saveNotesToOfflineStorage(
      String orderId, NotesModel newNote) async {
    NotesDBModel note = NotesDBModel(
        createdDate: DateTime.now().toUtc().toString(),
        orderId: orderId,
        notesJson: newNote,
        syncFlag: 0);
    return DatabaseHelper().save(note);
  }

  Future<List<NotesModel>> readAllNotesFromOfflineStorage(
      String orderId) async {
    List<NotesDBModel> fetchedRoutes = await DatabaseHelper()
        .getAllById<NotesDBModel>(NotesDBModel(), orderId, 'orderId');

    List<NotesModel> resultRoutes = List();
    fetchedRoutes.forEach((f) => resultRoutes.add(f.notesJson));
    return resultRoutes;
  }

  Future<dynamic> createNoteForOrder(
      {@required String orderId, @required NotesModel note}) async {
    return await notesApi.createNoteForOrder(orderId: orderId, note: note);
  }
}
