import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/escuelas/domain/domain.dart';
import 'package:tfg_app/features/escuelas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/escuelas/presentation/providers/escuelas_repository_provider.dart';

//* Provider
final escuelasProvider = StateNotifierProvider<EscuelasNotifier, EscuelasState>((ref) {
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

  Future loadEscuelas() async {
    if (state.isLoading) return;
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
    List<Escuela>? escuelas
  }) => EscuelasState(
    isLoading: isLoading ?? this.isLoading,
    errorEscuelas: errorEscuelas ?? this.errorEscuelas,
    escuelas: escuelas ?? this.escuelas
  );
}