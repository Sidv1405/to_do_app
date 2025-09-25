import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/api_service.dart';
import '../widgets/todo_card.dart';
import '../widgets/todo_form_dialog.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<TodoListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ApiService apiService = ApiService();
  List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchToDos();
  }

  void fetchToDos() async {
    try {
      final result = await apiService.fetchTodos();
      setState(() {
        isLoading = false;
        todos = result;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorSnackBar('Error fetch todos: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Try again',
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: fetchToDos,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showDialogAddToDo() async {
    final result = await showDialog<Todo>(
      context: context,
      builder: (context) => const TodoFormDialog(),
    );

    if (result != null) {
      addTodo(result);
    }
  }

  void showDialogEditToDo(Todo todo) async {
    final result = await showDialog<Todo>(
      context: context,
      builder: (context) => TodoFormDialog(todo: todo),
    );

    if (result != null) {
      updateTodo(result);
    }
  }

  void addTodo(Todo newTodo) async {
    try {
      final addedTodo = await apiService.addToDo(newTodo);
      if (addedTodo != null) {
        setState(() {
          todos.insert(0, addedTodo);
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error add new todo: $e');
    }
  }

  void updateTodo(Todo updatedTodo) async {
    try {
      final result = await apiService.updateTodo(updatedTodo);
      if (result != null) {
        setState(() {
          final index = todos.indexWhere((todo) => todo.id == result.id);
          if (index != -1) {
            todos[index] = result;
          }
        });
      }
    } catch (e) {
      _showErrorSnackBar('Error update todo: $e');
    }
  }

  void toggleTodoStatus(Todo todo) async {
    try {
      final updatedTodo = todo.copyWith(
        isDone: !todo.isDone,
        completedAt: !todo.isDone ? DateTime.now() : null,
      );

      final result = await apiService.updateTodo(updatedTodo);
      if (result != null) {
        setState(() {
          final index = todos.indexWhere((t) => t.id == result.id);
          if (index != -1) {
            todos[index] = result;
          }
        });

        _showSuccessSnackBar(
          result.isDone ? 'Todo was done!' : 'Change to was not done!',
        );
      }
    } catch (e) {
      _showErrorSnackBar('Error change status todo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Todo list'),
        actions: [
          IconButton(
            onPressed: fetchToDos,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No todos yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Press the + button to add a new todo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async => fetchToDos(),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];
                  return TodoCard(
                    key: ValueKey(todo.id),
                    todo: todo,
                    onToggle: () => toggleTodoStatus(todo),
                    onEdit: () => showDialogEditToDo(todo),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogAddToDo,
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
