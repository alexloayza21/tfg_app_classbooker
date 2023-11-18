class Asiento {
    final int numeroAsiento;
    String horaEntrada;
    String horaSalida;
    String idAula;

    Asiento({
        required this.numeroAsiento,
        this.horaEntrada = '', 
        this.horaSalida = '',
        this.idAula = ''
    });

    String? get getHoraEntrada => horaEntrada;
  
    set setHoraEntrada(String horaEntrada) {
      this.horaEntrada = horaEntrada;
    }
  
    String? get getHoraSalida => horaSalida;
  
    set setHoraSalida(String horaSalida) {
      this.horaSalida = horaSalida;
    }

    factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
        numeroAsiento: json["numeroAsiento"] ?? '',
        horaEntrada: json["hora_entrada"] ?? '',
        horaSalida: json["hora_salida"] ?? '',
        idAula: json["idAula"] ?? ''
    );

    Map<String, dynamic> toJson() => {
        "numeroAsiento": numeroAsiento,
        "hora_entrada": horaEntrada,
        "hora_salida": horaSalida,
        "idAula": (idAula == '') ? null : idAula,
    };
  
    @override
  String toString() {
    return ' $numeroAsiento ';
  }

}