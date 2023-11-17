import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasRepository {
  Future<List<Escuela>> getAllEscuelas();
  Future<Escuela> getEscuelaById(String id);
  Future<Escuela> getEscuelaByUserId(String id);
  Future<Escuela> createUpdateEscuela(Map<String, dynamic> escuelaLike);
}