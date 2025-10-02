import 'package:to_do_app/new/core/service/auth_service.dart';
import 'package:to_do_app/new/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:to_do_app/new/features/auth/data/models/auth_user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService authService;

  AuthRemoteDataSourceImpl({required this.authService});

  @override
  Future<AuthUserModel> register(String email, String password) async {
    final data = await authService.register(email, password);
    return AuthUserModel.fromJson(data);
  }
}
