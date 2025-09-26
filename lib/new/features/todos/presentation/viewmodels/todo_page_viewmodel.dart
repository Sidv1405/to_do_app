import 'package:flutter/cupertino.dart';
import 'package:to_do_app/new/features/todos/domain/entities/todo.dart';
import 'package:to_do_app/new/features/todos/domain/repositories/todo_repository.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/clear_completed_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/filter_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/search_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/sort_todos_usecase.dart';

class TodoPageViewmodel extends ChangeNotifier {
  final ClearCompletedTodosUseCase clearCompletedTodosUseCase;
  final FilterTodosUseCase filterTodosUseCase;
  final SearchTodosUseCase searchTodosUseCase;
  final SortTodosUseCase sortTodosUseCase;
  final TodoRepository todoRepository;

  TodoPageViewmodel({
    required this.clearCompletedTodosUseCase,
    required this.filterTodosUseCase,
    required this.searchTodosUseCase,
    required this.sortTodosUseCase,
    required this.todoRepository,
  });

  List<Todo> _todos = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Todo> get todos => _todos;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set todos(List<Todo> value) {
    _todos = value;
    notifyListeners();
  }
}
