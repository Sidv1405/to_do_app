import '../entities/auth_user.dart';

abstract class UserRepository {
  Future<AuthUser> register(String email, String password);
}
