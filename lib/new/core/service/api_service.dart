import 'package:to_do_app/new/core/network/dio_client.dart';
import 'package:to_do_app/new/features/todos/data/models/todo_model.dart';

class ApiService {
  final DioClient dioClient;

  ApiService({required this.dioClient});

  Future<List<TodoModel>> getTodos() async {
    final response = await dioClient.get('/todos');
    return (response as List).map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<TodoModel> addTodo(String title, String description) async {
    final response = await dioClient.post(
      '/todos',
      data: {'title': title, 'description': description},
    );
    return TodoModel.fromJson(response);
  }
}
