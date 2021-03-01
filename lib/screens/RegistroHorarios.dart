import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:registro_login/pallete.dart';

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

 
  List<String> dias = ["Lun", "Mar", "Mie", "Jue", "Vie"];

  List _horarios = List();
  List<dynamic>  todosServicios = List<dynamic>();

  List<String> serviciosSeleccionados = ['Plomeria', 'Jardin']; 
  

  Future<void> getDatosHorarios() async {
    Api api = Api();
    List auxHorario = await api.getHorarios();
    setState(() {
      _horarios = auxHorario;
    });
  }

  @override
  void initState() {
    super.initState();
    
    getDatosHorarios();
    // _getTodosServiciosBoolNoGuardados();
    _getTodosServiciosBoolGuardados();
  }

  @override
  Widget build(BuildContext context) {
    ServiciosSeleccionados arguments = ModalRoute.of(context).settings.arguments;
    List servi = ['hola', 'mundo'];
    return Scaffold(
      body: 
      Column(
        children: [
        Expanded(
          child: ListView.builder(
               itemBuilder: (BuildContext context, i){
                 if(i < servi.length) {
                   return Card( 
                     color: Colors.teal[100],
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     margin: EdgeInsets.all(10),
                     elevation: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(servi[i], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: _drawDias(context, i),
                            ), 
                            Padding(
                              padding: const EdgeInsets.only(top: 30, bottom: 30),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      children: [
                                        Text("Hora inicial", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        _drawHorarios(context, i, 0), //Draw horaIni
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80),
                                    child: Column(
                                      children: [
                                        Text("Hora final", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                        _drawHorarios(context, i, 1)  //Draw horaFin
                                      ],
                                    ),
                                  )
                                  
                                ],
                              ),
                            )                           
                            //Draw horaFin
                            
                          ],
                        ),
                      )
                   );
                 }
                 return null;
               },
             ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: RoundedButton(
            flatButton: FlatButton(
                  onPressed: () {  
                    // print(await _getHorariosGuardado());
                    // print(rh.todosServicios[0][0]['Lun'].horaIni);
                    // _setDia();
                    // Navigator.of(context).pushNamed("RegistroAutentificacion");
                   _getTodosServiciosBoolGuardados();
                    // print(todosServicios);
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


  _drawDias(BuildContext context, int posServi){
      return Container(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, i) {
            if(i < dias.length)return Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: _getDias(i, posServi)
                                      );
            return null;
          },
        ),
      );
  }

  _getDias(i, int posServi){
      return ChoiceChip(
        selected: todosServicios[posServi][0][i],
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
            todosServicios[posServi][0][i] = selected;
          });
        },
    );
  }  

  _drawHorarios(BuildContext context, posServi, horaPartida){
    int lenHoras = todosServicios[posServi][1][0].length;
      return Container(
          height: 50,
          width: 100,      
          child: ListView.builder(
            itemCount: _horarios == null ? 0: _horarios.length,
            itemBuilder: (BuildContext context, index) {
                  return _getHoras(posServi, index, horaPartida);
            },
          )
      );
  }

  _getHoras(posServi, posBool, horaPartida){
    if(horaPartida == 0) return _getHorasIni(posServi, posBool);
    return _getHorasFin(posServi, posBool);
    
  }

  _getHorasIni(posServi, posBool){
    return ChoiceChip(
        selected: todosServicios[posServi][1][0][posBool],
        label: Text(
          _horarios[posBool]['hora'],
          style: TextStyle(color: Colors.white),
        ),
        // avatar: FlutterLogo(),
        elevation: 10,
        pressElevation: 5,  
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          if(seleccionado(todosServicios[posServi][0])){
              setState(() {
                  int posSel = posSeleccionado(todosServicios[posServi][1][0]);
                  todosServicios[posServi][1][0][posBool] = selected;
                  if(posBool != posSel){
                    if(posSel != 1000)
                      todosServicios[posServi][1][0][posSel] = false;
                  }
              });
          }
        },
    );

  }

  _getHorasFin(posServi, posBool){
    return ChoiceChip(
        selected: todosServicios[posServi][1][1][posBool],
        label: Text(
         _horarios[posBool]['hora'],
          style: TextStyle(color: Colors.white),
        ),
        // avatar: FlutterLogo(),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          if(seleccionado(todosServicios[posServi][1][0])){
              setState(() {
                int posSel = posSeleccionado(todosServicios[posServi][1][1]);
                  todosServicios[posServi][1][1][posBool] = selected;
                  if(posBool != posSel){
                    if(posSel != 1000)
                      todosServicios[posServi][1][1][posSel] = false;
                  }
              });
          }
        },
    );

  }

  bool seleccionado(lisHoraBool){
    for (var i = 0; i < lisHoraBool.length; i++) {
      if(lisHoraBool[i] == true) return true;
    }
    return false;
  }

  posSeleccionado(horas){
    int c = 1000;
    for (var i = 0; i < horas.length; i++) {
      if(horas[i] == true){ c = i; break; }
    }
    return c;
  }


  _asignarSelectHorasBool() async {
    List<dynamic> auxSelectHorasIniYFin = List<dynamic>();
    List<dynamic> listaHorari = await _getListaHorarios();

    for (var i = 0; i < 2; i++) {
        List<bool> auxSelectHoras = List<bool>();
      for (var j = 0; j < listaHorari.length; j++) {
        auxSelectHoras.add(false);    
      }
      auxSelectHorasIniYFin.add(auxSelectHoras);
    }
    return auxSelectHorasIniYFin;
  }

  _getTodosServiciosBoolNoGuardados() async {
    List<bool> selectDias = [false, false, false, false, false];
    List<dynamic> selectHorasIniYFin = await _asignarSelectHorasBool();
    List<dynamic> auxTodosServicios = List<dynamic>();

    for (var i = 0; i < serviciosSeleccionados.length; i++) { //Agregara los valores booleanos dependiendo de la cantidad de servicios seleccionados
      List<dynamic> diaHoraBool = List<dynamic>();// = [selectDias, selectHorasIniYFin];
      List<bool> diaBool = List<bool>();
      List<dynamic> horaBool = List<dynamic>();
      List<bool> horaIniBool = List<bool>();
      List<bool> horaFinBool = List<bool>();

      diaBool.addAll(selectDias);
      diaHoraBool.add(diaBool); //Agrega los días booleanos

      horaIniBool.addAll(selectHorasIniYFin[0]);
      horaBool.add(horaIniBool);

      horaFinBool.addAll(selectHorasIniYFin[1]);
      horaBool.add(horaFinBool);

      diaHoraBool.add(horaBool); //Agrega las horas ini y fin booleanos

      auxTodosServicios.add(diaHoraBool);  //Agrega los días y las horas booleanos
    }
    setState(() {
      todosServicios = auxTodosServicios;
    });
  }

  _getTodosServiciosBoolGuardados() async {
    
    List<String> servicios = ['Plomeria', 'Jardineria'];
    List<String> dias = ["Lun-Mar", "Jue-Vie"];
    List<dynamic> horarios = [["07:00:00", "09:00:00"],["08:00:00", "10:00:00"]];

    List<dynamic> auxTodoServicios = List<dynamic>();


    List totalHorarios = await _getListaHorarios();

    for (var i = 0; i < servicios.length; i++) {
      List<bool> auxDias = List<bool>();
      List<dynamic> auxHoras = List<dynamic>();
      List<dynamic> auxTodoServiciosSub = List<dynamic>();
      List auxDia = strToList(dias[i]);
      int k = 0;
      for (var j = 0; j < this.dias.length; j++) {
        if(k < auxDia.length){
          if(auxDia[k] == this.dias[j]){
            auxDias.add(true);
            k++;
          }else auxDias.add(false);
        }else auxDias.add(false);
      }
      auxTodoServiciosSub.add(auxDias);

      List auxHora = horarios[i];
      for (var j1 = 0; j1 < 2; j1++) {
          List<bool> horasIF = List<bool>();
          for (var k1 = 0; k1 < totalHorarios.length; k1++) {
            if(auxHora[j1] == totalHorarios[k1])
              horasIF.add(true);
            else
              horasIF.add(false);
          }
          auxHoras.add(horasIF);
      }
      auxTodoServiciosSub.add(auxHoras);
      auxTodoServicios.add(auxTodoServiciosSub);
      
    }
    setState(() {
      todosServicios = auxTodoServicios;
    });

  }

  strToList(String s){
    String cad = "";
    List<String> L = List<String>();
    for(int i = 0; i < s.length; i++){
      if(s.substring(i, i+1) == '-') { L.add(cad); cad = ""; } 
      else cad = cad + s.substring(i, i+1);
    }
    L.add(cad);
    return L;
  }


  _getListaHorarios() async{
    List<String> listaServicios = List();
    Api api = Api();
    List L = await api.getHorarios();
    for(var i = 0; i < L.length; i++){
      listaServicios.add(L[i]['hora']);
    }
    return listaServicios;
  }


}  

class ServiciosSeleccionados{
     List<String> servicios;
    
    ServiciosSeleccionados({this.servicios});
}