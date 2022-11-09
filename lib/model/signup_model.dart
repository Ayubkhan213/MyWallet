class SignUp {
  int? id;
  String? name;
  String? email;
  String? password;
  SignUp({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  factory SignUp.fromMap(Map<String, dynamic> row) {
    return SignUp(
        id: row['id'],
        name: row['name'],
        email: row['email'],
        password: row['password']);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
