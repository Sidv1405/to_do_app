import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/services/api_service.dart';
import 'package:to_do_app/widgets/add_todo_dialog.dart';
import 'package:to_do_app/widgets/todo_card.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() {
    return _ToDoListScreenState();
  }
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final ApiService apiService = ApiService();
  List<ToDo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchToDos();
  }

  void fetchToDos() async {
    final result = await apiService.fetchToDos();
    setState(() {
      isLoading = false;
      todos = result;
    });
  }

  void showDialogAddToDo() async {
    final TextEditingController dialogController = TextEditingController();
    final result = await showDialog<ToDo>(
      context: context,
      builder: (context) => TodoAddDialog(controller: dialogController),
    );

    if (result != null) {
      addTodo(result);
    }
  }

  void addTodo(ToDo newTodo) async {
    try {
      final addedTodo = await apiService.addToDo(newTodo);
      setState(() {
        todos.insert(0, addedTodo!);
      });
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todos[index];
                return ToDoCard(toDo: todo);
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: showDialogAddToDo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
