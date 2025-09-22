import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';

class TodoAddDialog extends StatelessWidget {
  final TextEditingController controller;

  const TodoAddDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new todo'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter todo title',
            border: OutlineInputBorder(),
          ),
          controller: controller,
        ),
      ),
      actions: [
        TextButton(onPressed: () => submit(context), child: const Text('Add')),
      ],
    );
  }

  void submit(BuildContext context) {
    if (controller.text.isNotEmpty) {
      final newTodo = ToDo(title: controller.text);
      Navigator.of(context).pop(newTodo);
    } else {
      Navigator.of(context).pop();
    }
  }
}
