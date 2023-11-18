import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

//* Provider
final escuelasProvider = StateNotifierProvider.autoDispose<EscuelasNotifier, EscuelasState>((ref) {
  final escuelasRepository = ref.watch(escuelasRepositoryProvider);
  return EscuelasNotifier(escuelasRepository: escuelasRepository);
});

//* Notifier
class EscuelasNotifier extends StateNotifier<EscuelasState> {

  final EscuelasRepository escuelasRepository;

  EscuelasNotifier({
    required this.escuelasRepository
    }) : super(EscuelasState()){
    loadEscuelas();
  }

  Future<bool> createOrUpdateEscuela(Map<String, dynamic> escuelaLike) async{
    try {
      final escuela = await escuelasRepository.createUpdateEscuela(escuelaLike);
      final isEscuelaInList = state.escuelas.any((element) => element.idEscuela == escuela.idEscuela);

      if(!isEscuelaInList){
        state = state.copyWith(
          escuelas: [...state.escuelas, escuela]
        );
        return true;
      }

      state = state.copyWith(
        escuelas: state.escuelas.map(
          (element) => (element.idEscuela == escuela.idEscuela) ? escuela : element).toList()
      );
      return true;

    } catch (e) {
      return false;
    }
  }

  Future loadEscuelas() async {
    state = state.copyWith(isLoading: true);

    final escuelas = await escuelasRepository.getAllEscuelas();

    if (escuelas.isEmpty){
      state = state.copyWith(
        isLoading: false,
        errorEscuelas: 'NO HAY ESCUELAS'
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      errorEscuelas: '',
      escuelas: escuelas
    );
  }
}

//* State
class EscuelasState {
  final bool isLoading;
  final String errorEscuelas;
  final List<Escuela> escuelas;

  EscuelasState({
    this.isLoading = false, 
    this.errorEscuelas = '',
    this.escuelas = const []
  });

  EscuelasState copyWith({
    bool? isLoading,
    String? errorEscuelas,
    Escuela? escuela,
    List<Escuela>? escuelas
  }) => EscuelasState(
    isLoading: isLoading ?? this.isLoading,
    errorEscuelas: errorEscuelas ?? this.errorEscuelas,
    escuelas: escuelas ?? this.escuelas
  );
}