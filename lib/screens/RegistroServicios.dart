import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/modelos/servicio.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/data/my_database.dart';

import '../widgets/rounded-button.dart';

class RegistroServicios extends StatelessWidget {
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
        body: RegistroServiciosFul());
  }
}

class RegistroServiciosFul extends StatefulWidget {
  @override
  StateRegistroServicios createState() => StateRegistroServicios();
}

class StateRegistroServicios extends State<RegistroServiciosFul> with TickerProviderStateMixin {
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
        padding: const EdgeInsets.only(top: 20, left: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 40,
              child: FutureBuilder<List>(
                  future: _servicios,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, index) {
                          if (index < snapshot.data.length){
                              seleccionado.add(false);
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FilterChip(
                                // selected: seleccionado[index],
                                label: Text(
                                  snapshot.data[index].nombre,
                                  style: TextStyle(color: Colors.white),
                                ),
                                // avatar: FlutterLogo(),
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
                            );
                          }
                        },
                      );
                    }else return Text("-------");
                  }),
            ),
            RoundedButton(
                        flatButton: FlatButton(
                              onPressed: (){  
                                Navigator.of(context).pushNamed("RegistroAutentificacion");
                                },
                              child: Text(
                                'Continuar',
                                style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                        ),
                    ),
          ],
        ),
      ),
    );
  }
}
