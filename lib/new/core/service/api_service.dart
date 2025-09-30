import 'package:to_do_app/new/core/network/dio_client.dart';
import 'package:to_do_app/new/features/todos/data/models/todo_model.dart';

class ApiService {
  final DioClient dioClient;

  ApiService({required this.dioClient});

  Future<List<TodoModel>> getTodos() async {
    final response = await dioClient.get('/todos');
    return (response as List).map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<TodoModel> addTodo(
    String title,
    String description,
    DateTime createAt,
    DateTime dueDate,
  ) async {
    final todo = TodoModel(
      id: '',
      // server sẽ tự sinh id
      title: title,
      description: description,
      isDone: false,
      createdAt: createAt,
      dueDate: dueDate,
    );

    final response = await dioClient.post('/todos', data: todo.toJson());
    return TodoModel.fromJson(response);
  }

  Future<TodoModel> updateTodo(
    String id,
    String title,
    String description,
    DateTime createAt,
    DateTime dueDate,
  ) async {
    final response = await dioClient.put(
      '/todos/$id',
      data: {
        'title': title,
        'description': description,
        'created_at': createAt.toIso8601String(),
        'due_date': dueDate.toIso8601String(),
      },
    );
    return TodoModel.fromJson(response);
  }

  Future<void> deleteTodo(String id) async {
    final response = await dioClient.delete('/todos/$id');
    return response;
  }

  Future<TodoModel> changeTodoStatus(String id, bool isDone) async {
    final response = await dioClient.patch(
      '/todos/$id',
      data: {
        'is_done': isDone,
        'completed_at': isDone ? DateTime.now().millisecondsSinceEpoch : null,
      },
    );
    return TodoModel.fromJson(response);
  }
}
