import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/oberserver/todos_observer_bloc.dart';
import 'package:flutter_firebase_todo_app/injection.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosObserverBloc = sl<TodosObserverBloc>()..add(TodosObserveAll());
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosObserverBloc>(
          create: (context) => todosObserverBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthUnauthenticatedState) {
              AutoRouter.of(context).replace(const SignUpPageRoute());
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
          body: const Center(
            child: Text('Home'),
          ),
        ),
      ),
    );
  }
}
