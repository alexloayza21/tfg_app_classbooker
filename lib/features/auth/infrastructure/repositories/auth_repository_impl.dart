import 'package:tfg_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:tfg_app/features/auth/domain/entities/user.dart';
import 'package:tfg_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tfg_app/features/auth/infrastructure/datasource/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl(
    {AuthDataSource? dataSource}
  ) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String username, bool admin) {
    return dataSource.register(email, password, username, admin);
  }
  
}