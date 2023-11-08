class Asiento {
    final int numeroAsiento;
    final String? horaEntrada;
    final String? horaSalida;
    final String idAula;

    Asiento({
        required this.numeroAsiento,
        required this.idAula,
        this.horaEntrada, 
        this.horaSalida
    });

    factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
        numeroAsiento: json["numeroAsiento"],
        idAula: json["idAula"],
        horaEntrada: json["hora_entrada"],
        horaSalida: json["hora_salida"]
    );

    Map<String, dynamic> toJson() => {
        "numeroAsiento": numeroAsiento,
        "idAula": idAula,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida
    };
}