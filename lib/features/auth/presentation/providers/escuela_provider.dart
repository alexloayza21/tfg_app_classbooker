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
    loadEscuela();
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
    );
  }

  Future<bool> loadEscuela() async{

    try {
      if(mounted) state = state.copyWith(isLoading: true);

      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          escuela: newEscuela()
        );
        return true;
      }

      if (state.isLoading == false) {
        state.copyWith(isLoading: true);
      }

      final escuela = await escuelasRepository.getEscuelaById(state.id);

      state = state.copyWith(
        isLoading: false,
        escuela: escuela
      );
      return true;
    } catch (e) {
      if (mounted) {
        return false;
      }
      return false;
    }
    

  }

  Future<bool> deleteEscuela(String id) async{
    try {
      if (mounted) state = state.copyWith(isLoading: true);

      state = state.copyWith(isLoading: true);
      final escuelaDeleted = await escuelasRepository.deleteEscuela(id);

      if (escuelaDeleted.idEscuela == state.escuela!.idEscuela) {
        state = state.copyWith(
          isLoading: false,
          escuela: null
        );
        return true;
      }else{
        return false;
      }

    } catch (e) {
      if (mounted) {
        return false;
      }
      return false;
    }
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