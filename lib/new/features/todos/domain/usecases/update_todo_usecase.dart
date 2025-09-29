import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase({required this.repository});

  Future<Todo> call(Todo todo) async {
    if (todo.title.trim().isEmpty || todo.title.trim().length < 3) {
      throw ArgumentError('Invalid title');
    }
    if (todo.description.trim().isEmpty) {
      throw ArgumentError('Description is required');
    }

    return await repository.updateTodo(
      todo.id!,
      todo.title,
      todo.description,
      todo.createdAt,
      todo.dueDate,
    );
  }
}
