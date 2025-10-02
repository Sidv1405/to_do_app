import '../../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> register(String email, String password);
}
