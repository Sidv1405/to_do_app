import '../entities/todo.dart';

abstract class TodoRepository {
  /// get list todos
  Future<List<Todo>> getTodos();

  /// add a new todo
  Future<Todo> addTodo(String title, String description);

  /// Change toggle status of todo ( done / not done )
  Future<Todo> toggleTodo(String id);

  /// delete a todo
  Future<void> deleteTodo(String id);

  /// update title and description a todo
  Future<Todo> updateTodo(String id, String title, String description);

  /// get a todo by id
  Future<Todo> getTodoById(String id);

  /// delete all todos when they are completed
  Future<void> clearCompletedTodos();

  /// find todos by title or description
  Future<List<Todo>> searchTodos(String query);

  /// Filter todos by their status (all, completed, not completed)
  Future<List<Todo>> filterTodosByStatus(String status);

  /// Sort todos by created date or due date
  Future<List<Todo>> sortTodosByDate(String dateType);
}
