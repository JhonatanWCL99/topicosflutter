import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/pallete.dart';
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
        body: Categoria());
  }
}

class Categoria extends StatefulWidget {
  @override
  StateCategoria createState() => StateCategoria();
}

class StateCategoria extends State<Categoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      InputChip(
        padding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.blue.shade600,
          child: Text('JW'),
        ),
        label: Text('James Watson'),
        //selected: _isSelected,
        selectedColor: Colors.green,
        onSelected: (bool selected) {
          setState(() {
        // _isSelected = selected;
       });
      )
    ]));
  }
}
