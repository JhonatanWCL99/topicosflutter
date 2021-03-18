import 'package:flutter/material.dart';
import 'package:registro_login/api.dart';
import 'package:registro_login/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../operaciones.dart';
import '../pallete.dart';

class DetalleSolicitud extends StatefulWidget {
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<DetalleSolicitud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Detalle de Solicitud',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: misDatos(context));
  }

  misDatos(BuildContext context) {
    SolicitudParam arguments = ModalRoute.of(context).settings.arguments;
    Api api = new Api();
    TextEditingController costoController = new TextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Descripcion :",
            style: TextStyle(fontSize: 20, color: Color(0xff5DBFA6)),
          ),
          Center(
            child:
                Operacion.getIconDatos(Icon(Icons.note), arguments.descripcion),
          ),
          Text(
            "Ubicacion :",
            style: TextStyle(fontSize: 20, color: Color(0xff5DBFA6)),
          ),
          Center(
            child: RaisedButton(
              color: Colors.black12,
              textColor: Colors.black,
              onPressed: () async {
                var latitude = arguments.latitud;
                var longitude = arguments.longitud;

                var mapSchema = 'geo:$latitude,$longitude';
                if (await canLaunch(mapSchema)) {
                  await launch(mapSchema);
                } else {
                  throw 'Could not open the map.';
                }
              },
              child: Text('Ubicacion',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Text(
            "Fecha :",
            style: TextStyle(fontSize: 20, color: Color(0xff5DBFA6)),
          ),
          Center(
            child:
                Operacion.getIconDatos(Icon(Icons.date_range), arguments.fecha),
          ),
          Text(
            "Estado :",
            style: TextStyle(fontSize: 20, color: Color(0xff5DBFA6)),
          ),
          Operacion.getIconDatos(
              Icon(Icons.note), obtenerEstado(arguments.estado.trim())),
          /*  Text(
            "Ingrese el Costo :",
            style: TextStyle(fontSize: 20, color: Color(0xff5DBFA6)),
          ),
          SingleChildScrollView(
            child: TextFormField(
              controller: costoController,
            ),
          ), */
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: RaisedButton(
                  color: Color(0xff5DBFA6),
                  textColor: Colors.black,
                  onPressed: () async {
                    crearDialogoAceptar(context);
                  },
                  child: Text('Aceptar',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Color(0xff5DBFA6),
                textColor: Colors.black,
                onPressed: () async {
                  await api.responderSolicitud(
                      arguments.id, arguments.solicitudid, 0, "r");
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("La solicitud ha sido rechazada"),
                        );
                      });
                },
                child: Text('Rechazar',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ])
        ],
      ),
    );
  }
}

crearDialogoAceptar(BuildContext context) {
  SolicitudParam arguments = ModalRoute.of(context).settings.arguments;
  Api api = new Api();
  TextEditingController costoController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Ingrese el Costo"),
            content: TextField(
              controller: costoController,
            ),
            actions: <Widget>[
              RaisedButton(
                elevation: 5.0,
                child: Text("Enviar"),
                onPressed: () async {
                  await api.responderSolicitud(arguments.id,
                      arguments.solicitudid, costoController.text, "a");
                },
              ),
            ]);
      });
}

String obtenerEstado(String argumento) {
  switch (argumento) {
    case "p":
      return "Pendiente";
      break;
    case "a":
      return "Aceptado";
      break;
    case "r":
      return "Rechazado";
      break;
    default:
      return "  ";
  }
}

class SolicitudParam {
  int id;
  String descripcion;
  String latitud;
  String longitud;
  String costo;
  String fecha;
  String estado;
  String solicitudid;
  String servicioid;

  SolicitudParam({
    this.id,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.costo,
    this.fecha,
    this.estado,
    this.solicitudid,
    this.servicioid,
  });
}
