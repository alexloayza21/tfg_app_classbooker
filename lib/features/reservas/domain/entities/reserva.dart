import 'package:tfg_app/features/reservas/domain/domain.dart';

class Reserva {
    final String fecha;
    final String horaEntrada;
    final String horaSalida;
    final List<Asiento> asientos;

    Reserva({
        required this.fecha,
        required this.horaEntrada,
        required this.horaSalida,
        required this.asientos,
    });

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        fecha: json["fecha"],
        horaEntrada: json["hora_entrada"],
        horaSalida: json["hora_salida"],
        asientos: List<Asiento>.from(json["asientos"].map((x) => Asiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "asientos": List<dynamic>.from(asientos.map((x) => x.toJson())),
    };
}