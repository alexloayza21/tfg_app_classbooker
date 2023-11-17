import 'package:tfg_app/features/reservas/domain/datasource/reservas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/entities/reserva.dart';
import 'package:tfg_app/features/reservas/domain/repositories/reservas_repository.dart';

class ReservasRepositoryImpl extends ReservasRepository {

  final ReservasDatasource datasource;

  ReservasRepositoryImpl({required this.datasource});

  @override
  Future<List<Reserva>> getReservasByDate(String date) {
    return datasource.getReservasByDate(date);
  }

  @override
  Future<List<Reserva>> getReservasByUserId(String id) {
    return datasource.getReservasByUserId(id);
  }

  @override
  Future<Reserva> postReserva(Reserva newReserva) {
    return datasource.postReserva(newReserva);
  }
  
}