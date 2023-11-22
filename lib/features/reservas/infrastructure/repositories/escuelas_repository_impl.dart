import 'package:tfg_app/features/reservas/domain/datasource/escuelas_datasource.dart';
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
  Future<Escuela> getEscuelaById(String id) {
    return datasource.getEscuelaById(id);
  }
  
  @override
  Future<Escuela> createUpdateEscuela(Map<String, dynamic> escuelaLike) {
    return datasource.createUpdateEscuela(escuelaLike);
  }
  
  @override
  Future<Escuela> getEscuelaByUserId(String id) {
    return datasource.getEscuelaByUserId(id);
  }
  
  @override
  Future<Escuela> deleteEscuela(String id) {
    return datasource.deleteEscuela(id);
  }
  
  
}