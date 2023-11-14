import 'package:tfg_app/features/reservas/domain/domain.dart';

class Escuela {
    final String? idEscuela;
    final String nombreEscuela;
    final String direccion;
    final String ciudad;
    final String codigoPostal;
    final String provincia;
    final String? imagen;
    final List<Aula>? aulas;
    final String? user;

    Escuela({
        this.idEscuela,
        required this.nombreEscuela,
        required this.direccion,
        required this.ciudad,
        required this.codigoPostal,
        required this.provincia,
        this.imagen,
        this.aulas = const [],
        this.user
    });

    factory Escuela.fromJson(Map<String, dynamic> json) => Escuela(
        idEscuela: json["_id"],
        nombreEscuela: json["nombreEscuela"],
        direccion: json["direccion"],
        ciudad: json["ciudad"],
        codigoPostal: json["codigo_postal"],
        provincia: json["provincia"],
        imagen: json["imagen"],
        aulas: List<Aula>.from(json["aulas"].map((x) => Aula.fromJson(x))),
        user: json["user"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "nombreEscuela": nombreEscuela,
        "direccion": direccion,
        "ciudad": ciudad,
        "codigo_postal": codigoPostal,
        "provincia": provincia,
        "imagen": imagen ?? '',
        "aulas": List<dynamic>.from(aulas?.map((x) => x.toJson()) ?? []),
        "user": user,
    };
}
