import 'package:tfg_app/features/reservas/domain/domain.dart';

abstract class ReservasRepository {
  Future<List<Reserva>> getReservasByDate(String date);
  Future<List<Reserva>> getReservasByUserId(String id);
  Future<Reserva> postReserva(Reserva newReserva);
}