import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/data/my_database.dart';

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
  List<bool> seleccionado = [false, false, false];

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');
    super.initState();
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < opciones.length; i++) {
      FilterChip filterChip = FilterChip(
        selected: seleccionado[i],
        label: Text(
          opciones[i],
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
            seleccionado[i] = selected;
          });
        },
      );

      chips.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: filterChip,
      ));
    }
    return ListView(scrollDirection: Axis.horizontal, children: chips);
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
              child: _buildChips(),
            ),
            GestureDetector(
              onTap: () {
                print(seleccionado);
                for (int i = 0; i < seleccionado.length; i++) {
                  if (seleccionado[i]) {
                    final Map<String, dynamic> map = {"nombre": opciones[i]};
                    print(map);
                    // _myDatabase.insert(map, "categorias");
                  }
                }
                // Navigator.pushNamed(context, 'CreateNewAccount');
              },
              child: Container(
                child: Text(
                  'Continuar',
                  style: kBodyText,
                ),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(width: 1, color: kWhite))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
