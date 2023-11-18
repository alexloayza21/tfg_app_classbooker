import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_provider.dart';

//*provider
final reservaFormProvider = StateNotifierProvider.autoDispose.family<ReservaFormNotifier, ReservaFormState, Reserva>(
  (ref, reserva) {
  final onSubmitCallback = ref.watch(reservasProvider('').notifier).postReserva;
  return ReservaFormNotifier(
    onSubmitCallback: onSubmitCallback, 
    reserva: reserva
  );
});

//* notifier
class ReservaFormNotifier extends StateNotifier<ReservaFormState> {
  final Future<bool> Function (Reserva newReserva) ? onSubmitCallback;

  ReservaFormNotifier({
    required this.onSubmitCallback,
    required Reserva reserva
  }) : super(ReservaFormState(
    fecha: reserva.fecha, 
    horaEntrada: reserva.horaEntrada, 
    horaSalida: reserva.horaSalida, 
    nombreAula: reserva.nombreAula, 
    idEscuela: reserva.idEscuela, 
    asientos: reserva.asientos
  ));

  Future<bool> onFormSubmit() async{
    if ( onSubmitCallback == null) return false;
    final newReserva = Reserva(
      fecha: state.fecha, 
      horaEntrada: state.horaEntrada, 
      horaSalida: state.horaSalida, 
      nombreAula: state.nombreAula, 
      idEscuela: state.idEscuela,
      asientos: state.asientos
    );
    try {
      return await onSubmitCallback!(newReserva);
    } catch (e) {
      return false;
    }
  }

  void onFechaChanged(String fecha){
    state = state.copyWith(
      fecha: fecha
    );
  }

  void onHoraEntradaChanged(String horaEntrada){
    state = state.copyWith(
      horaEntrada: horaEntrada
    );
  }

  void onHoraSalidaChanged(String horaSalida){
    state = state.copyWith(
      horaSalida: horaSalida
    );
  }

  void onNombreAulaChanged(String nombreAula){
    state = state.copyWith(
      nombreAula: nombreAula
    );
  }

  void onIdEscuelaChanged(String idEscuela){
    state = state.copyWith(
      idEscuela: idEscuela
    );
  }

  void onListaAsientos(List<Asiento> asientos){
    state = state.copyWith(
      asientos: asientos
    );
  }

  bool checkHoras(String? horaEntrada, String? horaSalida){
    if (horaEntrada == horaSalida) return true;
    return false;
  }

}

//* state
class ReservaFormState {
  final bool isLoading;
  final String fecha;
  final String horaEntrada;
  final String horaSalida;
  final String nombreAula;
  final String idEscuela;
  final List<Asiento> asientos;

  ReservaFormState({
    this.isLoading = false, 
    required this.fecha, 
    required this.horaEntrada, 
    required this.horaSalida, 
    required this.nombreAula, 
    required this.idEscuela, 
    required this.asientos
  });


  ReservaFormState copyWith({    
    
    bool? isLoading,
    String? fecha,
    String? horaEntrada,
    String? horaSalida,
    String? nombreAula,
    String? idEscuela,
    List<Asiento>? asientos,

  }) => ReservaFormState(
    isLoading: isLoading ?? this.isLoading,
    fecha: fecha ?? this.fecha, 
    horaEntrada: horaEntrada ?? this.horaEntrada, 
    horaSalida: horaSalida ?? this.horaSalida, 
    nombreAula: nombreAula ?? this.nombreAula, 
    idEscuela: idEscuela ?? this.idEscuela, 
    asientos: asientos ?? this.asientos
  );

}