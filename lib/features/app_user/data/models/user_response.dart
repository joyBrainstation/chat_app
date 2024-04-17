import 'package:chat_app/features/app_user/domain/entities/user.dart';

class UserResponse {
  final String id;
  final String name;
  final String email;
  String? token;
  final String photo;

  UserResponse(
    this.id,
    this.name,
    this.email,
    this.photo,
    this.token,
  );

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json["id"],
      json["name"],
      json["email"],
      json["photo"],
      json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photo": photo,
        "token": token,
      };

  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        photo: photo,
        token: token,
      );
}
