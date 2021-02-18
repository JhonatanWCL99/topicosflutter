import 'dart:async';

import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Database _database;
  static MyDatabase _myDB;
  MyDatabase._createInstance();
  factory MyDatabase() {
    if (_myDB == null) {
      _myDB = MyDatabase._createInstance();
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
    var path = dir + "regitro.db";
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE datos_basicos (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
          'ci INTEGER not null, nombre TEXT not null,direccion TEXT not null, ' +
          'estado TEXT not null, img_perfil TEXT not null, telefono INTEGER not null, ' +
          'sexo TEXT not null, tipo TEXT not null)');
    });
    return database;
  }

  void insert(Map<String, dynamic> map, String tabla) async {
    var db = await this.database;
    var result = await db.insert(tabla, map);
    print('result: $result');

    var resul = await db.query(tabla);
    resul.forEach((element) {
      print(element);
    });
  }

  /* Future<List<Person>> getPeople() async {
    List<Person> people = [];
    var db = await this.database;
    var result = await db.query('person');
    result.forEach((element) {
      var person = Person.fromMap(element);
      people.add(person);
    });
    return people;
  }*/
}
