import 'package:flutter/material.dart';
import 'package:todos_app/presentation/router.dart';
import 'package:todos_app/presentation/screens/todos_screen.dart';

void main() {
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
