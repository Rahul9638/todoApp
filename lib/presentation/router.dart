import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/cubit/add_todo_cubit.dart';
import 'package:todos_app/cubit/edit_todo_cubit.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/data/models/todo.dart';
import 'package:todos_app/data/network_service.dart';
import 'package:todos_app/data/repository.dart';
import 'package:todos_app/presentation/screens/add_todos_screen.dart';
import 'package:todos_app/presentation/screens/edit_todos_screen.dart';
import 'package:todos_app/presentation/screens/todos_screen.dart';

import '../constant/strings.dart';

class AppRouter {
  late Repository repository;
  late TodosCubit todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }
  MaterialPageRoute? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit,
            child: const TodosScreen(),
          ),
        );
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                EditTodoCubit(repository: repository, todosCubit: todosCubit),
            child: EditTodosScreen(
              todo: todo,
            ),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => AddTodoCubit(
                      repository: repository, todosCubit: todosCubit),
                  child: AddTodoScreen(),
                ));
      default:
        return null;
    }
  }
}
