import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'datosUsuarios.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Index> {

  TextEditingController nombreUsuario;
  TextEditingController contraUsuario;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("LOGIN")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: nombreUsuario,
                  decoration: InputDecoration(
                    labelText: "Nombre de usuario"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),

                TextFormField(
                  controller: contraUsuario,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña"
                  ),
                  validator: (value){ if(value.isEmpty) return "Campo vacio"; }
                ),
                
                RaisedButton(
                  child: Text("Ingresar", style: TextStyle(color: Colors.black),),
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                  onPressed: ()=> comprobarLogin(context),
                ),

                RaisedButton(
                  child: Text("Registrarse", style: TextStyle(color: Colors.black)),
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onPressed: ()=> Navigator.of(context).pushNamed("/registrarse"),
                )

              ],
            )
          )
        ),
      ),
    );
  }

  void _alertDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Mensaje"),
          content: Text("Nombre de usuario o contraseña incorrecta"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        );
      }, 
    );
  }

    Future comprobarLogin(BuildContext context) async {
      final response = await http.post("http://192.168.56.1/registro_login/compruebaLogin.php", body: {
        "nomUser": nombreUsuario.text,
        "contra": contraUsuario.text,
      });

      List respuesta = json.decode(response.body);
      if(respuesta[0]["verificar"] == true){
        Navigator.of(context).pushNamed("/datoUsuario", arguments: MisDatos(nomb: respuesta[0]["nombre"], apel: respuesta[0]["apellido"], 
                                                                    telf: respuesta[0]["telefono"], dire: respuesta[0]["direccion"], 
                                                                    fot: respuesta[0]["foto"]));
      }else
        _alertDialog(context);
    }

  @override
  void initState() {
    super.initState();
    nombreUsuario = new TextEditingController();
    contraUsuario = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nombreUsuario.dispose();
    contraUsuario.dispose();
  }
}
