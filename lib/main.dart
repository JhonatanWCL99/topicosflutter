import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" as firebase_core;
import 'package:registro_login/notificacion.dart';
import 'package:registro_login/screens/RegistroDeDatos.dart';
import 'package:registro_login/screens/RegistroAutentificacion.dart';
import 'package:registro_login/screens/forgot-password.dart';
import 'package:registro_login/screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/RegistroMapas.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
   // var token = getToken();
    // if (token == null) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        '/': (context) => Login(),
        'ForgotPassword': (context) => ForgotPassword(),
        'RegistroDatos': (context) => RegistroDeDatos(),
        'RegistroServicios': (context) => RegistroServicios(),
        'RegistroHorarios': (context) => RegistroHorarios(),
        'RegistroMapas': (context) => RegistroMapas(),
        'RegistroAutentificacion': (context) => RegistroAutentificacion()
      },
    );
    //} else {
    // return Home();
    //}
  }
}
