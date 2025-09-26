import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/new/features/todos/presentation/viewmodels/todo_page_viewmodel.dart';
import 'package:to_do_app/new/features/todos/presentation/widgets/todo_form_dialog.dart';

import '../../../../core/di/dependency_container.dart';
import '../widgets/todo_item.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoPageViewmodel>(
      create: (_) => getIt<TodoPageViewmodel>(),
      child: const TodoPageBody(),
    );
  }
}

class TodoPageBody extends StatelessWidget {
  const TodoPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final todoPageViewModel = context.watch<TodoPageViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: todoPageViewModel.getTodos,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Todos',
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (todoPageViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = todoPageViewModel.todos;

          if (todos.isEmpty) {
            return Center(
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Press the + button to add a new todo',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => todoPageViewModel.getTodos(),
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoItem(
                  key: ValueKey(todo.id),
                  todo: todo,
                  onToggle: () {},
                  onEdit: () {},
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const TodoFormDialog(),
          );
        },
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
