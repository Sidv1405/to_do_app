import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

extension TodoModelMapper on TodoModel {
  Todo toEntity() {
    return Todo(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
      createdAt: createdAt,
      completedAt: completedAt,
      dueDate: dueDate,
    );
  }
}

extension TodoEntityMapper on Todo {
  TodoModel toModel() {
    return TodoModel(
      id: id ?? '',
      title: title,
      description: description,
      isDone: isDone,
      createdAt: createdAt,
      completedAt: completedAt,
      dueDate: dueDate,
    );
  }
}

extension TodoModelListMapper on List<TodoModel> {
  List<Todo> toEntityList() => map((e) => e.toEntity()).toList();
}

extension TodoEntityListMapper on List<Todo> {
  List<TodoModel> toModelList() => map((e) => e.toModel()).toList();
}
