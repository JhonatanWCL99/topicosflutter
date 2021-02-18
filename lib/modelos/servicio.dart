class Servicio {
  final int id;
  final String nombre;
  final String descripcion;

  Servicio({this.id, this.nombre, this.descripcion});

  Map<String, dynamic> toMap() =>
      {'id': id, 'nombre': nombre, 'descripcion': descripcion};
  factory Servicio.fromMap(Map<String, dynamic> map) => Servicio(
      id: map["id"], nombre: map["nombre"], descripcion: map["descripcion"]);
}
