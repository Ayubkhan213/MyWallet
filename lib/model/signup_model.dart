class SignupModel {
  int? id;
  String? name;
  String? email;
  String? password;
  SignupModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  factory SignupModel.fromMap(Map<String, dynamic> parse) {
    return SignupModel(
        id: parse['id'],
        name: parse['name'],
        email: parse['email'],
        password: parse['password']);
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
