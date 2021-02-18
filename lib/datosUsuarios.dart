import 'package:flutter/material.dart';

class DatosUsuarios extends StatefulWidget {
  DatosUsuarios({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DatosUsuarios> {

  @override
  Widget build(BuildContext context) {
      MisDatos arguments = ModalRoute.of(context).settings.arguments;
     return Scaffold(
       appBar: AppBar(title: Text("MIS DATOS")),
       
       body:  Padding(
         padding: const EdgeInsets.all(20.0),
         child: Center(
           child: Column(
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Nombre: " + arguments.nomb),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Apellido: " + arguments.apel),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Teléfono: " + arguments.telf),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Dirección: " + arguments.dire),
                          ),

                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network("http://192.168.56.1/registro_login/imagenes/${arguments.fot}")
                          ),
                      
                        ],
                   ),
         ),
       ),
             
      );
   }

}

class MisDatos{
  String nomb;
  String apel;
  String telf;
  String dire;
  String fot;

  MisDatos({this.nomb, this.apel, this.telf, this.dire, this.fot});
}
