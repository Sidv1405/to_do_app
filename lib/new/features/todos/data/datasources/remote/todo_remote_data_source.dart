import 'package:to_do_app/new/features/todos/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> addTodo(
      String title,
      String description,
      DateTime createdAt,
      DateTime dueDate,
      );
  Future<TodoModel> updateTodo(
      String id,
      String title,
      String description,
      DateTime createdAt,
      DateTime dueDate,
      );
  Future<void> deleteTodo(String id);
  Future<TodoModel> changeTodoStatus(String id, bool isDone);
}
