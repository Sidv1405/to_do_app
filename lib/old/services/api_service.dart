import 'package:dio/dio.dart';

import '../models/todo.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://68d424e3214be68f8c68888c.mockapi.io/api/v1/todos";

  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Todo.fromJson(e)).toList();
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<Todo?> addToDo(Todo newTodo) async {
    try {
      final response = await _dio.post(baseUrl, data: newTodo.toJson());
      if (response.statusCode == 201) {
        return Todo.fromJson(response.data);
      } else {
        throw Exception('Failed to add todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<Todo?> updateTodo(Todo todo) async {
    if (todo.id == null) {
      throw Exception('Todo ID is null');
    }

    try {
      final response = await _dio.put(
        '$baseUrl/${todo.id}',
        data: todo.toJson(),
      );
      if (response.statusCode == 200) {
        return Todo.fromJson(response.data);
      } else {
        throw Exception('Failed to update todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }
}
