import 'package:tfg_app/features/reservas/domain/domain.dart';

class Reserva {
    final String? id;
    final String fecha;
    final String horaEntrada;
    final String horaSalida;
    final String nombreAula;
    final List<Asiento> asientos;
    final String idEscuela;
    final String nombreEscuela;
    final String username;
    final String userId;

    Reserva({
      this.id,
      required this.fecha,
      required this.horaEntrada,
      required this.horaSalida,
      required this.nombreAula, 
      required this.idEscuela,
      required this.asientos,
      required this.nombreEscuela,
      this.username = '',
      this.userId = ''
    });

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json['_id'] ?? '',
        fecha: json["fecha"] ?? '',
        horaEntrada: json["hora_entrada"] ?? '',
        horaSalida: json["hora_salida"] ?? '',
        nombreAula: json["nombreAula"] ?? '',
        asientos: List<Asiento>.from((json["asientos"] as List<dynamic>?)?.map((x) => Asiento.fromJson(x)) ?? []),
        idEscuela: json["idEscuela"] ?? '',
        username: json["username"] ?? '',
        userId: json["userId"] ?? '', 
        nombreEscuela: json["nombreEscuela"] ?? ''
    );

    Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "nombreAula": nombreAula,
        "asientos": List<dynamic>.from(asientos.map((x) => x.toJson())),
        "idEscuela": idEscuela,
        "username": username,
        "nombreEscuela": nombreEscuela,
        "userId": userId
    };
}