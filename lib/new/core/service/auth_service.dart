import 'package:to_do_app/new/core/network/dio_client.dart';

class AuthService {
  final DioClient dioClient;

  AuthService({required this.dioClient});

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await dioClient.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    return response; // DummyJSON trả về accessToken, refreshToken, user info
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await dioClient.post(
      '/register',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }
}
