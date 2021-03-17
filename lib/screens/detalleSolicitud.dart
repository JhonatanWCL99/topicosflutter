import 'package:flutter/material.dart';
import 'package:registro_login/widgets/widgets.dart';

import '../operaciones.dart';
import '../pallete.dart';

// class RecuperarDatos extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         //Para controlar el boton de retroceso
//         onWillPop: () async {
//           //Con esto se puede controlar el boton de retroceso pero hay un parpadeo cuando se retrocede
//           await Navigator.of(context)
//               .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
//           //Navigator.popAndPushNamed(context, "/");
//           return true;
//         },
//         child: Scaffold(body: DetalleSolicitud()));
//   }
// }

class DetalleSolicitud extends StatefulWidget {
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<DetalleSolicitud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:  AppBar(title: Text("Detalle"),),
          body: misDatos(context)
            // body: Column(children: <Widget>[
            //   RoundedButton(
            //     flatButton: FlatButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Aceptar',
            //         style: kBodyText.copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            //   RoundedButton(
            //     flatButton: FlatButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Rechazar',
            //         style: kBodyText.copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   )
            // ])
    );
  }

  misDatos(BuildContext context) {
    SolicitudParam arguments = ModalRoute.of(context).settings.arguments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Operacion.getIconDatos(
            Icon(Icons.note), "Descripcion: " + arguments.descripcion),
        Operacion.getIconDatos(
            Icon(Icons.location_on), "latitud: " + arguments.latitud),
        Operacion.getIconDatos(
            Icon(Icons.location_on), "longitud: " + arguments.longitud),
        Operacion.getIconDatos(
            Icon(Icons.data_usage), "Fecha: " + arguments.fecha),
      ],
    );
  }
}

class SolicitudParam {
  int id;
  String descripcion;
  String latitud;
  String longitud;
  String costo;
  String fecha;
  // String solicitudid;
  // String servicioid;

  SolicitudParam({
    this.id,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.costo,
    this.fecha,
    // this.solicitudid,
    // this.servicioid,
  });
}
