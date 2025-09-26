import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';

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

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  // DateTime? _selectDateTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );
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
    if (title == null || title.trim().isEmpty) {
      return 'Title is required';
    }
    if (title.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  String? _validateDescription(String? description) {
    if (description == null || description.trim().isEmpty) {
      return 'description is required';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newTodo = Todo(
        id: widget.todo?.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        isDone: widget.todo?.isDone ?? false,
        createdAt: widget.todo?.createdAt,
        completedAt: widget.todo?.completedAt,
      );

      Navigator.of(context).pop(newTodo);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.todo == null
                ? 'Add new todo successfully!'
                : 'Update todo successfully!',
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new todo'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                validator: _validateTitle,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter todo title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),

              const SizedBox(height: 16),

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
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Cancel'),
                backgroundColor: Theme.of(context).colorScheme.primary,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(widget.todo == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
