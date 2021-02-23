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

  Future<List<Servicio>> getServicios() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    print('RToken read: $value');
    var response = await http.get(url + 'servicios');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonResponse = jsonDecode(response.body);
    List<Servicio> servicios = [];

    for (Map i in jsonResponse) {
      servicios.add(Servicio.fromMap(i));
    }
    return servicios;
  }

    Future<List<Horario>> getHorarios() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    print('RToken read: $value');
    var response = await http.get(url + 'horarios');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonResponse = jsonDecode(response.body);
    List<Horario> horarios = [];

    for (Map i in jsonResponse) {
      horarios.add(Horario.fromMap(i));
    }
    return horarios;
    }

}
