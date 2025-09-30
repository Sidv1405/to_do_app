import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(todo.description),
            const SizedBox(height: 16),
            Text("Created: ${todo.createdAt}"),
            Text("Due: ${todo.dueDate}"),
            if (todo.isDone) Text("✅ Completed at: ${todo.completedAt}"),
          ],
        ),
      ),
    );
  }
}
