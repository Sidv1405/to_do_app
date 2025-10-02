import 'package:flutter/material.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/user_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  AuthViewModel({required this.userRepository});

  bool isLoading = false;
  String? errorMessage;
  AuthUser? user;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Gọi repository
      // final AuthUser loggedInUser = await userRepository.login(email, password);

      // user = loggedInUser;

      isLoading = false;
      notifyListeners();

      // Login thành công
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void logout() {
    user = null;
    notifyListeners();
    // TODO: Xóa token từ SharedPreferences nếu lưu
  }
}
