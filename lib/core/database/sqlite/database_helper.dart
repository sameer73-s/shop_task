import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'products.db');

    return await openDatabase(path, version: 1, onCreate: _oncreate);
  }

  Future<void> _oncreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE products(
    id INTEGER PRIMARY KEY,
    title TEXT,
    shippingInformation TEXT,
    price REAL,
    rating REAL,
    images TEXT,
    reviews TEXT
  )
  ''');
  }
}
