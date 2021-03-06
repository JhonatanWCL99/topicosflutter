import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/modelos/servicio.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/data/my_database.dart';
import 'package:registro_login/widgets/widgets.dart';

class CreateNewAccount2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Seleccione su Categoria(s)',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: Categorias());
  }
}

class Categorias extends StatefulWidget {
  @override
  StateCategoria createState() => StateCategoria();
}

class StateCategoria extends State<Categorias> with TickerProviderStateMixin {
  MyDatabase _myDatabase = MyDatabase();
  List<String> opciones = ['Carpintero', 'Electricista', 'Plomero'];
  List<bool> seleccionado = [];
  Future<List<Servicio>> _servicios;

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');
    super.initState();

    Api _api = new Api();
    _servicios = _api.getServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: FutureBuilder<List>(
                  future: _servicios,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          if (index < snapshot.data.length) {
                            seleccionado.add(false);
                            return Column(
                              children: <Widget>[
                                Container(
                                  height: 30,
                                  child: FilterChip(
                                    // selected: seleccionado[index],
                                    label: Text(
                                      snapshot.data[index].nombre,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    avatar: FlutterLogo(),
                                    elevation: 10,
                                    pressElevation: 5,
                                    shadowColor: Colors.teal,
                                    backgroundColor: Colors.black54,
                                    selectedColor: Colors.blue,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        // seleccionado[index] = selected;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    } else
                      return Text("-------");
                  }),
            ),
            GestureDetector(
              onTap: () {
                for (int i = 0; i < seleccionado.length; i++) {
                  if (seleccionado[i]) {
                    final Map<String, dynamic> map = {"nombre": _servicios};
                    _myDatabase.insert(map, 'categorias');
                  }
                }
                Navigator.pushNamed(context, 'CreateNewAccount3');
              },
              child: RoundedButton(buttonName: 'Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
