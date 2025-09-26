import 'package:to_do_app/new/core/service/api_service.dart';
import 'package:to_do_app/new/features/todos/domain/entities/todo.dart';

import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ApiService apiService;

  TodoRepositoryImpl({required this.apiService});

  @override
  Future<Todo> addTodo(String title, String description) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<void> clearCompletedTodos() {
    // TODO: implement clearCompletedTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> filterTodosByStatus(String status) {
    // TODO: implement filterTodosByStatus
    throw UnimplementedError();
  }

  @override
  Future<Todo> getTodoById(String id) {
    // TODO: implement getTodoById
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> searchTodos(String query) {
    // TODO: implement searchTodos
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> sortTodosByDate(String dateType) {
    // TODO: implement sortTodosByDate
    throw UnimplementedError();
  }

  @override
  Future<Todo> toggleTodo(String id) {
    // TODO: implement toggleTodo
    throw UnimplementedError();
  }

  @override
  Future<Todo> updateTodo(String id, String title, String description) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
