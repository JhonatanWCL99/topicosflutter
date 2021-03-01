import 'dart:async';

import 'package:registro_login/modelos/trabajador.dart';
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
      db.execute(
              'CREATE TABLE datos_basicos (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
              'ci TEXT not null, nombreYApellido TEXT not null,direccion TEXT not null, ' +
              'estado TEXT not null, imagePerfil TEXT not null, telefono TEXT not null, ' +
              'sexo TEXT not null, tipo TEXT not null)'
              );

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

  Future<List<Empleado>> notes() async {
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





// import 'package:registro_login/modelos/servicio.dart';
// import 'package:registro_login/modelos/trabajador.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class MyDatabase{

//       static Database myDatabase;

//       static _openDB() async{
//         myDatabase = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
//           onCreate: (db,version){
//                db.execute(
//               'CREATE TABLE datos_basicos (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
//               'ci TEXT not null, nombreYApellido TEXT not null,direccion TEXT not null, ' +
//               'estado TEXT not null, imagePerfil TEXT not null, telefono TEXT not null, ' +
//               'sexo TEXT not null, tipo TEXT not null)'
//               );

//               // db.execute( 'CREATE TABLE categorias (id INTEGER PRIMARY KEY AUTOINCREMENT, ' + 'nombre TEXT not null)');

//           }, version: 1);
//       }

//       static Future<void> insert(Empleado note) async{
//         await _openDB();
//         return myDatabase.insert("datos_basicos", note.toMap());
//       }


//       static Future<void> delete(Empleado note) async {
//         await _openDB();

//         return myDatabase.delete("datos_basicos", where: 'id = ?', whereArgs: [note.id]);
//       }      

//       static Future<void> update(Empleado note) async {
//         await _openDB();
//         return myDatabase.update("datos_basicos",note.toMap(), where: 'id = ?', whereArgs: [note.id]);
//       }

//       static Future<List<Empleado>> notes() async {
//           await _openDB();

//           final List<Map<String, dynamic>> notesMap = await myDatabase.query("datos_basicos"); // Listado de maps

//           // for(var n in notesMap){
//           //   print("ci______" + n['ci']);
//           //   print("Nombre y apellido______" + n['nombreYApellido']);
//           //   print("dirección______" + n['direccion']);
//           //   print("estado______" + n['estado']);
//           //   print("image______" + n['imagePerfil']);
//           //   print("teléfono______" + n['telefono']);
//           //   print("sexo______" + n['sexo']);
//           //   print("tipo______" + n['tipo']);
//           // }

//           return List.generate(
//             notesMap.length,
//             (i) => Empleado(
//                 id: notesMap[i]['id'],
//                 ci: notesMap[i]['ci'], 
//                 nombreYApellido: notesMap[i]['nombreYApellido'],
//                 direccion: notesMap[i]['direccion'],
//                 imagePerfil: notesMap[i]['imagePerfil'],
//                 telefono: notesMap[i]['telefono']
//             )
//           );
//       }

//       static Future<void> insertCategory(Servicio note) async{
//         await _openDB();
//         return myDatabase.insert("categorias", note.toMap());
//       }


//       static Future<void> deleteCataory(Servicio note) async {
//         await _openDB();
//         return myDatabase.delete("categorias", where: 'id = ?', whereArgs: [note.id]);
//       }   

//       static Future<List<Servicio>> generateCategoryList() async {
//           await _openDB();

//           final List<Map<String, dynamic>> notesMap = await myDatabase.query("categorias"); // Listado de maps

//           for(var n in notesMap){
//             print("nombre______" + n['nombre']);
//           }

//           return List.generate(
//             notesMap.length,
//             (i) => Servicio(
//                 id: notesMap[i]['id'],
//                 nombre: notesMap[i]['nombre'],
//             )
//           );
//       }

// }