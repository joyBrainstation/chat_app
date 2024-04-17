class User {
  final String id;
  final String name;
  final String email;
  final String photo;
  String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    this.token,
  });
}
