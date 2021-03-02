import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/modelos/servicio.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/data/my_database.dart';
import 'package:registro_login/screens/screens.dart';

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
  // MyDatabase _myDatabase = MyDatabase();

  List<Servicio>datosS = [];
  MyDatabase _myDatabase = MyDatabase();
  List _servicios = List();
  List<bool> _selectServicio = [];
  
  Future<void> getDatosServicios() async {
    Api api = Api();
    List auxServicio = await api.getServicios();
    setState(() {
      _servicios = auxServicio;
    });
  }

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');

    super.initState();
    // _loadData();
    getDatosServicios();
    // if(datosS.isEmpty)
    //   _getServiciosBoolNoGuardado(); //inicializa _selectServicio no guardado
    // else
      _getServiciosBoolGuardado(); //inicializa _selectServicio guardado
  }

  _loadData() async {
    List<Servicio> auxDatosE = await _myDatabase.notesCategory();
    print("traer servi: $auxDatosE");
    setState(() {
      datosS = auxDatosE;
    });
    print("traer datosS: $datosS");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: _getDrawServicio(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: RoundedButton(
                      flatButton: FlatButton(
                              onPressed: () async {
                                // List L = await _myDatabase.notesCategory();
                                // print(L[1].nombre);
                                _getServiciosSeleccionados();
                                // Navigator.of(context).pushNamed("RegistroHorarios",
                                //                                 arguments: ServiciosSeleccionados(
                                //                                   servicios: [L[0],L[1], L[2]]
                                //                                   ));
                                
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

  _getDrawServicio(){           
      return Container(
        height: 40,      
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _servicios == null ? 0: _servicios.length,
          itemBuilder: (BuildContext context, index) {
                // _selectServicio.add(false);
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: _drawServicios(_servicios, index)
            );
          },
        )
    );
  }


  // _getDrawServicio(){           
  //     return Container(
  //     height: 40,
  //     child: FutureBuilder<List>(
  //         future: _servicios,
  //         builder:
  //             (BuildContext context, AsyncSnapshot<List> snapshot) { 
  //           if (snapshot.hasData) {        
  //             return ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (BuildContext context, index) {
  //                 if (index < snapshot.data.length){
  //                     // _selectServicio.add(false);
  //                   return Padding(
  //                     padding: const EdgeInsets.only(left: 15.0),
  //                     child: _drawServicios(snapshot, index)
  //                   );
  //                 } return null;
  //               },
  //             );
  //           }else return Text("");
  //         }),
  //   );
  // }

  _drawServicios(List snapshot, i){
    return FilterChip(
      selected: _selectServicio[i],
      label: Text(
        snapshot[i]['nombre'],
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

  _getServiciosGuardado()async {
    List<String> L = List();
    List<String> listaServi = await _getListaServicios();
    for (var i = 0; i < listaServi.length; i++) {
      if(_selectServicio[i] == true) L.add(listaServi[i]);
    }
    return L;
  }


  _getServiciosBoolGuardado()async{
    List<String> L = List();
      // L.add('Plomeria');
      // L.add('Jardinería');
      // L.add('Electricista');
    List<Servicio> auxDatosE = await _myDatabase.notesCategory();
    for (var i = 0; i < auxDatosE.length; i++) {
      L.add(auxDatosE[i].nombre);  
    }
    print("Servi: $L");
    List<bool> listaBool = List();
    List<dynamic> listaServi = await _getListaServicios();
    int k = 0;
    for (var j = 0; j < listaServi.length; j++) {
      if(k < L.length){
        if(listaServi[j] == L[k]){
          listaBool.add(true);
          k++;
        }else
          listaBool.add(false);
      }else  listaBool.add(false);
    }
    setState(() {
      _selectServicio = listaBool;
    });
  }

  _getServiciosSeleccionados() async {
    List<String> L = List<String>();
    List<dynamic> listaServi = await _getListaServicios();
    for (var i = 0; i < listaServi.length; i++) {
      if(_selectServicio[i] == true)
        L.add(listaServi[i]);
    }
    
    for (var i = 0; i < L.length; i++) {
      _myDatabase.insert({"nombre": L[i]}, "categorias");
    }
  }

  _getServiciosBoolNoGuardado()async{

    List<bool> listaBool = List();
    List<dynamic> listaServi = await _getListaServicios();

    for (var j = 0; j < listaServi.length; j++) {
      listaBool.add(false);
    }
    setState(() {
      _selectServicio = listaBool;
    });
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
