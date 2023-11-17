import 'package:tfg_app/features/reservas/domain/datasource/aulas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/entities/aula.dart';
import 'package:tfg_app/features/reservas/domain/repositories/aulas_repository.dart';

class AulasRepositoryImpl extends AulasRepository {

  final AulasDatasource datasource;

  AulasRepositoryImpl({required this.datasource});

  @override
  Future<Aula> createUpdateAula(Map<String, dynamic> aulaLike) {
    return datasource.createUpdateAula(aulaLike);
  }
  
  @override
  Future<Aula> getAulaById(String idAula) {
    return datasource.getAulaById(idAula);
  }

  @override
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela) {
    return datasource.getAulasByIdEscuela(idEscuela);
  }
  
}