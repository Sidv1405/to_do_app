import 'package:to_do_app/new/features/auth/data/datasources/mapper/user_mapper.dart';
import 'package:to_do_app/new/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:to_do_app/new/features/auth/domain/entities/auth_user.dart';
import 'package:to_do_app/new/features/auth/domain/repositories/user_repository.dart';

import '../models/auth_user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser> register(String email, String password) async {
    final AuthUserModel userModel = await remoteDataSource.register(
      email,
      password,
    );

    return userModel.toEntity();
  }
}
