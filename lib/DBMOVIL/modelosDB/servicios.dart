
class Servicios{
  int id;
  String nombreServi;

  Servicios({this.id, this.nombreServi});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nombreServi':nombreServi
    };
  }

    factory Servicios.fromMap(Map<String, dynamic> map) => Servicios(
      id: map["id"],
      nombreServi: map["nombre"]
      );
}