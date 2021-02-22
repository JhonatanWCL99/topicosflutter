import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/pallete.dart';

class CreateNewAccount3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Seleccione su Horario(s)',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: Horarios());
  }
}

class Horarios extends StatefulWidget {
  @override
  StateHorario createState() => StateHorario();
}

class StateHorario extends State<StateHorario> {
  List<DateTime> opciones = [];
  List<bool> seleccionado = [false, false, false];

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < opciones.length; i++) {
      FilterChip filterChip = FilterChip(
        selected: seleccionado[i],
        label: Text(
          opciones[i],
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
