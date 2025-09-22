import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo.dart';

class ToDoCard extends StatelessWidget {
  final ToDo toDo;

  const ToDoCard({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(toDo.title),
        trailing: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        ),
      ),
    );
  }
}
