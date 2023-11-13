import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasRepository {
  Future<List<Escuela>> getAllEscuelas();
  Future<Escuela> getEscuelaById(String id);
  Future<Escuela> postEscuela(Escuela newEscuela);
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
  Future<Aula> getAulaById(String idAula);
  Future<List<Reserva>> getReservasByDate(String date);
  Future<Reserva> postReserva(Reserva newReserva);
}