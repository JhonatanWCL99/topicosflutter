import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/DBMOVIL/db/databaseServicios.dart';
import 'package:registro_login/DBMOVIL/modelosDB/servicios.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/screens/RegistroHorarios.dart';

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

class StateRegistroServicios extends State<RegistroServiciosFul> /*with TickerProviderStateMixin*/ {

  DatabaseServicios _myDatabase = DatabaseServicios(); 
  List<bool> _selectServicio = List<bool>();
  

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');

    super.initState();
    _definirValorBool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: _drawServicios(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: RoundedButton(
                      flatButton: FlatButton(
                              onPressed: () async {
                                List L = await _getServiciosSeleccionados();
                                _insertYDeleteSqlite();
                                Navigator.of(context).pushNamed("RegistroHorarios",
                                                                arguments: ServiciosSeleccionados(
                                                                  servicios: L
                                                                  ));
                                
                              },
                              child: Text(
                                'Continuar',
                                style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                          ),
                    ),
          ),
          ]
        )
    );
  }

  _drawServicios(){
      Api api = Api();           
      return Container(
        height: 40,
        child: FutureBuilder(   
        future: api.getServicios(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            print("Servi fu: ${snapshot.data}");

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data == null ? 0: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: _getServicios(snapshot.data, index)
                );
              },
            );
          }else return Text("Esperando...");
        }
        )
    );
  }


 _getServicios(List servi, i){
    return FilterChip(
      selected: _selectServicio[i],
      label: Text(
        servi[i]['nombre'],
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

  _getServiciosBoolNoGuardados() async {
    List<dynamic> listaServi = await _getListaServicios();
    List<bool> listaBool = List();
    for (var j = 0; j < listaServi.length; j++) {
        listaBool.add(false);
    }
    return listaBool;
  }

  Future<dynamic> _getServiciosBoolGuardados() async {
     List<bool> listaBool = List();
     List<Servicios> auxDatoS = await _myDatabase.getListServicios();
     List<dynamic> listaServi = await _getListaServicios();
      int k = 0;
      for (var j = 0; j < listaServi.length; j++) {
        if(k < auxDatoS.length){
          if(listaServi[j] == auxDatoS[k].nombreServi){
            listaBool.add(true);
            k++;
          }else
            listaBool.add(false);
        }else  listaBool.add(false);
      }
      return listaBool;  
  }

  _definirValorBool() async {
    List<Servicios> auxDatoS = await _myDatabase.getListServicios();
    List<bool> listaBool = List();
    if(auxDatoS.isEmpty) listaBool = await _getServiciosBoolNoGuardados();
    else listaBool  = await _getServiciosBoolGuardados();

    setState(() {
        _selectServicio = listaBool;
      });
  }

  _getServiciosSeleccionados()async {
    List<String> L = List();
    List<String> listaServi = await _getListaServicios();
    for (var i = 0; i < listaServi.length; i++) {
      if(_selectServicio[i] == true) L.add(listaServi[i]);
    }
    return L;
  }

  _insertYDeleteSqlite() async {
   
    List<dynamic> listaServi = await _getListaServicios();
    List<Servicios> auxDatosS = await _myDatabase.getListServicios();
    if(auxDatosS.isEmpty){
      for (var i = 0; i < listaServi.length; i++) {
        if(_selectServicio[i] == true)
          _myDatabase.insert({'nombreServi': listaServi[i]}, "servicios");
      }
    }else{
      for (var i = 0; i < auxDatosS.length; i++) {
        _myDatabase.delete('servicios', auxDatosS[i]);
      }

      for (var i = 0; i < listaServi.length; i++) {
        if(_selectServicio[i] == true)
          _myDatabase.insert({'nombreServi': listaServi[i]}, "servicios");
      }
    }
    
  }

  _getListaServicios() async{
    List<String> listaServicios = List();
    Api api = Api();
    List L = await api.getServicios();
    for(var i = 0; i < L.length; i++){
      listaServicios.add(L[i]['nombre']);
    }
    return listaServicios;
  }
  
}
