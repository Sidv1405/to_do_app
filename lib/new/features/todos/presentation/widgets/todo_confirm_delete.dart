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
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final viewmodel = context.read<TodoPageViewmodel>();
                  final id = widget.todo.id;
                  if (id != null) {
                    setState(() => _isProcessing = true);
                    // try {
                    viewmodel.deleteTodo(id);
                    Navigator.of(context).pop(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Delete todo success'),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    // } catch (e) {
                    //   if (!mounted) return;
                    //   setState(() => _isProcessing = false);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('Error: $e'),
                    //       backgroundColor: Colors.red,
                    //       duration: const Duration(seconds: 2),
                    //       behavior: SnackBarBehavior.floating,
                    //     ),
                    //   );
                    // }
                  } else {
                    Navigator.of(context).pop(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
