import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasRepository {
  Future<List<Escuela>> getAllEscuelas();
  Future<Escuela> getEscuelaById(String id);
  Future<Escuela> getEscuelaByUserId(String id);
  // Future<Escuela> postEscuela(Map<String, dynamic> escuelaLike);
  Future<Escuela> postEscuela(Escuela newEscuela);
  Future<Escuela> updateEscuela(Map<String, dynamic> escuelaLike);
  Future<Escuela> deleteEscuela(String id);
}