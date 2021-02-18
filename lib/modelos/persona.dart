class Persona {
  final int id;
  final String nombre;
  final int ci;
  final String direccion;
  final String estado;
  final String img_perfil;
  final int telefono;
  final String tipo;
  final String sexo;

  Persona(
      {this.id,
      this.nombre,
      this.ci,
      this.direccion,
      this.estado,
      this.img_perfil,
      this.telefono,
      this.tipo,
      this.sexo});

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'ci': ci,
        'direccion': direccion,
        'estado': estado,
        'img_perfil': img_perfil,
        "telefono": telefono,
        'tipo': tipo,
        "sexo": sexo
      };
  factory Persona.fromMap(Map<String, dynamic> map) => Persona(
      id: map["id"],
      nombre: map["nombre"],
      ci: map["ci"],
      direccion: map["direccion"],
      estado: map["estado"],
      img_perfil: map["img_perfil"],
      telefono: map["telefono"],
      tipo: map["tipo"],
      sexo: map["sexo"]);
}
