import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_provider.dart';

final escuelaFormProvider = StateNotifierProvider.autoDispose.family<EscuelaFormNotifier, EscuelaFormState, Escuela>(
  (ref, escuela) {
    final createUpdateCallback = ref.watch(escuelasProvider.notifier).createOrUpdateEscuela;
    return EscuelaFormNotifier(
      onSubmitCallback: createUpdateCallback, 
      escuela: escuela
    );
});

class EscuelaFormNotifier extends StateNotifier<EscuelaFormState> {
  final Future<bool> Function (Map<String, dynamic> escuelaLike) ? onSubmitCallback;

  EscuelaFormNotifier({
    required this.onSubmitCallback,
    required Escuela escuela,
  }):super(
    EscuelaFormState(
      id: escuela.idEscuela,
      nombreEscuela: escuela.nombreEscuela, 
      direccion: escuela.direccion, 
      ciudad: escuela.ciudad, 
      codigoPostal: escuela.codigoPostal, 
      provincia: escuela.provincia, 
      imagen: escuela.imagen,
      aulas: escuela.aulas
    )
  );

  Future<bool> onFormSubmit() async {
    if ( onSubmitCallback == null ) return false;
    final escuelaLike = {
      'id': (state.id == 'new') ? null : state.id,
      'nombreEscuela': state.nombreEscuela,
      'direccion': state.direccion,
      'ciudad': state.ciudad,
      'codigo_postal' : state.codigoPostal,
      'provincia': state.provincia,
      'imagen': state.imagen,
      'aulas': state.aulas
    };
    try {
      return await onSubmitCallback!(escuelaLike);
    } catch (e) {
      return false;
    }
  }

  void onNombreEscuelaChanged(String value){
    state = state.copyWith(
      nombreEscuela: value
    );
  }

  void onDireccionChanged(String value){
    state = state.copyWith(
      direccion: value
    );
  }

  void onCiudadChanged(String value){
    state = state.copyWith(
      ciudad: value
    );
  }

  void onProvinciaChanged(String value){
    state = state.copyWith(
      provincia: value
    );
  }

  void onCodigoPostalChanged(String value){
    state = state.copyWith(
      codigoPostal: value
    );
  }

}

class EscuelaFormState {
  final String? id;
  final String nombreEscuela;
  final String direccion;
  final String ciudad;
  final String codigoPostal;
  final String provincia;
  final String? imagen;
  final List<Aula>? aulas;

  EscuelaFormState({
    this.id,
    required this.nombreEscuela, 
    required this.direccion, 
    required this.ciudad, 
    required this.codigoPostal, 
    required this.provincia, 
    this.imagen, 
    this.aulas = const []
  });

  EscuelaFormState copyWith({
    String? id,
    String? nombreEscuela,
    String? direccion,
    String? ciudad,
    String? codigoPostal,
    String? provincia,
    String? imagen,
    List<Aula>? aulas,
  }) => EscuelaFormState(
    id: id ?? this.id,
    nombreEscuela: nombreEscuela ?? this.nombreEscuela, 
    direccion: direccion ?? this.direccion, 
    ciudad: ciudad ?? this.ciudad, 
    codigoPostal: codigoPostal ?? this.codigoPostal, 
    provincia: provincia ?? this.provincia, 
    imagen: imagen ?? this.imagen
  );
}