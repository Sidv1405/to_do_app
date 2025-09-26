import '../repositories/todo_repository.dart';

class ToggleTodoUseCase {
  final TodoRepository repository;

  ToggleTodoUseCase({required this.repository});
}
