import 'package:tfg_app/features/escuelas/domain/datasource/escuelas_datasource.dart';
import 'package:tfg_app/features/escuelas/domain/entities/aula.dart';
import 'package:tfg_app/features/escuelas/domain/entities/escuela.dart';
import 'package:tfg_app/features/escuelas/domain/repositories/escuelas_repository.dart';

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
  
}