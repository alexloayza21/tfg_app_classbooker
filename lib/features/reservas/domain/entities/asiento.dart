class Asiento {
    final int numeroAsiento;
    String? horaEntrada;
    String? horaSalida;
    final String idAula;

    Asiento({
        required this.numeroAsiento,
        required this.idAula,
        this.horaEntrada, 
        this.horaSalida
    });

    String? get getHoraEntrada => horaEntrada;
  
    set setHoraEntrada(String? horaEntrada) {
      this.horaEntrada = horaEntrada;
    }
  
    String? get getHoraSalida => horaSalida;
  
    set setHoraSalida(String? horaSalida) {
      this.horaSalida = horaSalida;
    }

    factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
        numeroAsiento: json["numeroAsiento"],
        horaEntrada: json["hora_entrada"],
        horaSalida: json["hora_salida"],
        idAula: json["idAula"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "numeroAsiento": numeroAsiento,
        "idAula": idAula,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida
    };

  //   @override
  // String toString() {
  //   return '\nnumeroAsiento: $numeroAsiento, \nhoraEntrada: $horaEntrada, \nhoraSalida: $horaSalida, \nidAula: $idAula';
  // }
  
    @override
  String toString() {
    return ' $numeroAsiento ';
  }

}