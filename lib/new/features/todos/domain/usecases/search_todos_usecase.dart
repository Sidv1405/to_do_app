import '../repositories/todo_repository.dart';

class SearchTodosUseCase {
  final TodoRepository repository;

  SearchTodosUseCase({required this.repository});
}
