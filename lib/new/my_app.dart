import 'package:flutter/material.dart';

import 'core/utils/create_text_theme.dart';
import 'features/todos/presentation/pages/todo_page.dart';
import 'features/todos/presentation/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: const TodoPage(),
    );
  }
}
