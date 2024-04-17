import 'package:chat_app/features/authentication/domain/entities/user.dart';

class UserResponse {
  final String id;
  final String name;
  final String email;
  String? token;

  UserResponse(
    this.id,
    this.name,
    this.email,
    this.token,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "token": token,
      };

  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        token: token,
      );
}
