import '../../domain/entities/todo.dart';
import '../models/todo_model.dart';

/// -----------------------------
/// Extensions Mapper
/// -----------------------------

/// TodoModel -> Todo (Data -> Domain)
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

/// Todo -> TodoModel (Domain -> Data)
extension TodoEntityMapper on Todo {
  TodoModel toModel() {
    return TodoModel(
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

/// List TodoModel -> List Todo
extension TodoModelListMapper on List<TodoModel> {
  List<Todo> toEntityList() => map((e) => e.toEntity()).toList();
}

/// List Todo -> List TodoModel
extension TodoEntityListMapper on List<Todo> {
  List<TodoModel> toModelList() => map((e) => e.toModel()).toList();
}
