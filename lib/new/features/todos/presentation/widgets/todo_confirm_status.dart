import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/new/features/todos/presentation/viewmodels/todo_page_viewmodel.dart';

import '../../domain/entities/todo.dart';

class TodoConfirmStatus extends StatefulWidget {
  const TodoConfirmStatus({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoConfirmStatus> createState() => _TodoConfirmStatusState();
}

class _TodoConfirmStatusState extends State<TodoConfirmStatus> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Status Todo'),
      content: const Text('Are you sure to change status this todo?'),
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
                      await viewmodel.changeTodoStatus(id);

                      if (!mounted) return;

                      navigator.pop(true);
                      messenger.showSnackBar(
                        SnackBar(
                          content: const Text('Change status todo success'),
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
                    Navigator.of(context).pop(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        duration: const Duration(seconds: 2),
                        content: const Text('Cannot change todo without id'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Sure',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
    );
  }
}
