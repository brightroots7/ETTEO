import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String OFFLINE_DB_FILENAME = 'etteo_database.db';

class DatabaseClient {
  static DatabaseClient _singleton = new DatabaseClient._internal();

  factory DatabaseClient() {
    return _singleton;
  }

  DatabaseClient._internal();
  Database _db;

   void init() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, OFFLINE_DB_FILENAME);

    _db = await openDatabase(dbPath, version: 1, onCreate: _create);
  
   
  }

  Database get db => _db ;
  // Database get db => _db != null ?_db  : init();



  // Future<Database> get database async {
  //   if (_db != null)
  //   return _db;

  //   // if _database is null we instantiate it
  //   _db = await init();
  //   return _db;
  // }
  

  void close() async {
    await _db.close();
  }
}

Future _create(Database db, int version) async {
  await db.execute("""
    CREATE TABLE routes (
      id INTEGER PRIMARY KEY, 
      routeId TEXT NOT NULL,
      orderId TEXT NOT NULL,
      routeJson TEXT NOT NULL,
      serviceDate TEXT NOT NULL,
      createdDate TEXT NOT NULL,
      updatedDate TEXT,
      syncFlag INTEGER NOT NULL default 0,
      CONSTRAINT route_unique UNIQUE (routeId, serviceDate)
    )""");

  await db.execute("""
    CREATE TABLE orderdetail (
      id INTEGER PRIMARY KEY, 
      orderId TEXT NOT NULL,
      orderDetailJson TEXT NOT NULL,
      createdDate TEXT NOT NULL,
      updatedDate TEXT,
      serviceDate TEXT NOT NULL,
      syncFlag INTEGER NOT NULL default 0,
      CONSTRAINT order_detail_unique UNIQUE (orderId)
    )""");

  await db.execute("""
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY,
      orderId TEXT NOT NULL,
      notesJson TEXT NOT NULL,
      createdDate TEXT NOT NULL,
      syncFlag INTEGER NOT NULL default 0
    )""");

  await db.execute("""
    CREATE TABLE documents (
      id INTEGER PRIMARY KEY,
      orderId TEXT NOT NULL,
      docJson TEXT NOT NULL,
      createdDate TEXT NOT NULL,
      docRelativePath TEXT NOT NULL,
      syncFlag INTEGER NOT NULL default 0
    )""");

  await db.execute("""
    CREATE TABLE masterdata (
      id INTEGER PRIMARY KEY,
      parentKey TEXT,
      key TEXT NOT NULL,
      jsonData TEXT NOT NULL,
      masterDataName TEXT NOT NULL,
      createdDate TEXT NOT NULL
    )""");

  await db.execute("""
    CREATE TABLE syncqueue (
      id INTEGER PRIMARY KEY,
      key TEXT NOT NULL,
      value TEXT NOT NULL,
      jsonPostData TEXT NOT NULL,
      event TEXT NOT NULL,
      error TEXT,
      createdDate TEXT NOT NULL,
      syncFlag INTEGER NOT NULL default 0
    )""");

  // db.commit();
}
