import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasDatasource {
  Future<List<Escuela>> getAllEscuelas();
  Future<Escuela> getEscuelaById(String id);
  Future<Escuela> getEscuelaByUserId(String id);
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
  Future<Aula> getAulaById(String idAula);
  Future<List<Reserva>> getReservasByDate(String date);
  Future<List<Reserva>> getReservasByUserId(String id);
  Future<Reserva> postReserva(Reserva newReserva);
  Future<Escuela> createUpdateEscuela(Map<String, dynamic> escuelaLike);
  Future<Aula> createUpdateAula(Map<String, dynamic> aulaLike);
}