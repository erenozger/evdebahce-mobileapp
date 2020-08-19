class DjangoUser {
  final int id;
  final String email;
  final String first_name;
  final String auth_token;

  DjangoUser({
    this.id,
    this.email,
    this.first_name,
    this.auth_token,
  });

  factory DjangoUser.fromJson(Map<String, dynamic> jsonData) {
    return DjangoUser(
      id: jsonData['id'],
      email: jsonData['email'],
      first_name: jsonData['first_name'],
      auth_token: jsonData['auth_token'],
    );
  }
}


