import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

final escuelaProvider = StateNotifierProvider.autoDispose.family<EscuelaNotifier, EscuelaState, String>(
  (ref, escuelaId) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
  return EscuelaNotifier(escuelasRepository: escuelasRepository, escuelaId: escuelaId);
});

class EscuelaNotifier extends StateNotifier<EscuelaState> {
  final EscuelasRepository escuelasRepository;

  EscuelaNotifier({
    required this.escuelasRepository,
    required String escuelaId
  }) : super(EscuelaState(id: escuelaId)){
    loadEscuelas();
  }
  

  Escuela newEscuela() {
    return Escuela(
      idEscuela: 'new', 
      nombreEscuela: '', 
      direccion: '', 
      ciudad: '', 
      codigoPostal: '', 
      provincia: '', 
      imagen: '',
      aulas: []
    );
  }

  Future<void> loadEscuelas() async{

    if (state.id == 'new') {
      state = state.copyWith(
        isLoading: false,
        escuela: newEscuela()
      );
      return;
    }

    final escuela = await escuelasRepository.getEscuelaById(state.id);

    state = state.copyWith(
      isLoading: false,
      escuela: escuela
    );
    

  }

}

class EscuelaState {

  final String id;
  final Escuela? escuela;
  final bool isLoading;
  final bool isSaving;

  EscuelaState({
    required this.id, 
    this.escuela, 
    this.isLoading = true, 
    this.isSaving = false
  });

  EscuelaState copyWith({
    String? id,
    Escuela? escuela,
    bool? isLoading,
    bool? isSaving,
  }) => EscuelaState(
    id: id ?? this.id, 
    escuela: escuela ?? this.escuela, 
    isLoading: isLoading ?? this.isLoading, 
    isSaving: isSaving ?? this.isSaving
  );
  
}