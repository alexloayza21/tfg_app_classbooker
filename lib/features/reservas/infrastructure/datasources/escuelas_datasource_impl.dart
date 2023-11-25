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
      final response = await dio.get('/escuelas/getEscuelaByIdUser/$id');
      final escuela = Escuela.fromJson(response.data);
      return escuela;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Escuela> deleteEscuela(String id) async{
    try {
      final response = await dio.delete('/escuelas/deleteEscuela/$id');
      final escuela = Escuela.fromJson(response.data);
      return escuela;
    } catch (e) {
     throw Exception(e); 
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
      if (escuelaLike["imagen"].toString().contains('/')) {
        String fileImage = await _uploadPhoto(escuelaLike['imagen']);
        escuelaLike['imagen'] = fileImage;
      }

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
      throw Exception(e);
    }
  }
  
}