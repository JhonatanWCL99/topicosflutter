import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/DBMOVIL/db/dataBaseHorarios.dart';
import 'package:registro_login/DBMOVIL/db/databaseDatos.dart';
import 'package:registro_login/DBMOVIL/db/databaseServicios.dart';
import 'package:registro_login/DBMOVIL/modelosDB/empleado.dart';
import 'package:registro_login/DBMOVIL/modelosDB/horarios.dart';
import 'package:registro_login/DBMOVIL/modelosDB/servicios.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

import '../api.dart';

class RegistroAutentificacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Registro',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: RegistroAutentificacionFul());
  }
}

class RegistroAutentificacionFul extends StatefulWidget {
  @override
  StateRegistroAutentificacion createState() => StateRegistroAutentificacion();
}

class StateRegistroAutentificacion extends State<RegistroAutentificacionFul> {
  TextEditingController nombreUsuario= TextEditingController();
  TextEditingController correo= TextEditingController();
  TextEditingController contrasena= TextEditingController();
  TextEditingController confcontrasena= TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                SizedBox(
                  // height: size.width * 0.1,
                  height: 10,
                ),
                Form(
                  key: formkey,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 40.0),
                    //   child: Text("Ingrese su nombre de usuario:",
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.bold)),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 15),
                    //   child: TextFormField(
                    //       controller: nombreUsuario,
                    //       decoration:
                    //           buildInputDecoration(Icons.person, "Nombre"),
                    //       validator: (String value) {
                    //         if (value.isEmpty)
                    //           return "Escriba su Nombre PorFavor";
                    //         return null;
                    //       }),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text("Ingrese su correo electrónico:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: correo,
                        decoration: buildInputDecoration(Icons.email, "Correo"),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Campo vacío';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Correo no válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Text("Ingrese su contraseña:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                          controller: contrasena,
                          obscureText: true,
                          decoration: buildInputDecoration(
                              FontAwesomeIcons.lock, "Contraseña"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Campo vacío";
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 88.0),
                      child: Text("Confirme su contraseña:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                          controller: confcontrasena,
                          obscureText: true,
                          decoration: buildInputDecoration(
                              FontAwesomeIcons.lock, "Contraseña"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Campo vacío";
                            if(contrasena.text != confcontrasena.text)
                              return "Las contraseñas no coinciden";
                            return null;
                          }),
                    ),
                    RoundedButton(
                        flatButton: FlatButton(
                              onPressed: () async { 
                                if (formkey.currentState.validate()) {
                                  // await _subirDatos();
                                  // await _eliminarDatosRegistros();
                                  _showSnackbar(context);
                                }
                              },
                              child: Text(
                                'Finalizar',
                                style: kBodyText.copyWith(fontWeight: FontWeight.bold),

                              ),
                        ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // RoundedButton(buttonName: 'Finalizar registro'),
                  ],
                )
               )
              ],
            ),
          ),
        )
      ],
    );
  }

 _showSnackbar(BuildContext context){
    SnackBar snackbar= SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Registro satisfactorio",
                        style: TextStyle(fontSize: 18,
                        color: Colors.black
                        )
           ),
        ],
      ),
      backgroundColor: Color(0xff5DBFA6) 
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  _subirDatos() async{
    Api api = Api();
    DatabaseDatos databaseDatos = DatabaseDatos();
    List<Empleado> auxDatosE = await databaseDatos.getListDatos();
    var datos=auxDatosE[0];

    DatabaseServicios databaseServicios = DatabaseServicios();
    List<Servicios> auxDatosS = await databaseServicios.getListServicios();

    DatabaseHorarios databaseHorarios = DatabaseHorarios();
    List<HorariosModel> auxDatosH = await databaseHorarios.getListHorarios();

    List<Map<String, dynamic>> horarios=List<Map<String, dynamic>>();
    for (var i = 0; i < auxDatosH.length; i++) {
      var horario=auxDatosH[i];
      var horas=horario.horario.split("-");
      horarios.add({
        "dias": horario.dias,
        "hora_inicio":horas[0],
        "hora_fin": horas[1],
        "servicio_id": auxDatosS[i].id_servicio
      });

    }



    Map<String, dynamic> map={
      "nombre": datos.nombreYApellido,
      "email":correo.text,
      "password":contrasena.text,
      "ci": datos.ci,
      "img_perfil": datos.imagePerfil,
      "direccion": datos.direccion,
      "telefono": datos.telefono,
      "sexo": datos.sexo,
      "tipo": "T",
      "servicio_trabajador":horarios,
    };
    api.registro(map);
    _eliminarDatosRegistros();
  }

    _eliminarDatosRegistros() async {
    DatabaseDatos databaseDatos = DatabaseDatos(); 
    List<Empleado> auxDatosE = await databaseDatos.getListDatos();
    databaseDatos.delete('datos_basicos', auxDatosE[0]);

    DatabaseServicios databaseServicios = DatabaseServicios();
    List<Servicios> auxDatosS = await databaseServicios.getListServicios();
    for (var i = 0; i < auxDatosS.length; i++) {
      databaseServicios.delete('servicios', auxDatosS[i]);
    }

    DatabaseHorarios databaseHorarios = DatabaseHorarios();
    List<HorariosModel> auxDatosH = await databaseHorarios.getListHorarios();
    for (var i = 0; i < auxDatosH.length; i++) {
      databaseHorarios.delete('horarios', auxDatosH[i]);
    }
  }
  
}
