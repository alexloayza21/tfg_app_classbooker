import 'package:tfg_app/features/reservas/domain/domain.dart';

class User {
    final String username;
    final String email;
    final bool admin;
    final String token;
    final List<Reserva>? reservas;
    final List<Escuela>? escuelas;

    User({
        required this.username,
        required this.email,
        required this.admin,
        required this.token,
        this.reservas = const [],
        this.escuelas = const [],
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        admin: json["admin"] ?? '',
        token: json["token"] ?? '',
        reservas: (json["reservas"] as List<dynamic>?)?.map((x) => Reserva.fromJson(x)).toList(),
        escuelas: (json["escuelas"] as List<dynamic>?)?.map((x) => Escuela.fromJson(x)).toList(),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admin": admin,
        "token": token,
        "reservas": reservas != null ? List<dynamic>.from(reservas!.map((x) => x.toJson())) : null,
        "escuelas": reservas != null ? List<dynamic>.from(escuelas!.map((x) => x.toJson())) : null,
    };
}