import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/screens/screens.dart';
import 'package:registro_login/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          title: Text(
            'Login',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: LoginFul());
  }
}

class LoginFul extends StatefulWidget {
  @override
  StateLogin createState() => StateLogin();
}

class StateLogin extends State<LoginFul> {
  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();

  TextEditingController nombre = new TextEditingController();
  TextEditingController correo = new TextEditingController();
  TextEditingController contrasena = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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
                        child: Image.asset("assets/logoAppServi.jpg")),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
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
                      padding: const EdgeInsets.only(bottom: 25.0),
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
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPassword'),
                      child: Text(
                        '¿Olvidaste tu Contraseña?',
                        style: kBodyText,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      flatButton: FlatButton(
                        onPressed: () {
                          if (formkey.currentState.validate()) {
                            formkey.currentState.save();
                            login();
                            // Navigator.of(context).pushNamed("CreateNewAccountFin");
                          }
                        },
                        child: Text(
                          'Iniciar sesión',
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'RegistroDatos'),
                      child: Container(
                        child: Text(
                          'Crear Nueva Cuenta',
                          style: kBodyText,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(width: 2, color: kWhite))),
                      ),
                    ),
                  ],
                ),
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

  void login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {'email': correo.text, 'password': contrasena.text};
    Api api = Api();
    var res = await api.postData(data, 'login');
    var body = json.decode(res.body);
    if (body['token']!=null ) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      print(body['token']);
      // localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Home()));
    }
    setState(() {
      _isLoading = false;
    });
  }
}
