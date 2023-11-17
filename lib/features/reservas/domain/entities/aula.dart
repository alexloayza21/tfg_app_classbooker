import 'package:tfg_app/features/reservas/domain/domain.dart';

class Aula {
    final String idAula;
    final String nombreAula;
    final String idEscuela;
    final String horaEntrada;
    final String horaSalida;
    final bool mediaHora;
    final List<Asiento> asientos;

    Aula({
        required this.idAula,
        required this.nombreAula,
        required this.idEscuela,
        this.horaEntrada = '',
        this.horaSalida = '',
        required this.mediaHora,
        this.asientos = const [],
    });

    factory Aula.fromJson(Map<String, dynamic> json) => Aula(
        idAula: json["_id"] ?? '',
        nombreAula: json["nombreAula"] ?? '',
        horaEntrada: json["hora_entrada"] ?? '',
        horaSalida: json["hora_salida"] ?? '',
        idEscuela: json["idEscuela"] ?? '',
        mediaHora: json['mediaHora'] ?? false,
        asientos: List<Asiento>.from((json["asientos"] as List<dynamic>?)?.map((x) => Asiento.fromJson(x)) ?? []),
    );

    Map<String, dynamic> toJson() => {
        "idAula": idAula,
        "nombreAula": nombreAula,
        "idEscuela": idEscuela,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "mediaHora": mediaHora,
        "asientos": List<dynamic>.from(asientos.map((x) => x.toJson())),
    };
}