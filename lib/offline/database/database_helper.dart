import 'package:etteo_demo/offline/database/database.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /// Save the model to database
  Future<int> save<T extends BaseDatabaseModel>(T model) async {
    return await DatabaseClient().db.insert(
          model.tableName(),
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
  }

  // Save the list of model in batch - insert at once.
  Future<void> saveBatch<T extends BaseDatabaseModel>(List<T> models) async {
    Database _db = DatabaseClient().db;

    _db.transaction((txn) async {
      var batch = txn.batch();

      // models.forEach((model) => {batch.insert(model.tableName(), model)});
      models.forEach((model) => {
            batch.insert(model.tableName(), model.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace)
          });

      await batch.commit(continueOnError: true);
      // await batch.commit(continueOnError: true);
    });
  }

  Future<T> getByColumn<T extends BaseDatabaseModel>(
      T model, String id, String whereColumn) async {
    Database _db = DatabaseClient().db;
    List<Map> maps = await _db.query(model.tableName(),
        columns: model.columns(), where: '$whereColumn = ?', whereArgs: [id]);
        print("get data from offline By Column $id:${maps.length}");
    if (maps.length > 0) {
      return model.fromMap(maps.first);
    }
    return null;
  }

  // Fetch all the records for the models.
  Future<List<T>> getAll<T extends BaseDatabaseModel>(T model) async {
    Database _db = DatabaseClient().db;
    List<Map> result = await _db.query(model.tableName(), columns: model.columns());
        
    print("DATA BASE HELPER getAll()${model.tableName()} result:$result");

    List<T> resultList = List();
    result.forEach((f) => resultList.add(model.fromMap(f)));
    print("DATA BASE HELPER getAll()${model.tableName()} resultList:$resultList");
    return resultList;
  }



  Future<List<T>> getAllById<T extends BaseDatabaseModel>(
   T model, String id, String whereColumn) async {

    Database _db = DatabaseClient().db;
    print("_db:$_db");
    print("model.tableName :${model.tableName()}");
    List<Map> result = await _db.query(model.tableName(),
        columns: model.columns(), where: '$whereColumn = ?', whereArgs: [id]);
   print("READ DATA BASE HELPER getAllById $id  result:$result");
    List<T> resultList = List();
    result.forEach((f) => resultList.add(model.fromMap(f)));
     print("DATA BASE HELPER getAllById $id resultList:$resultList");
    return resultList;
  }

  Future<int> update<T extends BaseDatabaseModel>(
      T model, String id, String whereColumn) async {
    Database _db = DatabaseClient().db;
    return await _db.update(model.tableName(), model.toUpdateMap(),
        where: '$whereColumn = ?', whereArgs: [id]);
  }

  Future<int> delete<T extends BaseDatabaseModel>(
      T model, String id, String whereColumn) async {
    Database _db = DatabaseClient().db;
    return await _db
        .delete(model.tableName(), where: '$whereColumn = ?', whereArgs: [id]);
  }

  Future<void> deleteAll<T extends BaseDatabaseModel>(T model) async {
    Database _db = DatabaseClient().db;
    return await _db.execute('delete from ' + model.tableName());
  }

  /// Use this only if deleting all offline data.
  vacuum() async {
    Database _db = DatabaseClient().db;
    return await _db.execute('vacuum');
  }
}
