import 'package:to_do_app/new/core/service/api_service.dart';
import 'package:to_do_app/new/features/todos/data/models/todo_model.dart';

import 'todo_remote_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final ApiService apiService;

  TodoRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TodoModel>> getTodos() => apiService.getTodos();

  @override
  Future<TodoModel> addTodo(
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) => apiService.addTodo(title, description, createdAt, dueDate);

  @override
  Future<TodoModel> updateTodo(
    String id,
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) => apiService.updateTodo(id, title, description, createdAt, dueDate);

  @override
  Future<void> deleteTodo(String id) => apiService.deleteTodo(id);

  @override
  Future<TodoModel> changeTodoStatus(String id, bool isDone) =>
      apiService.changeTodoStatus(id, isDone);
}
