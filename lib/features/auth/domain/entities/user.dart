import 'package:tfg_app/features/reservas/domain/domain.dart';

class User {
    final String username;
    final String email;
    final bool admin;
    final String token;
    final List<Reserva>? reservas;
    final Escuela? escuela;

    User({
        required this.username,
        required this.email,
        required this.admin,
        required this.token,
        this.reservas = const [],
        this.escuela,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        admin: json["admin"] ?? '',
        token: json["token"] ?? '',
        reservas: (json["reservas"] as List<dynamic>?)?.map((x) => Reserva.fromJson(x)).toList(),
        escuela: json['escuela'] != null ? Escuela.fromJson(json['escuela']) : null,
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admin": admin,
        "token": token,
        "reservas": reservas != null ? List<dynamic>.from(reservas!.map((x) => x.toJson())) : null,
        "escuela": escuela != null ? escuela!.toJson() : null
    };

    @override
  String toString() {
    return 'User{username: $username, email: $email, admin: $admin, token: $token, reservas: $reservas, escuela: $escuela}';
  }
}