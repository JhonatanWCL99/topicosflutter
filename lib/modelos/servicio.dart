class Servicio {
  final int id;
  final String nombre;

  Servicio({this.id, this.nombre});

  Map<String, dynamic> toMap() =>
      {'id': id,
      'nombre': nombre
      };
  
}
