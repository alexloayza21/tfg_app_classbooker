import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/aulas_provider.dart';

final aulaFormProvider = StateNotifierProvider.autoDispose.family<AulaFormNotifier, AulaFormState, Aula>
((ref, aula) {
  final createUpdateCallback = ref.watch(aulasProvider(aula.idEscuela).notifier).createOrUpdateAula;
  return AulaFormNotifier(
    onSubmitCallback: createUpdateCallback, 
    aula: aula
  );
});

class AulaFormNotifier extends StateNotifier<AulaFormState> {
  final Future<bool> Function (Map<String, dynamic> aulaLike) ? onSubmitCallback;

  AulaFormNotifier({
    required this.onSubmitCallback,
    required Aula aula,
  }) : super(
    AulaFormState(
      id: aula.idAula,
      nombreAula: aula.nombreAula, 
      horaEntrada: aula.horaEntrada, 
      horaSalida: aula.horaSalida,
      mediaHora: aula.mediaHora,
      idEscuela: aula.idEscuela,
      asientos: aula.asientos
    )
  );

  Future<bool> onFormSubmit() async{
    if ( onSubmitCallback == null) return false;
    final aulaLike = {
      'id': (state.id == 'new') ? null : state.id,
      'nombreAula': state.nombreAula,
      'hora_entrada': state.horaEntrada,
      'hora_salida': state.horaSalida,
      'mediaHora': state.mediaHora,
      'idEscuela': state.idEscuela,
      'asientos': state.asientos,
    };
    try {
      return await onSubmitCallback!(aulaLike);
    } catch (e) {
      return false;
    }
  }

  void onNombreAulaChanged(String value){
    state = state.copyWith(
      nombreAula: value
    );
  }

  void onHoraEntradaChanged(String value){
    state = state.copyWith(
      horaEntrada: value
    );
  }

  void onHoraSalidaChanged(String value){
    state = state.copyWith(
      horaSalida: value
    );
  }

  void onMediaHoraChanged(bool? value){
    state = state.copyWith(
      mediaHora: !value!
    );
  }

  void onIdEscuelaChanged(String value){
    state = state.copyWith(
      idEscuela: value
    );
  }

  void onAsientosChanged(List<Asiento> asientos){
    state = state.copyWith(
      asientos: asientos
    );
  }

}

class AulaFormState {
  final bool isPosting;
  final String? id;
  final String nombreAula;
  final String horaEntrada;
  final String horaSalida;
  final bool mediaHora;
  final String idEscuela;
  final List<Asiento> asientos;

  AulaFormState({
    this.isPosting = false,
    this.id, 
    required this.nombreAula, 
    this.horaEntrada = '', 
    this.horaSalida = '', 
    this.mediaHora = false, 
    required this.idEscuela, 
    this.asientos = const []
  });

  AulaFormState copyWith({

    bool? isPosting,
    String? id,
    String? nombreAula,
    String? horaEntrada,
    String? horaSalida,
    bool? mediaHora,
    String? idEscuela,
    List<Asiento>? asientos,

  }) => AulaFormState(

    isPosting: isPosting ?? this.isPosting,
    id: id ?? this.id,
    nombreAula: nombreAula ?? this.nombreAula,
    horaEntrada: horaEntrada ?? this.horaEntrada,
    horaSalida: horaSalida ?? this.horaSalida,
    mediaHora: mediaHora ?? this.mediaHora,
    idEscuela: idEscuela ?? this.idEscuela,
    asientos: asientos ?? this.asientos

  );
}