import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/todos/domain/entities/todo.dart';
import '../../features/todos/presentation/pages/todo_details_page.dart';
import '../../features/todos/presentation/pages/todo_page.dart';
import '../presentation/splash/splash_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),

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
}
