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
  ScrollController _scrollController = ScrollController();

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
                Navigator.of(context).pushNamed("detalleServicio",
                    arguments: SolicitudParam(
                        id: listaS[index]['id'],
                        descripcion: listaS[index]['descripcion'],
                        latitud: listaS[index]['latitud'],
                        longitud: listaS[index]['longitud'],
                        fecha: listaS[index]['fecha'],
                        estado: listaS[index]['estado'],
                        solicitudid: listaS[index]['solicitud_id'].toString(),
                        servicioid: listaS[index]['servicio_id'].toString()));
              },
              child: Card(
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                margin: EdgeInsets.only(
                    top: 10, left: 20.0, right: 25, bottom: 0.10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 220,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Operacion.textosEstilosDif(
                                        "Solicitud de Trabajo " +
                                            listaS[index]['id'].toString(),
                                        estilo: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 7.5,
                                    ),
                                    Operacion.textosEstilosDif(
                                        "Fecha: " +
                                            listaS[index]['fecha'].toString(),
                                        estilo: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 7.5,
                                    ),
                                    obtenerBotonEstado(
                                        obtenerEstado(listaS[index]['estado']))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      onRefresh: refrescar,
    );
  }

  Container obtenerBotonEstado(String estado) {
    switch (estado) {
      case "aceptado":
        return Container(
          height: 25,
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Text("Aprobado"),
            onPressed: () {},
          ),
        );
      case "rechazado":
        return Container(
          height: 25,
          child: RaisedButton(
            color: Colors.redAccent,
            child: Text("Rechazado"),
            onPressed: () {},
          ),
        );
      case "pendiente":
        return Container(
          height: 25,
          child: RaisedButton(
            color: Colors.orangeAccent,
            child: Text("Pendiente"),
            onPressed: () {},
          ),
        );
        break;
      default:
        return Container(
          height: 25,
          child: RaisedButton(
            color: Colors.black,
            child: Text(""),
            onPressed: () {},
          ),
        );
    }
  }

  String obtenerEstado(String argumento) {
    argumento = argumento.trim();
    switch (argumento) {
      case "p":
        return "pendiente";
        break;
      case "a":
        return "aceptado";
        break;
      case "r":
        return "rechazado";
        break;
      default:
        return "  ";
    }
  }
}
