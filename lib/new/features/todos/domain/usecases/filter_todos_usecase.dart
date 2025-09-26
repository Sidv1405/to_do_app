import '../repositories/todo_repository.dart';

class FilterTodosUseCase {
  final TodoRepository repository;

  FilterTodosUseCase({required this.repository});
}
