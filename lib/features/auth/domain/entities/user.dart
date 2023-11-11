import 'package:tfg_app/features/reservas/domain/domain.dart';

class User {
    final String username;
    final String email;
    final bool admin;
    final String token;
    final List<Reserva> reservas;
    final List<Escuela> escuelas;

    User({
        required this.username,
        required this.email,
        required this.admin,
        required this.token,
        required this.reservas,
        required this.escuelas,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        admin: json["admin"],
        token: json["token"],
        reservas: List<Reserva>.from(json["reservas"].map((x) => Reserva.fromJson(x))),
        escuelas: List<Escuela>.from(json["escuelas"].map((x) => Escuela.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "admin": admin,
        "token": token,
        "reservas": List<dynamic>.from(reservas.map((x) => x.toJson())),
        "escuelas": List<dynamic>.from(escuelas.map((x) => x.toJson())),
    };
}