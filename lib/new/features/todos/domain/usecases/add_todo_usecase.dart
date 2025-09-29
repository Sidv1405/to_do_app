import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase({required this.repository});

  Future<Todo> call({
    String? id,
    required String title,
    required String description,
    required DateTime createAt,
    required DateTime dueDate,
  }) async {
    if (title.trim().isEmpty || title.trim().length < 3) {
      throw ArgumentError('Invalid title');
    }
    if (description.trim().isEmpty) {
      throw ArgumentError('Description is required');
    }
    if (dueDate.isBefore(createAt)) {
      throw ArgumentError('Due date must be after create date');
    }

    final todo = Todo(
      id: id,
      title: title.trim(),
      description: description.trim(),
      isDone: false,
      createdAt: createAt,
      dueDate: dueDate,
    );

    return await repository.addTodo(
      todo.title,
      todo.description,
      todo.createdAt,
      todo.dueDate,
    );
  }
}
