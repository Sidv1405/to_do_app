import 'package:flutter/cupertino.dart';
import 'package:to_do_app/new/features/todos/domain/entities/todo.dart';
import 'package:to_do_app/new/features/todos/domain/repositories/todo_repository.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/clear_completed_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/filter_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/search_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/sort_todos_usecase.dart';

import '../../domain/usecases/add_todo_usecase.dart';

class TodoPageViewmodel extends ChangeNotifier {
  final ClearCompletedTodosUseCase clearCompletedTodosUseCase;
  final FilterTodosUseCase filterTodosUseCase;
  final SearchTodosUseCase searchTodosUseCase;
  final SortTodosUseCase sortTodosUseCase;
  final TodoRepository todoRepository;
  final AddTodoUseCase addTodoUseCase;

  TodoPageViewmodel({
    required this.clearCompletedTodosUseCase,
    required this.filterTodosUseCase,
    required this.searchTodosUseCase,
    required this.sortTodosUseCase,
    required this.todoRepository,
    required this.addTodoUseCase,
  });

  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  bool _isFetching = false;
  bool _isMutating = false;
  String _errorMessage = '';
  bool _isSearching = false;

  List<Todo> get filteredTodos => _filteredTodos;

  bool get isSearching => _isSearching;

  List<Todo> get todos => _todos;

  bool get isFetching => _isFetching;

  bool get isMutating => _isMutating;

  String get errorMessage => _errorMessage;

  set filteredTodos(List<Todo> value) {
    _filteredTodos = value;
  }

  set isSearching(bool value) {
    _isSearching = value;
  }

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  set isMutating(bool value) {
    _isMutating = value;
    notifyListeners();
  }

  set todos(List<Todo> value) {
    _todos = value;
    notifyListeners();
  }

  Future<void> getTodos() async {
    isFetching = true;
    try {
      todos = await todoRepository.getTodos();
      _filteredTodos = _todos;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isFetching = false;
    }
  }

  Future<void> addTodo({
    required String title,
    required String description,
    required DateTime createAt,
    required DateTime dueDate,
  }) async {
    try {
      _isMutating = true;
      notifyListeners();

      final todo = await addTodoUseCase(
        title: title,
        description: description,
        createAt: createAt,
        dueDate: dueDate,
      );
      _todos = [..._todos, todo];
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _isMutating = false;
      notifyListeners();
    }
  }

  Future<void> updateTodo({
    required String id,
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime dueDate,
  }) async {
    try {
      _isMutating = true;
      notifyListeners();

      final updatedTodo = await todoRepository.updateTodo(
        id,
        title,
        description,
        createdAt,
        dueDate,
      );
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = updatedTodo;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _isMutating = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _isMutating = true;
      notifyListeners();

      await todoRepository.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _isMutating = false;
      notifyListeners();
    }
  }

  Future<void> changeTodoStatus(String id) async {
    try {
      _isMutating = true;
      notifyListeners();

      final changeTodoStatus = await todoRepository.changeTodoStatus(id);

      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = changeTodoStatus;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _isMutating = false;
      notifyListeners();
    }
  }

  void searchTodos(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      _filteredTodos = _todos;
    } else {
      todoRepository
          .searchTodosByTitle(q)
          .then((result) {
            _filteredTodos = result;
            notifyListeners();
          })
          .catchError((e) {
            errorMessage = e.toString();
          });
    }

    _isSearching = true;
    notifyListeners();
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _filteredTodos = _todos;
    }
    notifyListeners();
  }

  void clearSearch() {
    _isSearching = false;
    _filteredTodos = _todos;
    notifyListeners();
  }
}
