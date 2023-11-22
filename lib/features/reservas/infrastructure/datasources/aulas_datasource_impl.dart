import 'package:dio/dio.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/reservas/domain/datasource/aulas_datasource.dart';
import 'package:tfg_app/features/reservas/domain/entities/aula.dart';

class AulasDatasourceImpl extends AulasDatasource {

  late final Dio dio;
  final String accessToken;

  AulasDatasourceImpl({
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
  Future<Aula> createUpdateAula(Map<String, dynamic> aulaLike) async{
    try {

      final String? idAula = aulaLike['id'];
      final String method = idAula == null ? 'POST' : 'PATCH';
      final String url = idAula == null ? '/aulas/newAula' : '/aulas/updateAula/$idAula';

      aulaLike.remove('id');

      final response = await dio.request(
        url,
        data: aulaLike,
        options: Options(
          method: method
        )
      );

      final aula = Aula.fromJson(response.data);
      return aula;
      
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Aula> getAulaById(String idAula) async{
    try {
      final response = await dio.get('/aulas/getAulaById/$idAula');
      final aula = Aula.fromJson(response.data);
      return aula;
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
  
  @override
  Future<Aula> deleteAulaById(String idAula) async{
    try {
      final response = await dio.delete('/aulas/deleteAula/$idAula');
      final aula = Aula.fromJson(response.data);
      return aula;
    } catch (e) {
      throw Exception(e);
    }
  }
  
}