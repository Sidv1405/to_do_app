import 'package:to_do_app/new/core/service/api_service.dart';
import 'package:to_do_app/new/features/todos/data/mappers/todo_mapper.dart';
import 'package:to_do_app/new/features/todos/domain/entities/todo.dart';

import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ApiService apiService;

  TodoRepositoryImpl({required this.apiService});

  @override
  Future<Todo> addTodo(
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) async {
    final newTodo = await apiService.addTodo(
      title,
      description,
      createdAt,
      dueDate,
    );
    return newTodo.toEntity();
  }

  @override
  Future<void> clearCompletedTodos() {
    // TODO: implement clearCompletedTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String id) async {
    final response = await apiService.deleteTodo(id);
    return response;
  }

  @override
  Future<List<Todo>> filterTodosByStatus(String status) {
    // TODO: implement filterTodosByStatus
    throw UnimplementedError();
  }

  @override
  Future<Todo> getTodoById(String id) {
    return getTodos().then(
      (todos) => todos.firstWhere((todo) => todo.id == id),
    );
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todosModel = await apiService.getTodos();
    // map sang domain entity
    final todosDomain = todosModel.toEntityList().toList();
    return todosDomain;
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
  Future<Todo> changeTodoStatus(String id) async {
    final todo = await getTodoById(id);
    final updatedTodo = await apiService.changeTodoStatus(id, !todo.isDone);
    return updatedTodo.toEntity();
  }

  @override
  Future<Todo> updateTodo(
    String id,
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) async {
    final newTodo = await apiService.updateTodo(
      id,
      title,
      description,
      createdAt,
      dueDate,
    );
    return newTodo.toEntity();
  }
}
