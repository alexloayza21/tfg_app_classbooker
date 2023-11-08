import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

//*provider
final reservaFormProvider = StateNotifierProvider.autoDispose.family<ReservaFormNotifier, ReservaFormState, String>((ref, idAula) {
  final escuelasRepository = ref.watch(escuelasRepositoryProvider);
  return ReservaFormNotifier(
    escuelasRepository: escuelasRepository, 
    idAula: idAula
  );
});

//* notifier
class ReservaFormNotifier extends StateNotifier<ReservaFormState> {
  final EscuelasRepository escuelasRepository;

  ReservaFormNotifier({
    required this.escuelasRepository,
    required String idAula
  }) : super(ReservaFormState(id: idAula)){
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
class ReservaFormState {
  final String id;
  final bool isLoading;
  final Aula? aula;

  ReservaFormState({
    required this.id, 
    this.isLoading = false, 
    this.aula 
  });

  ReservaFormState copyWith({
    String? id,
    bool? isLoading,
    Aula? aula
  }) => ReservaFormState(
    id: id ?? this.id,
    isLoading: isLoading ?? this.isLoading,
    aula: aula ?? this.aula
  );

}