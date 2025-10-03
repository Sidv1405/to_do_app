import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/new/core/router/app_router.dart';

import 'core/constants/api_constants.dart';
import 'core/di/dependency_container.dart';
import 'core/network/dio_client.dart';
import 'core/network/dio_helper.dart';
import 'core/service/api_service.dart';
import 'core/service/auth_service.dart';
import 'core/utils/create_text_theme.dart';
import 'features/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'features/todos/data/datasources/remote/todo_remote_data_source_impl.dart';
import 'features/todos/data/repositories/todo_repository_impl.dart';
import 'features/todos/domain/repositories/todo_repository.dart';
import 'features/todos/domain/usecases/add_todo_usecase.dart';
import 'features/todos/domain/usecases/clear_completed_todos_usecase.dart';
import 'features/todos/domain/usecases/filter_todos_usecase.dart';
import 'features/todos/domain/usecases/search_todos_usecase.dart';
import 'features/todos/domain/usecases/sort_todos_usecase.dart';
import 'features/todos/domain/usecases/toggle_todo_usecase.dart';
import 'features/todos/domain/usecases/update_todo_usecase.dart';
import 'features/todos/presentation/theme/theme.dart';
import 'features/todos/presentation/viewmodels/todo_page_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final materialTheme = MaterialTheme(textTheme);

    return MultiProvider(
      providers: [
        // Repository
        Provider<UserRepository>(
          create: (_) => UserRepositoryImpl(
            remoteDataSource: AuthRemoteDataSourceImpl(
              authService: AuthService(
                dioClient: DioClient(
                  DioHelper.buildDio(baseUrl: Constants.authBaseURL),
                ),
              ),
            ),
          ),
        ),
        Provider<TodoRepository>(
          create: (_) => TodoRepositoryImpl(
            remoteDataSource: TodoRemoteDataSourceImpl(
              apiService: ApiService(
                dioClient: DioClient(
                  DioHelper.buildDio(baseUrl: Constants.todoBaseURL),
                ),
              ),
            ),
          ),
        ),

        // UseCases
        Provider(create: (ctx) => AddTodoUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => ClearCompletedTodosUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => FilterTodosUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => SearchTodosUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => SortTodosUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => ToggleTodoUseCase(repository: ctx.read<TodoRepository>())),
        Provider(create: (ctx) => UpdateTodoUseCase(repository: ctx.read<TodoRepository>())),

        // ViewModels
        ChangeNotifierProvider(
          create: (ctx) => AuthViewModel(userRepository: ctx.read<UserRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TodoPageViewmodel(
            clearCompletedTodosUseCase: ctx.read<ClearCompletedTodosUseCase>(),
            filterTodosUseCase: ctx.read<FilterTodosUseCase>(),
            searchTodosUseCase: ctx.read<SearchTodosUseCase>(),
            sortTodosUseCase: ctx.read<SortTodosUseCase>(),
            todoRepository: ctx.read<TodoRepository>(),
            addTodoUseCase: ctx.read<AddTodoUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Auth Todo App',
        routerConfig: AppRouter.router,
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
