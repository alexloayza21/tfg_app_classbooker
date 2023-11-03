import 'package:tfg_app/features/reservas/domain/domain.dart';

class Aula {
    final String idAula;
    final String nombreAula;
    final String idEscuela;
    final List<Asiento> asientos;

    Aula({
        required this.idAula,
        required this.nombreAula,
        required this.idEscuela,
        required this.asientos,
    });

    factory Aula.fromJson(Map<String, dynamic> json) => Aula(
        idAula: json["idAula"],
        nombreAula: json["nombreAula"],
        idEscuela: json["idEscuela"],
        asientos: List<Asiento>.from(json["asientos"].map((x) => Asiento.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idAula": idAula,
        "nombreAula": nombreAula,
        "idEscuela": idEscuela,
        "asientos": List<dynamic>.from(asientos.map((x) => x.toJson())),
    };
}