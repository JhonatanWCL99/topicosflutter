class Trabajador {
  final int persona_id;
  final bool habilitado;

  Trabajador({this.persona_id, this.habilitado});

  Map<String, dynamic> toMap() =>
      {'persona_id': persona_id, 'habilitado': habilitado};
  factory Trabajador.fromMap(Map<String, dynamic> map) =>
      Trabajador(persona_id: map["persona_id"], habilitado: map["habilitado"]);
}
