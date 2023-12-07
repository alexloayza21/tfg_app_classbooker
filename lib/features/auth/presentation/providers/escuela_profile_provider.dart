import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

final escuelaProfileProvider = StateNotifierProvider.autoDispose.family<EscuelaProfileNotifier, EscuelaProfileState, String>(
  (ref, userId) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
    return EscuelaProfileNotifier(escuelasRepository: escuelasRepository, userId: userId);
});

class EscuelaProfileNotifier extends StateNotifier<EscuelaProfileState> {
  final EscuelasRepository escuelasRepository;

  EscuelaProfileNotifier({
    required this.escuelasRepository,
    required String userId
  }) : super(EscuelaProfileState(id: userId)){
    loadEscuela();
  }

  Future<bool> loadEscuela() async{

    try {
      if(mounted) state = state.copyWith(isLoading: true);

      if (state.isLoading == false) {
        state.copyWith(isLoading: true);
      }

      final escuela = await escuelasRepository.getEscuelaByUserId(state.id);

      state = state.copyWith(
        isLoading: false,
        escuela: escuela
      );
      return true;
    } catch (e) {
      if (mounted) {
        return true;
      }
      return false;
    }
    

  }

  Future<bool> postEscuela(Escuela newEscuela) async{
    try {
      state = state.copyWith(isLoading: true);
      final escuelaCU = await escuelasRepository.postEscuela(newEscuela);

      // if (state.escuela?.idEscuela == escuelaCU.idEscuela) {
      //   state = state.copyWith(
      //     isLoading: false,
      //     escuela: escuelaCU
      //   );
      //   return true;
      // }

      state = state.copyWith(
        isLoading: false,
        escuela: state.escuela ?? escuelaCU 
      );
      return true;

    } catch (e) {
      return false;
    }
  }

  Future<bool> updateEscuela(Map<String, dynamic> escuelaLike) async{
    try {
      state = state.copyWith(isLoading: true);
      final escuelaCU = await escuelasRepository.updateEscuela(escuelaLike);

      // if (state.escuela?.idEscuela == escuelaCU.idEscuela) {
      //   state = state.copyWith(
      //     isLoading: false,
      //     escuela: escuelaCU
      //   );
      //   return true;
      // }

      state = state.copyWith(
        isLoading: false,
        escuela: escuelaCU 
      );
      return true;

    } catch (e) {
      return false;
    }
  }
  
  Future<bool> deleteEscuela(String id) async{
    try {
      if (mounted) state = state.copyWith(isLoading: true);

      state = state.copyWith(isLoading: true);
      await escuelasRepository.deleteEscuela(id);

      if ( state.escuela != null){
        state = state.copyWith(
          isLoading: false,
          escuela: null
        );
      }
      return true;

    } catch (e) {
      if (mounted) {
        return false;
      }
      return false;
    }
  }

}

class EscuelaProfileState {

  final String id;
  final Escuela? escuela;
  final bool isLoading;
  final bool isSaving;

  EscuelaProfileState({
    required this.id, 
    this.escuela, 
    this.isLoading = true, 
    this.isSaving = false
  });

  EscuelaProfileState copyWith({
    String? id,
    Escuela? escuela,
    bool? isLoading,
    bool? isSaving,
  }) => EscuelaProfileState(
    id: id ?? this.id, 
    escuela: escuela ?? this.escuela, 
    isLoading: isLoading ?? this.isLoading, 
    isSaving: isSaving ?? this.isSaving
  );
  
}