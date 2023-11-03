import 'package:dio/dio.dart';
import 'package:tfg_app/config/constants/environment.dart';
import 'package:tfg_app/features/reservas/domain/datasource/escuelas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class EscuelasDatasourceImpl extends EscuelasDatasource {

  late final Dio dio;
  final String accessToken;

  EscuelasDatasourceImpl({
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
  Future<List<Escuela>> getAllEscuelas() async{
    try {
      final response = await dio.get('/escuelas/allEscuelas');
      final List<Escuela> escuelas = [];
      for (final escuela in response.data ?? []) {
        escuelas.add(Escuela.fromJson(escuela));
      }
      return escuelas;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<List<Aula>> getAulasByIdEscuela(String idEscuela) async{
    try {
      final response = await dio.get('/aulas/getAllAulas/$idEscuela');
      final List<Aula> aulas = [];
      for (final aula in response.data ?? []) {
        aulas.add(Aula.fromJson(aula));
      }
      return aulas;
    } catch (e) {
      throw Exception();
    }
  }
  
}