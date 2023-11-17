
import 'package:tfg_app/config/config.dart';

class Escuela {
    final String? idEscuela;
    final String nombreEscuela;
    final String direccion;
    final String ciudad;
    final String codigoPostal;
    final String provincia;
    final String imagen;
    final String userId;

    Escuela({
        this.idEscuela,
        required this.nombreEscuela,
        required this.direccion,
        required this.ciudad,
        required this.codigoPostal,
        required this.provincia,
        this.imagen = '',
        this.userId = ''
    });

    factory Escuela.fromJson(Map<String, dynamic> json) => Escuela(
        idEscuela: json["_id"] ?? '',
        nombreEscuela: json["nombreEscuela"] ?? '',
        direccion: json["direccion"] ?? '',
        ciudad: json["ciudad"] ?? '',
        codigoPostal: json["codigo_postal"] ?? '',
        provincia: json["provincia"] ?? '',
        imagen: json["imagen"].toString().startsWith('http') ? json["image"] : '${Environment.apiUrl}/escuelas/downloadImage/${json["imagen"]}',
        userId: json["userId"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "nombreEscuela": nombreEscuela,
        "direccion": direccion,
        "ciudad": ciudad,
        "codigo_postal": codigoPostal,
        "provincia": provincia,
        "imagen": imagen,
        "userId": userId,
    };
}
