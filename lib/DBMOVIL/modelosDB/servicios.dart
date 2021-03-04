
class Servicios{
  int id;
  String nombreServi;
  int id_servicio;

  Servicios({this.id, this.nombreServi,this.id_servicio});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nombreServi':nombreServi,
      'id_servicio':id_servicio
    };
  }

    factory Servicios.fromMap(Map<String, dynamic> map) => Servicios(
      id: map["id"],
      nombreServi: map["nombre"],
      id_servicio:map["id_servicio"]
      );
}