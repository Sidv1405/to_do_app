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
      // print('Login Response: $loggedInUser');

      // user = loggedInUser;

      isLoading = false;
      notifyListeners();

      // Login thành công
      return true;
    } catch (e) {
      print('Login Error: $e');
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Gọi repository
      final AuthUser newUser = await userRepository.register(email, password);

      // In response trả về
      print('Register Response: $newUser');
      print('User Token: ${newUser.token}');
      print('User ID: ${newUser.id}');

      user = newUser;

      isLoading = false;
      notifyListeners();

      // Đăng ký thành công
      return true;
    } catch (e) {
      print('Register Error: $e');
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
