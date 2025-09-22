import 'package:dio/dio.dart';
import 'package:to_do_app/models/todo.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://68d0b3e6e6c0cbeb39a239ee.mockapi.io/api/v1/tasks";

  Future<List<ToDo>> fetchToDos() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => ToDo.fromJson(e)).toList();
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<ToDo?> addToDo(ToDo newTodo) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: newTodo.toJson(),
      );
      if (response.statusCode == 201) {
        return ToDo.fromJson(response.data);
      } else {
        throw Exception('Failed to add todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }
}
