import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static const _databaseName = "taskManagement.db";
  static const _databaseVersion = 1;
  static const table = 'task';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnDate = 'date';
  static const columnStatus = 'status';

  // make this a singleton class
  TaskDatabase._privateConstructor();
  static final TaskDatabase instance = TaskDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnStatus TEXT NOT NULL
          )
          ''');
    });
  }
}
