import 'package:flutter/material.dart';
import 'package:registro_login/pallete.dart';

class RoundedButton extends StatelessWidget {
  final String opcion;
  const RoundedButton({
    Key key,
    @required this.buttonName,
    this.opcion,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kGreen,
      ),
      child: FlatButton(
        onPressed: () {
          switch (opcion) {
            case "fin":
              Navigator.of(context).pushNamed("CreateNewAccountFin");
              break;
          }
        },
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
