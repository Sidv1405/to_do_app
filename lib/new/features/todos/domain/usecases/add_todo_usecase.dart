import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase({required this.repository});
}
