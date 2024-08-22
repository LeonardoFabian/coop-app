import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = 'cooptrabajo.db';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name TEXT,
        slug TEXT UNIQUE,
        order INTEGER,
        featuredImage TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        publishedAt TEXT,
      );

      CREATE TABLE services (
        id INTEGER PRIMARY KEY,
        title TEXT,
        slug TEXT UNIQUE,
        featuredImage TEXT,
        price REAL,
        timeToComplete TEXT,
        order INTEGER,
        category INTEGER,
        description TEXT,
        summary TEXT, 
        createdAt TEXT,
        updatedAt TEXT,
        publishedAt TEXT,
        isUpdated INTEGER,
        FOREIGN KEY (category) REFERENCES categories(id)
      );

      CREATE TABLE targets (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        slug TEXT UNIQUE,
        createdAt TEXT,
        updatedAt TEXT,
        publishedAt TEXT,
      );

      CREATE TABLE service_targets (
        id INTEGER PRIMARY KEY,
        service_id INTEGER,
        target_id INTEGER,
        FOREIGN KEY (service_id) REFERENCES services(id),
        FOREIGN KEY (target_id) REFERENCES targets(id)
      );

      CREATE TABLE collaterals (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        publishedAt TEXT,
      );

      CREATE TABLE service_collaterals (
        id INTEGER PRIMARY KEY,
        service_id INTEGER,
        collateral_id INTEGER,
        FOREIGN KEY (service_id) REFERENCES services(id),
        FOREIGN KEY (collateral_id) REFERENCES collaterals(id)
      );
    ''');
  }
}
