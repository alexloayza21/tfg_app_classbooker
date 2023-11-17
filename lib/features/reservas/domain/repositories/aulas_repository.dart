
import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class AulasRepository {
  
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
  Future<Aula> getAulaById(String idAula);
  Future<Aula> createUpdateAula(Map<String, dynamic> aulaLike);
  
}