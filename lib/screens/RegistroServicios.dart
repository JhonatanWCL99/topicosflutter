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

  
  Future<List<Servicio>> _servicios;
  List<String> _serviciosR = [];
  List<bool> _selectServicio = [];
  List<bool> _selectServicioR = [];

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');
    super.initState();

    _drawerSelectedP();
    Api _api = new Api();
    _servicios = _api.getServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: _drawerServicio(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 380.0),
            child: RoundedButton(
              flatButton: FlatButton(
                    onPressed: (){ 
                      _getSelected(); 
                      // Navigator.of(context).pushNamed("RegistroHorarios");
                      },
                    child: Text(
                      'Continuar',
                      style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _drawerServicio(){
    return Container(
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
                      _selectServicio.add(false);
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child:_drawerSelected(snapshot, index)
                    );
                  } return null;
                },
              );
            }else return Text("----");
          }),
    );
  }

  _getServicios(AsyncSnapshot<List> snapshot, i){
    _serviciosR.add(snapshot.data[i].nombre);
    return FilterChip(
      selected: _selectServicio[i],
      label: Text(
        snapshot.data[i].nombre,
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
          _selectServicio[i] = selected;
        });
      },
    );
  }

  _getSelected(){
    List<String> L = List();
    for (var i = 0; i < _selectServicio.length; i++) {
      if(_selectServicio[i] == true) L.add(_serviciosR[i]);
    }
    print(L);
  }

  _drawerSelected(AsyncSnapshot<List> snapshot, i){
    return FilterChip(
      selected: _selectServicioR[i],
      label: Text(
        snapshot.data[i].nombre,
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
          _selectServicio[i] = selected;
        });
      },
    );
  }

  _drawerSelectedP(){
    List<String> L = List();
    L.addAll(['Carpintería', 'Plomería']);
    for (var i = 0; i < L.length; i++) {
      for (var j = 0; j < _serviciosR.length; j++) {
          if(L[i] == _serviciosR[j])
            _selectServicioR[i] = true;
          else _selectServicioR[i] = false;
      }
    }
  }
}
