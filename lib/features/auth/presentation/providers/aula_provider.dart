import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

final aulaProvider = StateNotifierProvider.autoDispose.family<AulaNotifier, AulaState, String>(
  (ref, idAula) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
    return AulaNotifier(escuelasRepository: escuelasRepository, idAula: idAula);
});

class AulaNotifier extends StateNotifier<AulaState> {
  final EscuelasRepository escuelasRepository;

  AulaNotifier({
    required this.escuelasRepository,
    required String idAula
  }) : super(AulaState(id: idAula)){
    loadAula();
  }

  Aula newAula() {
    return Aula(
      idAula: 'new', 
      nombreAula: '', 
      horaEntrada: '', 
      horaSalida: '',
      idEscuela: ''
    );
  }

  Future<void> loadAula() async{

    if (state.id == 'new') {
      state = state.copyWith(
        isLoading: false,
        aula: newAula()
      );
    }

    final aula = await escuelasRepository.getAulaById(state.id);

    state = state.copyWith(
      isLoading: false,
      aula: aula
    );

  }


}

class AulaState {
  final String id;
  final Aula? aula;
  final bool isLoading;
  final bool isSaving;

  AulaState({
    required this.id,
    this.aula,
    this.isLoading = false,
    this.isSaving = false
  });

  AulaState copyWith({
    String? id,
    Aula? aula,
    bool? isLoading,
    bool? isSaving
  }) => AulaState(
    id: id ?? this.id,
    aula: aula ?? this.aula,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving
  );

}