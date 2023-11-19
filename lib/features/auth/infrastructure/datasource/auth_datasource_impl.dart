import 'package:dio/dio.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:tfg_app/features/auth/domain/entities/user.dart';
import 'package:tfg_app/features/auth/infrastructure/errors/auth_errors.dart';

class AuthDataSourceImpl extends AuthDataSource {
  
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async{
    try {
      final response = await dio.get('/users/auth',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));

      final user = User.fromJson(response.data);
      return user;

    } on DioException catch (e){
      if(e.response?.statusCode == 404){
        throw CustomError(message: e.response?.data["errorMessage"]);
      }
      throw Exception();
    }catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async{
    try {
      final response = await dio.post('/users/signin', data: {
        'email': email,
        'password': password
      });

      final user = User.fromJson(response.data);
      return user;

    } on DioException catch (e){
      if(e.response?.statusCode == 404 || e.response?.statusCode == 401){
        throw CustomError(message: e.response?.data["errorMessage"] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(message: 'Revisar conexión a internet');
      }
      throw Exception();
    }catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<User> register(String email, String password, String username, bool admin) async{
    try {
      final response = await dio.post('/users/signup', data: {
        'username': username,
        'email': email,
        'password': password,
        'admin': admin
      });

      final user = User.fromJson(response.data);
      return user;

    } catch (e) {
      throw Exception();
    }
  }
  
}