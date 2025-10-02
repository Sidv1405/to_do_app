import 'package:to_do_app/new/features/todos/data/datasources/remote/todo_remote_data_source.dart';
import 'package:to_do_app/new/features/todos/data/mappers/todo_mapper.dart';
import 'package:to_do_app/new/features/todos/domain/entities/todo.dart';
import 'package:to_do_app/new/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Todo> addTodo(
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) async {
    final model = await remoteDataSource.addTodo(
      title,
      description,
      createdAt,
      dueDate,
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteTodo(String id) => remoteDataSource.deleteTodo(id);

  @override
  Future<List<Todo>> getTodos() async {
    final models = await remoteDataSource.getTodos();
    return models.toEntityList().toList();
  }

  @override
  Future<Todo> getTodoById(String id) async {
    final todos = await getTodos();
    return todos.firstWhere((t) => t.id == id);
  }

  // @override
  // Future<List<Todo>> searchTodosByTitle(String query, List<Todo> source) async {
  //   if (query.isEmpty) return source;
  //   final searchLower = query.toLowerCase();
  //   return source.where((todo) {
  //     return todo.title.toLowerCase().contains(searchLower) ||
  //         todo.description.toLowerCase().contains(searchLower);
  //   }).toList();
  // }

  @override
  Future<List<Todo>> searchTodosByTitle(String query) async {
    final todos = await getTodos();
    return todos.where((t) => t.title.contains(query)).toList();
  }

  @override
  Future<Todo> updateTodo(
    String id,
    String title,
    String description,
    DateTime createdAt,
    DateTime dueDate,
  ) async {
    final model = await remoteDataSource.updateTodo(
      id,
      title,
      description,
      createdAt,
      dueDate,
    );
    return model.toEntity();
  }

  @override
  Future<Todo> changeTodoStatus(String id) async {
    final todo = await getTodoById(id);
    final updated = await remoteDataSource.changeTodoStatus(id, !todo.isDone);
    return updated.toEntity();
  }

  @override
  Future<void> clearCompletedTodos() {
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> filterTodosByStatus(String status) {
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> sortTodosByDate(String dateType) {
    throw UnimplementedError();
  }
}
