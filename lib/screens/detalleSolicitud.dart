import 'package:flutter/material.dart';
import 'package:registro_login/widgets/widgets.dart';

import '../operaciones.dart';
import '../pallete.dart';

class DetalleSolicitud extends StatefulWidget {
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<DetalleSolicitud> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, index) => misDatos(context),
                  childCount: 1),
            ),
            Column(children: <Widget>[
              RoundedButton(
                flatButton: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Aceptar',
                    style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              RoundedButton(
                flatButton: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Rechazar',
                    style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  misDatos(BuildContext context) {
    SolicitudParam arguments = ModalRoute.of(context).settings.arguments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Operacion.getIconDatos(
              Icon(Icons.note), "Descripcion: " + arguments.descripcion),
        ),
        Operacion.getIconDatos(
            Icon(Icons.location_on), "Ubicacion: " + arguments.ubicacion),
        Operacion.getIconDatos(Icon(Icons.money), "Costo: " + arguments.costo),
        Operacion.getIconDatos(
            Icon(Icons.data_usage), "Fecha: " + arguments.fecha),
      ],
    );
  }
}

class SolicitudParam {
  String descripcion;
  String ubicacion;
  String costo;
  String fecha;
  String solicitudid;
  String servicioid;

  SolicitudParam({
    this.descripcion,
    this.ubicacion,
    this.costo,
    this.fecha,
    this.solicitudid,
    this.servicioid,
  });
}
