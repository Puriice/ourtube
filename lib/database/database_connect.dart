import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'dart:async';

class DatabaseHelper {
  // ignore: unnecessary_new
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? ourtubeDB;

  Future<Database> get db async {
    if (ourtubeDB != null) return ourtubeDB!;
    ourtubeDB = await setDB();
    return ourtubeDB!;
  }

  DatabaseHelper.internal();

  setDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentDirectory.path, 'db_ourtube_sqflite.db');
    var database = await openDatabase(dbPath, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  void _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Video(id TEXT PRIMARY KEY, author TEXT, title TEXT, thumbnailUrl TEXT, type TEXT, duration TEXT, timestamp TEXT, viewCount INTEGER, likes INTEGER, dislikes INTEGER)");
  }
}
