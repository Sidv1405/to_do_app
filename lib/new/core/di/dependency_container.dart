import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_do_app/new/core/constants/api_constants.dart';
import 'package:to_do_app/new/core/network/dio_client.dart';
import 'package:to_do_app/new/core/network/dio_helper.dart';
import 'package:to_do_app/new/core/service/api_service.dart';
import 'package:to_do_app/new/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:to_do_app/new/features/todos/domain/repositories/todo_repository.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/add_todo_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/clear_completed_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/filter_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/search_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/sort_todos_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/toggle_todo_usecase.dart';
import 'package:to_do_app/new/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:to_do_app/new/features/todos/presentation/viewmodels/todo_page_viewmodel.dart';

List<SingleChildWidget> providers = [
  ///DioClientProvider
  Provider<DioClient>(
    create: (_) => DioClient(DioHelper.buildDio(baseUrl: Constants.baseURL)),
  ),

  ///ApiServiceProvider
  ProxyProvider<DioClient, ApiService>(
    update: (_, dioClient, _) => ApiService(dioClient: dioClient),
  ),

  ///RepositoryProvider
  ProxyProvider<ApiService, TodoRepository>(
    update: (_, apiService, _) => TodoRepositoryImpl(apiService: apiService),
  ),

  ///UseCaseProvider
  Provider<AddTodoUseCase>(
    create: (context) =>
        AddTodoUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<ClearCompletedTodosUseCase>(
    create: (context) =>
        ClearCompletedTodosUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<FilterTodosUseCase>(
    create: (context) =>
        FilterTodosUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<SearchTodosUseCase>(
    create: (context) =>
        SearchTodosUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<SortTodosUseCase>(
    create: (context) =>
        SortTodosUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<ToggleTodoUseCase>(
    create: (context) =>
        ToggleTodoUseCase(repository: context.read<TodoRepository>()),
  ),
  Provider<UpdateTodoUseCase>(
    create: (context) =>
        UpdateTodoUseCase(repository: context.read<TodoRepository>()),
  ),

  ///ViewModelProvider
  ChangeNotifierProvider(
    create: (context) => TodoPageViewmodel(
      clearCompletedTodosUseCase: context.read<ClearCompletedTodosUseCase>(),
      filterTodosUseCase: context.read<FilterTodosUseCase>(),
      searchTodosUseCase: context.read<SearchTodosUseCase>(),
      sortTodosUseCase: context.read<SortTodosUseCase>(),
      todoRepository: context.read<TodoRepository>(),
    ),
  ),
];
