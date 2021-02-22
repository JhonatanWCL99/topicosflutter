class Horario {
  final id;
  final hora;
  Horario({this.id, this.hora});
  Map<String, dynamic> toMap() => {'id': id, 'hora': hora};
  factory Horario.fromMap(Map<String, dynamic> map) => Horario(
        id: map["id"],
        hora: map["hora"],
      );
}
