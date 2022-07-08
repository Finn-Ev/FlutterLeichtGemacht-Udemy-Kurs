import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/oberserver/todos_observer_bloc.dart';
import 'package:flutter_firebase_todo_app/presentation/home/widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosObserverBloc, TodosObserverState>(
      builder: (context, state) {
        if (state is TodosObserverInitial) {
          return Container();
        } else if (state is TodosObserverLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodosObserverFailure) {
          return const Center(child: Text('Failed to load todos'));
        } else if (state is TodosObserverLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return TodoCard(todo: state.todos[index]);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
