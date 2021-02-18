class Usuario {
  final int id;
  final String email;
  final String password;

  Usuario({this.id, this.email, this.password});

  Map<String, dynamic> toMap() =>
      {'id': id, 'email': email, 'password': password};
  factory Usuario.fromMap(Map<String, dynamic> map) =>
      Usuario(id: map["id"], email: map["email"], password: map["password"]);
}
