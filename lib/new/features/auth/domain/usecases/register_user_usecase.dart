import '../entities/auth_user.dart';
import '../repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase({required this.repository});

  Future<AuthUser> call({
    required String email,
    required String password,
  }) async {
    if (!_isPasswordStrong(password)) {
      throw ArgumentError(
        "Password must contain at least 8 characters, "
        "1 uppercase letter, 1 number, and 1 special character",
      );
    }

    // Call repository
    return await repository.register( email, password);
  }

  bool _isPasswordStrong(String password) {
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
    );
    final hasMinLength = password.length >= 8;

    return hasUpperCase && hasDigit && hasSpecialChar && hasMinLength;
  }
}
