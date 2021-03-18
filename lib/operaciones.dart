import 'package:flutter/material.dart';

class Operacion {
  static textosEstilosDif(String valor, {TextStyle estilo}) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[TextSpan(text: valor, style: estilo)],
      ),
    );
  }

  static getIconDatos(Icon icono, String descri) {
    return Container(
      height: 60,
      child: Card(
          child: Row(
        children: [
          icono,
          Text("  "),
          Text(descri),
        ],
      )),
    );
  }
}
