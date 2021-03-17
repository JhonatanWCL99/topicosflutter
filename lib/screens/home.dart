import 'package:flutter/material.dart';
import 'package:registro_login/screens/detalleSolicitud.dart';
// import 'package:registro_login/screens/detallesolicitud.dart';
import 'package:registro_login/widgets/rounded-button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api.dart';
import '../operaciones.dart';
import '../pallete.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var listaS;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Home',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: createItem());
  }

  @override
  void initState() {
    super.initState();
    refrescar();
  }

  Future<Null> refrescar() async {
    await new Future.delayed(new Duration(milliseconds: 1));
    Api api = Api();
    var res = await api.getSolicitudes();
    setState(() {
      listaS = res;
    });
    return null;
  }

  Widget createItem() {
    return RefreshIndicator(
      child: ListView.builder(
          itemCount: listaS == null ? 0 : listaS.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print("ListaS: $listaS");
                Navigator.of(context).pushNamed("detalleServicio",
                    arguments: SolicitudParam(
                        id: listaS[index]['id'],
                        descripcion: listaS[index]['descripcion'],
                        latitud: listaS[index]['latitud'],
                        longitud: listaS[index]['longitud'],
                        fecha: listaS[index]['fecha']));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      width: 320,
                      height: 130,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 40.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Operacion.textosEstilosDif(
                                      "Solicitud de Trabajo " +
                                          listaS[index]['id'].toString(),
                                      estilo: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Operacion.textosEstilosDif(
                                      "Fecha: " +
                                          listaS[index]['fecha'].toString(),
                                      estilo: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  RaisedButton(
                                    color: Color(0xff5DBFA6),
                                    textColor: Colors.black,
                                    onPressed: () async {
                                      var latitude = listaS[index]['latitud'];
                                      var longitude = listaS[index]['longitud'];

                                      var mapSchema =
                                          'geo:$latitude,$longitude';

                                      //String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                      print(mapSchema);
                                      if (await canLaunch(mapSchema)) {
                                        await launch(mapSchema);
                                      } else {
                                        throw 'Could not open the map.';
                                      }
                                    },
                                    child: Text('Ubicacion',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(20)),
                        color: Colors.cyan[100],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      onRefresh: refrescar,
    );
  }
}
