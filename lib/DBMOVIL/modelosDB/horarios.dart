
class HorariosModel{

  int id;
  String nombreServicios;
  String dias;
  String horario;

  HorariosModel({this.id, this.nombreServicios, this.dias, this.horario});

  Map<String, dynamic> toMap(){
    return {
      'id': this.id,
      'nombreServicios': this.nombreServicios,
      'dias': this.dias,
      'horario': this.horario
    };

  }
}