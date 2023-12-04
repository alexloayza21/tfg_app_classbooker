
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/domain/repositories/aulas_repository.dart';
import 'package:tfg_app/features/reservas/presentation/providers/aulas_repository_provider.dart';

//* Cada vez que yo cierre la pantalla aulas se hará el autodispose del provider
//* y cuando se vuelva a buscar las aulas el is loading estará en true
//* provider
final aulasProvider = StateNotifierProvider.autoDispose.family<AulasNotifier, AulaState, String>(
  (ref, idEscuela) {
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
    loadAulas();
  }

  Future<bool> createOrUpdateAula(Map<String, dynamic> aulaLike) async{
    try {
      state = state.copyWith(isLoading: true);
      final aula = await aulasRepository.createUpdateAula(aulaLike);
      print(state.aulas.toString());
      final isAulaInList = state.aulas.any((element) => element.idAula == aula.idAula);

      if(!isAulaInList){
        state = state.copyWith(
          isLoading: false,
          aulas: [...state.aulas, aula]
        );
        return true;
      }

      state = state.copyWith(
        isLoading: false,
        aulas: state.aulas.map(
          (element) => (element.idAula == aula.idAula) ? aula : element).toList()
      );
      return true;

    } catch (e) {
      return false;
    }
  }

  Future<void> loadAulas() async{
    try {
      if (mounted) state = state.copyWith(isLoading: true);
      
      state = state.copyWith(isLoading: true);

      final aulas = await aulasRepository.getAulasByIdEscuela(state.id);

      state = state.copyWith(
        isLoading: false,
        aulas: aulas
      );
      
    } catch (e) {
      if (mounted) {
        throw Exception(e);        
      }
    }

  }

  Future<bool> deleteAula(String idAula) async{
    try {

      if (mounted) state = state.copyWith(isLoading: true);

      state = state.copyWith(isLoading: true);

      final aulaDeleted = await aulasRepository.deleteAulaById(idAula);      

      state = state.copyWith(
        isLoading: false,
        aulas: [...state.aulas.where((element) => element.idAula != aulaDeleted.idAula)]
      );
      return true;
      
    } catch (e) {
      if (mounted) {
        return false;
      }
      return false;
    }
  }
  
}

//* state
class AulaState {
  final String id;
  final List<Aula> aulas;
  final bool isLoading;

  AulaState({
    required this.id, 
    this.aulas = const [], 
    this.isLoading = false
  });

  AulaState copyWith({
    String? id,
    List<Aula>? aulas,
    bool? isLoading
  })=> AulaState(
    id: id ?? this.id,
    aulas: aulas ?? this.aulas,
    isLoading: isLoading ?? this.isLoading
  );
}