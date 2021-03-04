import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/DBMOVIL/db/databaseDatos.dart';
import 'package:registro_login/DBMOVIL/modelosDB/empleado.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:registro_login/Validaciones/Validar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroDeDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff5DBFA6),
          elevation: 0,
          title: Text(
            'Registro',
            style: kBodyText,
          ),
          centerTitle: true,
        ),
        body: RegistroDeDatosFul());
  }
}

class RegistroDeDatosFul extends StatefulWidget {
  @override
  StateRegistroDeDatos createState() => StateRegistroDeDatos();
}

class StateRegistroDeDatos extends State<RegistroDeDatosFul> {
  
  List listaSexo = ["M", "F"];
  String _selectSexo;

  File image;
  final picker = ImagePicker();
  final formkey = GlobalKey<FormState>();
  List<Empleado>datosE = [];

  DatabaseDatos _myDatabase = DatabaseDatos();

  TextEditingController ci;
  TextEditingController nombre;
  TextEditingController direccion;
  TextEditingController telefono; 


  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');

    super.initState();

    nombre = new TextEditingController();
    telefono = new TextEditingController();
    direccion = new TextEditingController();
    ci = new TextEditingController();

    _loadData();
    _selectSexo = listaSexo[0];
    

  }

  _loadData() async {
    List<Empleado> auxDatosE = await _myDatabase.getListDatos();
    print("En el load: $auxDatosE");
    setState(() {
      datosE = auxDatosE;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("length: ${datosE.length}");
    if(datosE.isEmpty) return _formRegistro(ci, nombre, direccion, telefono);
    ci.text = datosE[0].ci;
    nombre.text = datosE[0].nombreYApellido;
    direccion.text = datosE[0].direccion;
    telefono.text = datosE[0].telefono;
    return _formRegistro(ci, nombre, direccion, telefono);
    
  }

  _formRegistro(TextEditingController ci, TextEditingController nombreYApellido,
                TextEditingController direccion, TextEditingController telefono){

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          choiceImage();
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                          width: 300,
                          height: 100,
                          child: image == null
                              ? Center(child: Text("Imagen no seleccionada"))
                              : Image.file(image)),
                    ),
                    Positioned(
                      top: size.height * 0.1,
                      left: size.width * 0.45,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  // height: size.width * 0.1,
                  height: 10,
                ),
                Form(
                 key: formkey,
                 child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                          controller: ci,
                          decoration: buildInputDecoration(
                              Icons.business_center_rounded,
                              "Carnet de Identidad"),
                            keyboardType: TextInputType.phone,
                            validator: (String value) {
                              if (value.isEmpty) return "Escriba su CI PorFavor";
                              if(!Validar.soloNumeros(ci.text))
                              return "Solo se permite números";
                              return null;
                            },
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                          controller: nombreYApellido,
                          decoration: buildInputDecoration(
                              Icons.person, "Nombre y apellido"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Nombre PorFavor";
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                          controller: direccion,
                          decoration:
                              buildInputDecoration(Icons.home, "Direccion"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Direccion PorFavor";
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                          controller: telefono,
                          decoration:
                              buildInputDecoration(Icons.phone_sharp, "Telefono"),
                          keyboardType: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Escriba su Telefono PorFavor";
                            if(!Validar.soloNumeros(telefono.text))
                              return "Solo se permite números";
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 55),
                          child: Text("Seleccione su sexo: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: _selectComboBoxSexo(),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                      RoundedButton(
                        flatButton: FlatButton(
                              onPressed: (){
                              upLoadImage(ci.text, nombreYApellido.text, direccion.text, telefono.text, _selectSexo);
                              },
                              child: Text(
                                'Continuar',
                                style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                              ),
                        ),
                    ),
                    Container(
                      height: 100,
                    )
                  ],
                ),
               )
              ],
            ),
          ),
        )
      ],
    ); 

  }

  _selectComboBoxSexo() {
    return new Container(
        child: new DropdownButton(
            value: _selectSexo,
            items: listaSexo.map((item) {
              return DropdownMenuItem(
                  child: Text(
                    item,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: item);
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectSexo = value;
              });
            }));
  }

  Future choiceImage() async {
    try {
      var pickedImage = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        image = File(pickedImage.path);
      });
    } catch (Exception) {
      print("Error");
    }
  }

  Future upLoadImage(ci,nombre,direccion,telefono,sexo) async {
    print('images/${Path.basename(image.path)}');
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(image.path)}');
    await ref.putFile(image).whenComplete(() async {
      await ref.getDownloadURL().then((value) async {
        print(value);
        if(formkey.currentState.validate()){

          formkey.currentState.save();
          final Map<String, dynamic> map = {
            "ci": ci,
            "nombreYApellido": nombre,
            "direccion": direccion,
            "estado": "a", //activo
            "imagePerfil": value,
            "telefono": telefono,
            "sexo": sexo,
            "tipo": "t" //trabajador
          };
          if(datosE.isEmpty)
            _myDatabase.insert(map, 'datos_basicos');
          else{
            _myDatabase.delete("datos_basicos", datosE[0]);
            _myDatabase.insert(map, 'datos_basicos');
          }
          //upLoadImage();
          Navigator.of(context).pushNamed("RegistroServicios");


        }
      });
    });
    setState(() {});
  }
}
