import 'package:tfg_app/features/reservas/domain/domain.dart';

class User {
    final String userId;
    final String username;
    final String email;
    final bool admin;
    final String token;
    final String idEscuela;

    User({
      this.userId = '',
      required this.username,
      required this.email,
      required this.admin,
      required this.token,
      this.idEscuela = '',
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["_id"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        admin: json["admin"] ?? '',
        token: json["token"] ?? '',
        idEscuela: json['idEscuela'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admin": admin,
        "token": token,
        "idEscuela": idEscuela
    };

    @override
  String toString() {
    return 'User{username: $username, email: $email, admin: $admin, token: $token, idEscuela: $idEscuela}';
  }
}