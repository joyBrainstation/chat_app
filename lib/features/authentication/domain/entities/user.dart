class User {
  final String id;
  final String name;
  final String email;
  String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });
}
