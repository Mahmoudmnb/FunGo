class User {
  int id;
  String name;
  String email;
  String token;
  User({
    required this.email,
    required this.id,
    required this.name,
    required this.token,
  });

  factory User.fromMap(Map user) {
    return User(
      id: user['id'],
      email: user['email'],
      name: user['name'],
      token: user['token'],
    );
  }
  Map toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
    };
  }
}
