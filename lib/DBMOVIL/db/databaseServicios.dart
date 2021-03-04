
import 'dart:async';

import 'package:registro_login/DBMOVIL/modelosDB/servicios.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServicios {
  static Database _database;
  static DatabaseServicios _myDB;
  DatabaseServicios._createInstance();

  factory DatabaseServicios() {
    if (_myDB == null) {
      _myDB = DatabaseServicios._createInstance();
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
    var path = dir + "servicios.db";
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
             await db.execute( 'CREATE TABLE servicios (id INTEGER PRIMARY KEY AUTOINCREMENT, ' + 
              'nombreServi TEXT not null,id_servicio INTEGER not null)');

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

  Future<List<Servicios>>  getListServicios() async {
    var db = await this.database;
    final List<Map<String, dynamic>> notesMap = await db.query("servicios"); // Listado de maps

    return List.generate(
      notesMap.length,
      (i) => Servicios(
          id: notesMap[i]['id'],
          nombreServi: notesMap[i]['nombreServi'],
          id_servicio: notesMap[i]["id_servicio"]
      )
    );
  }

}