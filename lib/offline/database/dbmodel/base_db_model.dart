/// All the database model should extend this abstract class and implement below methods.
abstract class BaseDatabaseModel {
  // Convert to map
  Map<String, dynamic> toMap();

  Map<String, dynamic> toUpdateMap();

  // Return the tablename
  String tableName();

  // Return the list of column names
  List<String> columns();

  // Create T model based on the Map
  fromMap(Map<String, dynamic> map);

  Future<void> deleteAll();
}
