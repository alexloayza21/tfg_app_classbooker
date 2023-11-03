import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasRepository {
  Future<List<Escuela>> getAllEscuelas();
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
  Future<Aula> getAulaById(String idAula);
}