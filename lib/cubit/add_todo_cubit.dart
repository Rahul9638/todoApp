import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todos_app/cubit/todos_cubit.dart';

import '../data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "Todo message is Empty"));
      return;
    }

    emit(AddingTodo());
    Timer(Duration(seconds: 3), () {
      repository.addTodo(message).then((todo) {
        if (todo != null) {
          todosCubit.addTodo(todo);
          emit(TodoAdded());
        }
      });
    });
  }
}
