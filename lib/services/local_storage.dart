import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "apotek_uisi.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT,
            notelp TEXT,
            alamat TEXT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS beli (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            buyerName TEXT,
            obatId INTEGER,
            obatName TEXT,
            qty INTEGER,
            total INTEGER,
            date TEXT,
            method TEXT,
            resepNumber TEXT,
            note TEXT,
            status TEXT DEFAULT 'Selesai'
          )
        ''');
      },
    );
  }

  Future<int> registerUser(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("users", data);
  }

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      "users",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<int> tambahTransaksi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("beli", data);
  }

  Future<List<Map<String, dynamic>>> getRiwayatTransaksi() async {
    final db = await database;
    return await db.query("beli", orderBy: "id DESC");
  }

  Future<int> deleteTransaksi(int id) async {
    final db = await database;
    return await db.delete("beli", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateTransaksi(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      "beli",
      data,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}