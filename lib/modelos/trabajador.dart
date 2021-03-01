// class Trabajador {
//   final int persona_id;
//   final bool habilitado;

//   Trabajador({this.persona_id, this.habilitado});

//   Map<String, dynamic> toMap() =>
//       {'persona_id': persona_id, 'habilitado': habilitado};
//   factory Trabajador.fromMap(Map<String, dynamic> map) =>
//       Trabajador(persona_id: map["persona_id"], habilitado: map["habilitado"]);
// }

class Empleado{
  int id;
  String ci;
  String nombreYApellido;
  String direccion;
  String estado;
  String imagePerfil;
  String telefono;
  String sexo;
  String tipo;

  Empleado ({
          this.id, 
          this.ci, 
          this.nombreYApellido,
          this.direccion,
          this.estado,
          this.imagePerfil,
          this.telefono,
          this.sexo,
          this.tipo
          });

  Empleado.empty();
  
  Map<String, dynamic> toMap(){
    return {'id': id,
            'ci': ci,
            'nombreYApellido': nombreYApellido,
            'direccion': direccion,
            'estado': 'activo',
            'imagePerfil': imagePerfil,
            'telefono': telefono,
            'sexo': 'm',
            'tipo': 'a'
            };
  }
}