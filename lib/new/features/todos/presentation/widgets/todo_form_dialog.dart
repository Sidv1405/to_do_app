import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/todo.dart';
import '../viewmodels/todo_page_viewmodel.dart';
import 'date_pick_form.dart';

class TodoFormDialog extends StatefulWidget {
  const TodoFormDialog({super.key, this.todo});

  final Todo? todo;

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  DateTime? _createdAt;
  DateTime? _dueDate;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
    _createdAt = widget.todo?.createdAt;
    _dueDate = widget.todo?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  String? _validateTitle(String? title) {
    if (title == null || title.trim().isEmpty) return 'Title is required';
    if (title.trim().length < 3) return 'Title must be at least 3 characters';
    return null;
  }

  String? _validateDescription(String? description) {
    if (description == null || description.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final viewModel = context.read<TodoPageViewmodel>();
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);

      if (widget.todo == null) {
        await viewModel.addTodo(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          createAt: _createdAt!,
          dueDate: _dueDate!,
        );
      } else {
        await viewModel.updateTodo(
          id: widget.todo!.id!,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          createdAt: _createdAt!,
          dueDate: _dueDate!,
        );
      }

      if (!mounted) return;
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            widget.todo == null
                ? 'Add new todo successfully!'
                : 'Update todo successfully!',
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoPageViewmodel>();

    return AlertDialog(
      title: Text(widget.todo == null ? 'Add new todo' : 'Update todo'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: viewModel.isMutating,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    TextFormField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      validator: _validateTitle,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_descriptionFocusNode),
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter todo title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      focusNode: _descriptionFocusNode,
                      validator: _validateDescription,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter todo description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Created At,
                    DateFormField(
                      initialValue: _createdAt,
                      label: 'Start Date',
                      validator: (date) =>
                          date == null ? 'Start Date is required' : null,
                      onChanged: (date) => _createdAt = date,
                    ),
                    const SizedBox(height: 16),
                    DateFormField(
                      initialValue: _dueDate,
                      label: 'Due Date',
                      validator: (date) {
                        if (date == null) return 'Due Date is required';
                        if (_createdAt != null && date.isBefore(_createdAt!)) {
                          return 'Due Date cannot be before Start Date';
                        }
                        return null;
                      },
                      onChanged: (date) => _dueDate = date,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: viewModel.isMutating
              ? null
              : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: viewModel.isMutating ? null : _submit,
          child: Text(widget.todo == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
