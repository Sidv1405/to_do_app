import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/utils/create_text_theme.dart';
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
      routes: [
        GoRoute(
          path: '/',
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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      routerConfig: router,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
