import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:registro_login/pallete.dart';
import 'package:registro_login/widgets/widgets.dart';

import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:registro_login/data/my_database.dart';

class CreateNewAccount extends StatelessWidget {
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
        body: CreateNewAccountFul());
  }
}

class CreateNewAccountFul extends StatefulWidget {
  @override
  StateCreateAccount createState() => StateCreateAccount();
}

class StateCreateAccount extends State<CreateNewAccountFul> {
  List listaSexo = ["M", "F"];
  String _selectSexo;
  File image;
  MyDatabase _myDatabase = MyDatabase();
  final picker = ImagePicker();

  TextEditingController nombre;
  TextEditingController ci;
  TextEditingController telefono;
  TextEditingController direccion;

  @override
  void initState() {
    _myDatabase
        .initialize()
        .then((value) => '..................database intialize');

    super.initState();
    _selectSexo = listaSexo[0];

    nombre = new TextEditingController();
    telefono = new TextEditingController();
    direccion = new TextEditingController();
    ci = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
                          width: 100,
                          height: 100,
                          child: image == null
                              ? Center(child: Text("Imagen no seleccionada"))
                              : Image.file(image)),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
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
                Column(
                  children: [
                    TextFormField(
                        controller: ci,
                        decoration: buildInputDecoration(
                            Icons.business_center_rounded,
                            "Carnet de Identidad"),
                        validator: (String value) {
                          if (value.isEmpty) return "Escriba su CI PorFavor";
                          return null;
                        }),
                    TextFormField(
                        controller: nombre,
                        decoration: buildInputDecoration(
                            Icons.person, "Nombre y apellido"),
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Escriba su Nombre PorFavor";
                          return null;
                        }),
                    TextFormField(
                        controller: direccion,
                        decoration:
                            buildInputDecoration(Icons.home, "Direccion"),
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Escriba su Direccion PorFavor";
                          return null;
                        }),
                    TextFormField(
                        controller: telefono,
                        decoration:
                            buildInputDecoration(Icons.phone_sharp, "Telefono"),
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Escriba su Telefono PorFavor";
                          return null;
                        }),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text("Seleccione su sexo: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _selectComboBoxSexo(),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: kGreen,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          upLoadImage();
                        },
                        child: Text(
                          'Continuar',
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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

  Future upLoadImage() async {
    print('images/${Path.basename(image.path)}');
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(image.path)}');
    await ref.putFile(image).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        print(value);

        final Map<String, dynamic> map = {
          "nombre": nombre.text,
          "ci": ci.text,
          "direccion": direccion.text,
          "estado": "a", //activo
          "img_perfil": value,
          "telefono": telefono.text,
          "sexo": _selectSexo,
          "tipo": "t" //trabajador
        };

        _myDatabase.insert(map, 'datos_basicos');
      });
    });
    /*final uri = Uri.parse("http://192.168.56.1/registro_login/registro.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["nom"] = nombre.text;
    request.fields["apel"] = apellido.text;
    request.fields["telf"] = telefono.text;
    request.fields["dir"] = direccion.text;
    request.fields["nomUser"] = nombreUsuario.text;
    request.fields["contra"] = contraUsuario.text;



    var pic = await http.MultipartFile.fromPath("imagen", image.path);
    request.files.add(pic);
    var response = await request.send();

    if(response.statusCode == 200) print("Image upload");
    else print("Image not upload");*/

    setState(() {});
  }
}
