import 'package:flutter/material.dart';
import 'package:registro_login/pallete.dart';

class RoundedButton extends StatelessWidget {
  final String opcion;
    final FlatButton flatButton;
  const RoundedButton({
    Key key,
    this.opcion,
    this.flatButton
  }) : super(key: key);

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
      child: flatButton
    );
  }
}
