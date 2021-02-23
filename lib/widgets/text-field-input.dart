import 'package:flutter/material.dart';
import 'package:registro_login/pallete.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.mensaje,
    this.mensajeCorreo,
    @required this.controlador,
    @required this.validator,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final String mensaje;
  final String mensajeCorreo;
  final IconData icon;
  final TextEditingController controlador;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.8,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: controlador,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: kWhite,
                ),
              ),
              hintText: hint,
              hintStyle: kBodyText,
            ),
            validator: (value){
              if(value.isEmpty)
                return mensaje;
              if(!value.endsWith('@gmail.com'))
                return mensajeCorreo;
            },
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}
