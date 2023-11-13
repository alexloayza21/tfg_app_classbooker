import 'package:tfg_app/features/reservas/domain/domain.dart';

class Aula {
    final String idAula;
    final String nombreAula;
    final String idEscuela;
    final String horaEntrada;
    final String horaSalida;
    final List<Asiento>? asientos;

    Aula({
        required this.idAula,
        required this.nombreAula,
        required this.idEscuela,
        required this.horaEntrada,
        required this.horaSalida,
        this.asientos = const[],
    });

    factory Aula.fromJson(Map<String, dynamic> json) => Aula(
        idAula: json["_id"],
        nombreAula: json["nombreAula"],
        idEscuela: json["idEscuela"],
        horaEntrada: json["hora_entrada"],
        horaSalida: json["hora_salida"],
        asientos: List<Asiento>.from(json["asientos"].map((x) => Asiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idAula": idAula,
        "nombreAula": nombreAula,
        "idEscuela": idEscuela,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "asientos": List<dynamic>.from(asientos!.map((x) => x.toJson())),
    };
}