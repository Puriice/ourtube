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

  Future<Database> setDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentDirectory.path, 'db_ourtube_sqflite.db');
    var database = await openDatabase(dbPath,
        version: 2,
        onCreate: _onCreatingDatabase,
        onUpgrade: _onUpgradingDatabase);
    return database;
  }

  Future<void> _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Video(id TEXT PRIMARY KEY, author TEXT, title TEXT, thumbnailUrl TEXT, type TEXT, duration TEXT, timestamp TEXT, viewCount INTEGER, likes INTEGER, dislikes INTEGER, source TEXT DEFAULT 'youtube', localPath TEXT)");
  }

  // Version 2 adds uploaded videos: source ('youtube' or 'local') and the
  // path of the copied video file.
  Future<void> _onUpgradingDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          "ALTER TABLE Video ADD COLUMN source TEXT DEFAULT 'youtube'");
      await db.execute("ALTER TABLE Video ADD COLUMN localPath TEXT");
    }
  }
}
