import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

//*provider
final reservaFormProvider = StateNotifierProvider.autoDispose.family<ReservaNotifier, ReservaState, String>((ref, idAula) {
  final escuelasRepository = ref.watch(escuelasRepositoryProvider);
  return ReservaNotifier(
    escuelasRepository: escuelasRepository, 
    idAula: idAula
  );
});

//* notifier
class ReservaNotifier extends StateNotifier<ReservaState> {
  final EscuelasRepository escuelasRepository;

  ReservaNotifier({
    required this.escuelasRepository,
    required String idAula
  }) : super(ReservaState(id: idAula)){
    loadAula();
  }

  Future<void> loadAula() async{
    
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    final aula = await escuelasRepository.getAulaById(state.id);
    
    state = state.copyWith(
      isLoading: false,
      aula: aula
    );
    
  }
}

//* state
class ReservaState {
  final String id;
  final bool isLoading;
  final Aula? aula;

  ReservaState({
    required this.id, 
    this.isLoading = false, 
    this.aula 
  });

  ReservaState copyWith({
    String? id,
    bool? isLoading,
    Aula? aula
  }) => ReservaState(
    id: id ?? this.id,
    isLoading: isLoading ?? this.isLoading,
    aula: aula ?? this.aula
  );

}