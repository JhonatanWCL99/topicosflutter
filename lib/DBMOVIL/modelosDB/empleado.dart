
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
            'sexo': sexo,
            'tipo': 'a'
            };
  }
}