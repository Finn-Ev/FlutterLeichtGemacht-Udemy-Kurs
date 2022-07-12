import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/controller/todos_controller_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/oberserver/todos_observer_bloc.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/injection.dart';
import 'package:flutter_firebase_todo_app/presentation/home/widgets/todo_list.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosObserverBloc = sl<TodosObserverBloc>()..add(TodosObserveAll());
    final todosControllerBloc = sl<TodosControllerBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosObserverBloc>(create: (context) => todosObserverBloc),
        BlocProvider<TodosControllerBloc>(create: (context) => todosControllerBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthUnauthenticatedState) {
              AutoRouter.of(context).replace(const SignUpPageRoute());
            }
          }),
          BlocListener<TodosControllerBloc, TodosControllerState>(listener: (context, state) {
            if (state is TodosControllerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(mapTodosFailureToMessage(state.failure)),
                ),
              );
            }
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutButtonPressed());
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              AutoRouter.of(context).push(TodoDetailPageRoute(todo: null));
            },
            child: const Icon(Icons.add),
          ),
          body: TodoList(),
        ),
      ),
    );
  }
}
