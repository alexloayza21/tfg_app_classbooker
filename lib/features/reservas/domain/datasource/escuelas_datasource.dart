import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class EscuelasDatasource {
  Future<List<Escuela>> getAllEscuelas();
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela);
  Future<Aula> getAulaById(String idAula);
  Future<List<Reserva>> getReservasByDate(String date);
}