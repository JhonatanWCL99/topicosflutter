import 'package:flutter/material.dart';
import 'package:registro_login/screens/detallesolicitud.dart';
import '../api.dart';
import '../operaciones.dart';
import '../pallete.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var listaS;

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
                Navigator.of(context).pushNamed("/DetalleSolicitud",
                    arguments: SolicitudParam(
                        descripcion: listaS[index]['descripcion'],
                        ubicacion: listaS[index]['ubicacion'],
                        costo: listaS[index]['costo'],
                        fecha: listaS[index]['fecha']));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      width: 320,
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 18),
                                child: Image.asset("assets/logoAppServi.jpg",
                                    width: 100, height: 80)),
                            Positioned(
                              left: 110,
                              bottom: 92,
                              child: Operacion.textosEstilosDif(
                                  "Descripcion: " +
                                      listaS[index]['descripcion'],
                                  estilo: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Positioned(
                              left: 120,
                              top: 30,
                              child: Operacion.textosEstilosDif(
                                  "Dirección: " + listaS[index]['ubicacion']),
                            ),
                            Positioned(
                              left: 120,
                              top: 60,
                              child: Operacion.textosEstilosDif(
                                  "Fecha: " + listaS[index]['fecha']),
                            )
                          ])
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(20)),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      onRefresh: refrescar,
    );
  }
}
