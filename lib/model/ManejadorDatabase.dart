import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'album.dart';

class ManejadorDatabase {
  static const String nombreDb = 'albumes_database.db';
  static const String nombreTabla = 'albumes';
  static Database? _db;
  static ManejadorDatabase? _instance;

  ManejadorDatabase._();

  static ManejadorDatabase getInstance() {
    _instance ??= ManejadorDatabase._();
    return _instance!;
  }

  Future<Database> getDB() async {
    _db ??= await _inicializarDB();
    return _db!;
  }

  Future<Database> _inicializarDB() async {
    final path = join(await getDatabasesPath(), nombreDb);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $nombreTabla("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "titulo TEXT NOT NULL, "
          "artista TEXT NOT NULL, "
          "anio INTEGER NOT NULL, "
          "genre TEXT NOT NULL)",
        );
      },
    );
  }

  Future<int> insertarAlbum(Album album) async {
    final db = await getDB();
    return await db.insert(
      nombreTabla,
      album.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Album>> albumes() async {
    final db = await getDB();
    final List<Map<String, Object?>> result = await db.query(nombreTabla);
    return result.map((e) => Album.fromMap(e)).toList();
  }

  Future<int> actualizarAlbum(Album album) async {
    final db = await getDB();
    return await db.update(
      nombreTabla,
      album.toMap(),
      where: 'id = ?',
      whereArgs: [album.id],
    );
  }

  Future<int> removerAlbum(int id) async {
    final db = await getDB();
    return await db.delete(nombreTabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> cerrarDB() async {
    final db = await getDB();
    await db.close();
  }
}
