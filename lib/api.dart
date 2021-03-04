import 'dart:async';
import 'dart:convert';

import 'package:registro_login/modelos/servicio.dart';
import 'package:registro_login/modelos/Horario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'screens/screens.dart';
import 'screens/screens.dart';

class Api {
  var url = 'https://topicos-web.herokuapp.com/api/';

  // Future<List<Servicio>> getServicios() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.get('token') ?? 0;
  //   // print('RToken read: $value');
  //   var response = await http.get(url + 'servicios');
  //   // print('Response status: ${response.statusCode}');
  //   // print('Response body: ${response.body}');
  //   var jsonResponse = jsonDecode(response.body);
  //   List<Servicio> servicios = [];

  //   for (Map i in jsonResponse) {
  //     servicios.add(Servicio.fromMap(i));
  //   }
  //   return servicios;
  // }
  
    Future<List<dynamic>> getServicios() async {
      http.Response response = await http.get(url + 'servicios');

      if(response.statusCode == 200){
        print('petición correcta');

        final jsonData = jsonDecode(response.body);
        List<dynamic> mapDatos = jsonData;
        return mapDatos;
      }else{
        return null;
      }
    }
  
    // Future<List<Horario>> getHorarios() async {
    // final prefs = await SharedPreferences.getInstance();
    // final value = prefs.get('token') ?? 0;
    // print('RToken read: $value');
    // var response = await http.get(url + 'horarios');
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // var jsonResponse = jsonDecode(response.body);
    // List<Horario> horarios = [];

    // for (Map i in jsonResponse) {
    //   horarios.add(Horario.fromMap(i));
    // }
    // return horarios;
    // }

    Future<List<dynamic>> getHorarios() async {
      http.Response response = await http.get(url + 'horarios');

      if(response.statusCode == 200){
        print('petición correcta');
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> horarios = jsonResponse;
        return horarios;
      }else
      return null;
      
    }

}
