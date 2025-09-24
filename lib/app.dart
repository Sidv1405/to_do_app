import 'package:flutter/material.dart';
import 'package:to_do_app/screens/todo_list_screen.dart';
import 'package:to_do_app/theme/theme.dart';
import 'package:to_do_app/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tạo text theme với Google Fonts
    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    // Tạo MaterialTheme custom
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: const TodoListScreen(),
    );
  }
}
