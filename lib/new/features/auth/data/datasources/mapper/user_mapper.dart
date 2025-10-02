import 'package:to_do_app/new/features/auth/data/models/auth_user_model.dart';
import 'package:to_do_app/new/features/auth/domain/entities/auth_user.dart';

extension AuthUserModelMapper on AuthUserModel {
  AuthUser toEntity() {
    return AuthUser(id: id, token: token);
  }
}

extension AuthUserEntitiyMapper on AuthUser {
  AuthUserModel toModel() {
    return AuthUserModel(id: id, token: token);
  }
}
