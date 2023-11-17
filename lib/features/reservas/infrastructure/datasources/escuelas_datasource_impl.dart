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
  Future<Reserva> postReserva(Reserva newReserva) async{
    try {
      final response = await dio.post('/reservas/newReserva', data: newReserva.toJson());
      final reserva = Reserva.fromJson(response.data);
      return reserva;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Escuela> getEscuelaById(String id) async{
    try {
      final response = await dio.get('/escuelas/getEscuelaById/$id');
      final escuela = Escuela.fromJson(response.data);
      return escuela;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Escuela> getEscuelaByUserId(String id) async{
    try {
      final response = await dio.get('/escuelas/getEscuelaByUserId/$id');
      final escuela = Escuela.fromJson(response.data);
      return escuela;
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


  Future<String> _uploadPhoto(String path) async{
    try {
      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName)
      });
      final response = await dio.post('/escuelas/uploadImage', data: data);
      if (response.statusCode == 200) {
        return response.data['fileName'];
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Escuela> createUpdateEscuela(Map<String, dynamic> escuelaLike) async {
    try {

      final String? escuelaId = escuelaLike['id'];
      final String method = escuelaId == null ? 'POST' : 'PATCH';
      final String url = escuelaId == null ? '/escuelas/newEscuela' : '/escuelas/updateEscuelas/$escuelaId';

      escuelaLike.remove('id');
      String fileImage = await _uploadPhoto(escuelaLike['imagen']);
      escuelaLike['imagen'] = fileImage;

      final response = await dio.request(
        url,
        data: escuelaLike,
        options: Options(
          method: method
        )
      );

      final escuela = Escuela.fromJson(response.data);
      return escuela;
      
    } catch (e) {
      throw Exception();
    }
  }
  
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
  
}