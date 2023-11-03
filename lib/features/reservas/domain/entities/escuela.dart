import 'package:tfg_app/features/reservas/domain/domain.dart';

class Escuela {
    final String idEscuela;
    final String nombreEscuela;
    final String direccion;
    final String ciudad;
    final String codigoPostal;
    final String provincia;
    final List<Aula> aulas;
    final String imagen;

    Escuela({
        required this.idEscuela,
        required this.nombreEscuela,
        required this.direccion,
        required this.ciudad,
        required this.codigoPostal,
        required this.provincia,
        required this.aulas,
        required this.imagen,
    });

    factory Escuela.fromJson(Map<String, dynamic> json) => Escuela(
        idEscuela: json["idEscuela"],
        nombreEscuela: json["nombreEscuela"],
        direccion: json["direccion"],
        ciudad: json["ciudad"],
        codigoPostal: json["codigo_postal"],
        provincia: json["provincia"],
        imagen: json["imagen"],
        aulas: List<Aula>.from(json["aulas"].map((x) => Aula.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "idEscuela": idEscuela,
        "nombreEscuela": nombreEscuela,
        "direccion": direccion,
        "ciudad": ciudad,
        "codigo_postal": codigoPostal,
        "provincia": provincia,
        "imagen": imagen,
        "aulas": List<dynamic>.from(aulas.map((x) => x.toJson())),
    };
}
