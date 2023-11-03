import 'package:tfg_app/features/reservas/domain/datasource/escuelas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/entities/aula.dart';
import 'package:tfg_app/features/reservas/domain/entities/escuela.dart';
import 'package:tfg_app/features/reservas/domain/repositories/escuelas_repository.dart';

class EscuelasRepositoryImpl extends EscuelasRepository {

  final EscuelasDatasource datasource;

  EscuelasRepositoryImpl({required this.datasource});

  @override
  Future<List<Escuela>> getAllEscuelas() {
    return datasource.getAllEscuelas();
  }

  @override
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela) {
    return datasource.getAulasByIdEscuela(idEscuela);
  }
  
  @override
  Future<Aula> getAulaById(String idAula) {
    return datasource.getAulaById(idAula);
  }
  
}