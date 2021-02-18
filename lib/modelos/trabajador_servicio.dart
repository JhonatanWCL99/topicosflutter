class TrabajadorServicio {
  final int id;
  final String fecha;
  final String dias;
  final String hora_inicio;
  final String hora_fin;
  final int trabajador_id;
  final int servicio_id;

  TrabajadorServicio(
      {this.id,
      this.fecha,
      this.dias,
      this.hora_inicio,
      this.hora_fin,
      this.trabajador_id,
      this.servicio_id});

  Map<String, dynamic> toMap() => {
        'id': id,
        'fecha': fecha,
        'dias': dias,
        'hora_inicio': hora_inicio,
        'hora_fin': hora_fin,
        'trabajador_id': trabajador_id,
        'servicio_id': servicio_id
      };

  factory TrabajadorServicio.fromMap(Map<String, dynamic> map) =>
      TrabajadorServicio(
          id: map["id"],
          fecha: map["fecha"],
          dias: map["dias"],
          hora_inicio: map["hora_inicio"],
          hora_fin: map["hora_fin"],
          trabajador_id: map["trabajador_id"],
          servicio_id: map["servicio_id"]);
}
