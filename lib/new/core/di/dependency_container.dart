import 'package:get_it/get_it.dart';
import 'package:to_do_app/new/core/constants/api_constants.dart';
import 'package:to_do_app/new/core/network/dio_client.dart';
import 'package:to_do_app/new/core/network/dio_helper.dart';
import 'package:to_do_app/new/core/service/api_service.dart';
import 'package:to_do_app/new/features/todos/data/datasources/remote/todo_remote_data_source.dart';
import 'package:to_do_app/new/features/todos/data/datasources/remote/todo_remote_data_source_impl.dart';
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

import '../service/auth_service.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Auth DioClient
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(DioHelper.buildDio(baseUrl: Constants.authBaseURL)),
    instanceName: 'auth',
  );

  // AuthService
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(dioClient: getIt<DioClient>(instanceName: 'auth')),
  );

  // Todos DioClient
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(DioHelper.buildDio(baseUrl: Constants.todoBaseURL)),
    instanceName: 'todos',
  );

  // ApiService
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dioClient: getIt<DioClient>(instanceName: 'todos')),
  );

  // RemoteDataSource
  getIt.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  // Repository
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: getIt<TodoRemoteDataSource>()),
  );

  // UseCases
  getIt.registerLazySingleton<AddTodoUseCase>(
    () => AddTodoUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<ClearCompletedTodosUseCase>(
    () => ClearCompletedTodosUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<FilterTodosUseCase>(
    () => FilterTodosUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<SearchTodosUseCase>(
    () => SearchTodosUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<SortTodosUseCase>(
    () => SortTodosUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<ToggleTodoUseCase>(
    () => ToggleTodoUseCase(repository: getIt<TodoRepository>()),
  );
  getIt.registerLazySingleton<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(repository: getIt<TodoRepository>()),
  );

  // ViewModel
  getIt.registerLazySingleton<TodoPageViewmodel>(
    () => TodoPageViewmodel(
      clearCompletedTodosUseCase: getIt<ClearCompletedTodosUseCase>(),
      filterTodosUseCase: getIt<FilterTodosUseCase>(),
      searchTodosUseCase: getIt<SearchTodosUseCase>(),
      sortTodosUseCase: getIt<SortTodosUseCase>(),
      todoRepository: getIt<TodoRepository>(),
      addTodoUseCase: getIt<AddTodoUseCase>(),
    ),
  );
}
