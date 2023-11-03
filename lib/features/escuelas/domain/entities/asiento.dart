

class Asiento {
    final int numeroAsiento;
    final String idAula;

    Asiento({
        required this.numeroAsiento,
        required this.idAula,
    });

    factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
        numeroAsiento: json["numeroAsiento"],
        idAula: json["idAula"],
    );

    Map<String, dynamic> toJson() => {
        "numeroAsiento": numeroAsiento,
        "idAula": idAula,
    };
}