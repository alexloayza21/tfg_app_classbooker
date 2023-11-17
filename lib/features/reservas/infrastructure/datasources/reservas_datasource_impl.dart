import 'package:dio/dio.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/reservas/domain/datasource/reservas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/entities/reserva.dart';

class ReservasDatasourceImpl extends ReservasDatasource {

  late final Dio dio;
  final String accessToken;

  ReservasDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );
  
  @override
  Future<List<Reserva>> getReservasByDate(String date) async{
    try {
      final response = await dio.get('/reservas/reservasPorFecha/$date');
      final List<Reserva> reservas = [];
      for (final reserva in response.data ?? []) {
        reservas.add(Reserva.fromJson(reserva));
      }
      return reservas;
    } catch (e) {
      throw Exception();
    }
  }

  
  @override
  Future<List<Reserva>> getReservasByUserId(String id) async{
    try {
      final response = await dio.get('/reservas/reservasByUserId/$id');
      final List<Reserva> reservas = [];
      for (final reserva in response.data ?? []) {
        reservas.add(Reserva.fromJson(reserva));
      }
      return reservas;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Reserva> postReserva(Reserva newReserva) async{
    try {
      final response = await dio.post('/reservas/newReserva', data: newReserva.toJson());
      final reserva = Reserva.fromJson(response.data);
      return reserva;
    } catch (e) {
      throw Exception();
    }
  }
  
}