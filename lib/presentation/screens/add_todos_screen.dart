import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todos_app/cubit/add_todo_cubit.dart';
import 'package:todos_app/cubit/todos_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Todo")),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is TodoAdded) {
              Navigator.pop(context);
              return;
            } else if(state is AddTodoError){
              Toast.show(
                state.error,
                context,
                duration: 3,
                backgroundColor: Colors.red,
                gravity: Toast.CENTER
              );
            }
          },
          child: Container(
            margin: EdgeInsets.all(20),
            child: _body(context),
          ),
        ));
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter Todo Message.."),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        ),
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<AddTodoCubit, AddTodoState>(
        builder: (context, state) {
          if (state is AddingTodo) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text(
              "Add Todo",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
