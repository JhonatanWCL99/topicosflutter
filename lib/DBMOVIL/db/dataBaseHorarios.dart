import 'dart:async';

import 'package:registro_login/DBMOVIL/modelosDB/horarios.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHorarios {
  static Database _database;
  static DatabaseHorarios _myDB;
  DatabaseHorarios._createInstance();

  factory DatabaseHorarios() {
    if (_myDB == null) {
      _myDB = DatabaseHorarios._createInstance();
      print('database initialize.....');
    }
    return _myDB;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialize();
    }
    return _database;
  }

  Future<Database> initialize() async {
    var dir = await getDatabasesPath();
    var path = dir + "horarios.db";
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
             await db.execute( 'CREATE TABLE horarios (id INTEGER PRIMARY KEY AUTOINCREMENT, ' + 
              'nombreServi TEXT not null, dias TEXT not null, horario TEXT not null)');

    });
    return database;
  }

  void insert(Map<String, dynamic> map, String tabla) async {
    var db = await this.database;
    await db.insert(tabla, map);
  }

  Future<void> delete(String tabla, note) async { //Eliminar
    var db = await this.database;
    return db.delete(tabla, where: 'id = ?', whereArgs: [note.id]);
  }  

  Future<List<HorariosModel>>  getListHorarios() async {
    var db = await this.database;
    final List<Map<String, dynamic>> notesMap = await db.query("horarios"); // Listado de maps

    return List.generate(
      notesMap.length,
      (i) => HorariosModel(
          id: notesMap[i]['id'],
          nombreServicios: notesMap[i]['nombreServi'],
          dias: notesMap[i]['dias'],
          horario: notesMap[i]['horario']
      )
    );
  }

}