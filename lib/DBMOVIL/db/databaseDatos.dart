
import 'dart:async';

import 'package:registro_login/DBMOVIL/modelosDB/empleado.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDatos {
  static Database _database;
  static DatabaseDatos _myDB;
  DatabaseDatos._createInstance();

  factory DatabaseDatos() {
    if (_myDB == null) {
      _myDB = DatabaseDatos._createInstance();
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
    var path = dir + "datos.db";
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
             await db.execute('CREATE TABLE datos_basicos (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
                          'ci TEXT not null, nombreYApellido TEXT not null,direccion TEXT not null, ' +
                          'estado TEXT not null, imagePerfil TEXT not null, telefono TEXT not null, ' +
                          'sexo TEXT not null, tipo TEXT not null)'
              );

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

  Future<List<Empleado>> getListDatos() async {
    var db = await this.database;
    final List<Map<String, dynamic>> notesMap = await db.query("datos_basicos"); // Listado de maps

    return List.generate(
      notesMap.length,
      (i) => Empleado(
          id: notesMap[i]['id'],
          ci: notesMap[i]['ci'], 
          nombreYApellido: notesMap[i]['nombreYApellido'],
          direccion: notesMap[i]['direccion'],
          imagePerfil: notesMap[i]['imagePerfil'],
          telefono: notesMap[i]['telefono']
      )
    );
  }
}