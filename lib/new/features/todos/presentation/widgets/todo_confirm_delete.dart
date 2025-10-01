import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/new/features/todos/presentation/viewmodels/todo_page_viewmodel.dart';

import '../../domain/entities/todo.dart';

class TodoConfirmDelete extends StatefulWidget {
  const TodoConfirmDelete({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoConfirmDelete> createState() {
    return _TodoConfirmDeleteState();
  }
}

class _TodoConfirmDeleteState extends State<TodoConfirmDelete> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Todo'),
      content: const Text('Are you sure you want to delete this todo?'),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: _isProcessing
          ? []
          : [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final viewmodel = context.read<TodoPageViewmodel>();
                  final id = widget.todo.id;

                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);
                  final theme = Theme.of(context);

                  if (id != null) {
                    setState(() => _isProcessing = true);
                    try {
                      await viewmodel.deleteTodo(id);

                      if (!mounted) return;

                      navigator.pop(true);
                      messenger.showSnackBar(
                        SnackBar(
                          content: const Text('Delete todo success'),
                          backgroundColor: theme.colorScheme.primary,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      setState(() => _isProcessing = false);
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } else {
                    navigator.pop(false);
                    messenger.showSnackBar(
                      SnackBar(
                        backgroundColor: theme.colorScheme.primary,
                        duration: const Duration(seconds: 2),
                        content: const Text('Cannot delete todo without id'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                child: Text(
                  'Delete',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
    );
  }
}
