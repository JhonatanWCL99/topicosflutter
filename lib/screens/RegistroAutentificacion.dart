import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

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
  TextEditingController nombreUsuario;
  TextEditingController correo;
  TextEditingController contrasena;
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Text("Ingrese su nombre de usuario:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                          controller: nombreUsuario,
                          decoration:
                              buildInputDecoration(Icons.person, "Nombre"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Nombre PorFavor";
                            return null;
                          }),
                    ),
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
                            return 'Please a Enter';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Escriba su Correo PorFavor';
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
                          decoration: buildInputDecoration(
                              FontAwesomeIcons.lock, "Contraseña"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Contraseña PorFavor";
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
                          controller: contrasena,
                          decoration: buildInputDecoration(
                              FontAwesomeIcons.lock, "Contraseña"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Contraseña PorFavor";
                            return null;
                          }),
                    ),
                    RoundedButton(
                        flatButton: FlatButton(
                              onPressed: (){  
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
