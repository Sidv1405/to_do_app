import '../repositories/todo_repository.dart';

class ClearCompletedTodosUseCase {
  final TodoRepository repository;

  ClearCompletedTodosUseCase({required this.repository});
}
