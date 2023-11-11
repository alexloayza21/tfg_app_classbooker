import 'package:tfg_app/features/auth/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class Reserva {
    final String? id;
    final String fecha;
    final String horaEntrada;
    final String horaSalida;
    final List<Asiento> asientos;
    final User? user;

    Reserva({
      this.id,
      required this.fecha,
      required this.horaEntrada,
      required this.horaSalida,
      required this.asientos,
      this.user
    });

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json['_id'],
        fecha: json["fecha"],
        horaEntrada: json["hora_entrada"],
        horaSalida: json["hora_salida"],
        asientos: List<Asiento>.from(json["asientos"].map((x) => Asiento.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "asientos": List<dynamic>.from(asientos.map((x) => x.toJson())),
        "user": user?.toJson(),
    };
}