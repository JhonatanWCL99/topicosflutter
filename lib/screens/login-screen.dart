import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
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
        body: Login());
  }
}

class Login extends StatefulWidget {
  @override
  StateLogin createState() => StateLogin();
}

class StateLogin extends State<Login> {
  TextEditingController nombre;
  TextEditingController correo;
  TextEditingController contrasena;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff5DBFA6),
            elevation: 0,
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: CircleAvatar(
                      radius: size.width * 0.30,
                      backgroundColor: Colors.grey[400].withOpacity(
                        0.4,
                      ),
                      child: Icon(
                        FontAwesomeIcons.userAlt,
                        color: kBlack,
                        size: size.width * 0.30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                      controller: nombre,
                      decoration: buildInputDecoration(Icons.person, "Nombre"),
                      validator: (String value) {
                        if (value.isEmpty) return "Escriba su Nombre PorFavor";
                        return null;
                      }),
                  TextFormField(
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
                  TextFormField(
                      controller: contrasena,
                      decoration: buildInputDecoration(
                          FontAwesomeIcons.lock, "Contraseña"),
                      validator: (String value) {
                        if (value.isEmpty)
                          return "Escriba su Contraseña PorFavor";
                        return null;
                      }),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                    child: Text(
                      '¿Olvidaste tu Contraseña?',
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    buttonName: 'Iniciar Sesion',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, 'CreateNewAccount'),
                    child: Container(
                      child: Text(
                        'Crear Nueva Cuenta',
                        style: kBodyText,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: kWhite))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}
