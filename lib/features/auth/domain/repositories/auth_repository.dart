import 'package:tfg_app/features/auth/domain/domain.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String username, bool admin);
  Future<User> checkAuthStatus(String token);
}