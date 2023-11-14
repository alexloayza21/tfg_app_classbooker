import 'package:dio/dio.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:tfg_app/features/auth/domain/entities/user.dart';

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

    } catch (e) {
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

    } catch (e) {
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