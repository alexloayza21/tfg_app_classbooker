
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/aulas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/aulas_repository_provider.dart';

//* Cada vez que yo cierre la pantalla aulas se hará el autodispose del provider
//* y cuando se vuelva a buscar las aulas el is loading estará en true
//* provider
final aulasProvider = StateNotifierProvider.autoDispose.family<AulasNotifier, AulaState, String>((ref, idEscuela) {
  final aulasRepository = ref.watch(aulasRepositoryProvider);
  return AulasNotifier(
    aulasRepository: aulasRepository, 
    idEscuela: idEscuela
  );
});

//* notifier
class AulasNotifier extends StateNotifier<AulaState> {

  final AulasRepository aulasRepository;

  AulasNotifier({ 
    required this.aulasRepository,
    required String idEscuela
  }) : super(AulaState(id: idEscuela)){
    loadEscuelas();
  }

  Future<bool> createOrUpdateAula(Map<String, dynamic> aulaLike) async{
    try {
      final aula = await aulasRepository.createUpdateAula(aulaLike);
      final isAulaInList = state.aulas.any((element) => element.idAula == aula.idAula);

      if(!isAulaInList){
        state = state.copyWith(
          aulas: [...state.aulas, aula]
        );
        return true;
      }

      state = state.copyWith(
        aulas: state.aulas.map(
          (element) => (element.idAula == aula.idAula) ? aula : element).toList()
      );
      return true;

    } catch (e) {
      return false;
    }
  }

  Future loadEscuelas() async{
    if ( state.isLoading == true ) return;
    state = state.copyWith(isLoading: true);

    final aulas = await aulasRepository.getAulasByIdEscuela(state.id);

    if (aulas.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorAulas: 'NO HAY AULAS'
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      errorAulas: '',
      aulas: aulas
    );

  }
  
}

//* state
class AulaState {
  final String id;
  final String errorAulas;
  final List<Aula> aulas;
  final bool isLoading;

  AulaState({
    required this.id, 
    this.errorAulas = '', 
    this.aulas = const [], 
    this.isLoading = false
  });

  AulaState copyWith({
    String? id,
    String? errorAulas,
    List<Aula>? aulas,
    bool? isLoading
  })=> AulaState(
    id: id ?? this.id,
    errorAulas: errorAulas ?? this.errorAulas,
    aulas: aulas ?? this.aulas,
    isLoading: isLoading ?? this.isLoading
  );
}