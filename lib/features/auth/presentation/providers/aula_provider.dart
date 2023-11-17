import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/escuelas_repository_provider.dart';

final aulaProvider = StateNotifierProvider.autoDispose.family<AulaNotifier, AulaState, String>(
  (ref, idAula) {
    final escuelasRepository = ref.watch(escuelasRepositoryProvider);
    final userState = ref.watch(authProvider);
    return AulaNotifier(escuelasRepository: escuelasRepository, idAula: idAula, idEscuela: userState.user!.idEscuela);
});

class AulaNotifier extends StateNotifier<AulaState> {
  final EscuelasRepository escuelasRepository;


  AulaNotifier({
    required this.escuelasRepository,
    required String idAula,
    required String idEscuela
  }) : super(AulaState(id: idAula, idEscuela: idEscuela)){
    loadAula();
  }

  Aula newAula() {
    return Aula(
      idAula: 'new', 
      nombreAula: '', 
      horaEntrada: '', 
      horaSalida: '',
      idEscuela: state.idEscuela, 
      mediaHora: false
    );
  }

  Future<void> loadAula() async{

    if (state.id == 'new') {
      state = state.copyWith(
        isLoading: false,
        aula: newAula()
      );
      return; //* sin el return seguirá al getAulById y mandará new como id
    }

    if (state.isLoading == false) return;
    state.copyWith(isLoading: true);

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
  final String idEscuela;
  final bool isLoading;
  final bool isSaving;

  AulaState({
    required this.id,
    required this.idEscuela,
    this.aula,
    this.isLoading = false,
    this.isSaving = false
  });

  AulaState copyWith({
    String? id,
    String? idEscuela,
    Aula? aula,
    bool? isLoading,
    bool? isSaving
  }) => AulaState(
    id: id ?? this.id,
    idEscuela: idEscuela ?? this.idEscuela,
    aula: aula ?? this.aula,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving
  );

}