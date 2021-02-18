import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

class CreateNewAccountFin extends StatelessWidget {
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
        body: CreateNewAccountFul());
  }
}

class CreateNewAccountFul extends StatefulWidget {
  @override
  StateCreateAccount createState() => StateCreateAccount();
}

class StateCreateAccount extends State<CreateNewAccountFul> {
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
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400].withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.userCircle,
                              color: kWhite,
                              size: size.width * 0.20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
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
                    TextInputField(
                      icon: FontAwesomeIcons.pencilAlt,
                      hint: 'Nombre de usuario',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text("Ingrese su correo electrónico:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.pencilAlt,
                      hint: 'Correo',
                      inputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Text("Ingrese su contraseña:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.pencilAlt,
                      hint: 'Contraseña',
                      inputAction: TextInputAction.done,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 88.0),
                      child: Text("Confirme su contraseña:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.pencilAlt,
                      hint: 'Contraseña',
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(buttonName: 'Finalizar registro'),
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
