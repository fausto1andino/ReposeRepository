import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:repose_application/src/models/sugerencia_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider dbProvider = DBProvider._();

  DBProvider._();

  Future<Database?>? get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'reposeAPP.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Sugerencia (
          id  INTEGER PRIMARY KEY,
          valoracion  INTEGER,
          titulo TEXT,          
          comentario TEXT          
        )      
      ''');
    });
  }

  Future<int> insert(Sugerencia newElement) async {
    //INSERT INTO Insumo VALUES
    final Database? db = await database;
    final newId = await db!.insert('Sugerencia', newElement.toJson());
    return newId;
  }

  Future<List<Sugerencia>> list() async {
    //SELECT * FROM Insumo
    final Database? db = await database;
    final result = await db!.query('Sugerencia');
    return result.isNotEmpty
        ? result.map((t) => Sugerencia.fromJson(t)).toList()
        : [];
  }
}