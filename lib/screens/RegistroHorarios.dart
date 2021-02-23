import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/modelos/Horario.dart';

import '../api.dart';
import '../widgets/rounded-button.dart';

class RegistroHorarios extends StatelessWidget {
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

class StateHorario extends State<Horarios> {
  List<DateTime> opciones = [];
  List<bool> seleccionado = [false, false, false];

  List<String> dias = ["Lun", "Mar", "Mie", "Jue", "Vie"];
  List<bool> selectDias = [false, false, false, false, false];

  List<String> horas = ["7:00", "8:00", "9:00", "10:00", "11:00"];
  List<bool> selectHoras = [false, false, false, false, false];

  Future<List<Horario>> _horarios;
  List<bool> _selectHorarios = [];

  @override
  void initState() {
    super.initState();

    Api _api = new Api();
    _horarios = _api.getHorarios();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _drawerDias(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _drawerHorarios(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: RoundedButton(
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
          ),
        ],
      )
    );
  }

  _drawerDias(BuildContext context){
      return Container(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, i){
            if(i < dias.length) return Padding(padding: const EdgeInsets.only(left: 15),
                                              child: _getDias(i));
            return null;
          },
        ),
      );
  }

  _drawerHorarios(BuildContext context){
    return Container(
      height: 40,
      child: FutureBuilder<List>(
          future: _horarios,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  if (index < snapshot.data.length){
                      _selectHorarios.add(false); 
                      return Padding(padding: const EdgeInsets.only(left: 15),
                                   child:_getHoras(snapshot, index));
                  } return null;
                },
              );
            }else return Text("");
          }
      ),
    );
  }

  _getDias(i){
      return ChoiceChip(
        selected: selectDias[i],
        label: Text(
          dias[i],
          style: TextStyle(color: Colors.white),
        ),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          setState(() {
            selectDias[i] = selected;
          });
        },
    );
  }

  _getHoras(AsyncSnapshot<List> snapshot, i){
    return ChoiceChip(
        selected: _selectHorarios[i],
        label: Text(
          snapshot.data[i].hora,
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
            _selectHorarios[i] = selected;
          });
        },
    );

  }


}