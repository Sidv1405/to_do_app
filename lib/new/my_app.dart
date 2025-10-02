import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/di/dependency_container.dart';
import 'core/utils/create_text_theme.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'features/todos/domain/entities/todo.dart';
import 'features/todos/presentation/pages/todo_details_page.dart';
import 'features/todos/presentation/pages/todo_page.dart';
import 'features/todos/presentation/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final materialTheme = MaterialTheme(textTheme);

    final router = GoRouter(
      initialLocation: '/register',
      routes: [
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const TodoPage(),
          routes: [
            GoRoute(
              path: 'detail',
              builder: (context, state) {
                final todo = state.extra as Todo;
                return TodoDetailPage(todo: todo);
              },
            ),
          ],
        ),
      ],
    );

    return MultiProvider(
      providers: [
        // Sử dụng UserRepository từ GetIt
        Provider<UserRepository>(
          create: (_) => getIt<UserRepository>(),
        ),
        // Tạo AuthViewModel và truyền UserRepository từ Provider
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Auth Todo App',
        routerConfig: router,
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
