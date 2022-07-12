import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/detail_form/todo_detail_form_bloc.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/injection.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart';
import 'package:flutter_firebase_todo_app/presentation/todo_detail/widgets/todo_detail_form.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo? todo;
  const TodoDetailPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocProvider(
      create: (context) => sl<TodoDetailFormBloc>()..add(InitializeTodoDetailPage(todo: todo)),
      child: BlocListener<TodoDetailFormBloc, TodoDetailFormState>(
        listenWhen: (previous, current) => previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () => {}, // option is none, no-op
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
              (failure) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(mapTodosFailureToMessage(failure)),
                  backgroundColor: themeData.errorColor,
                ),
              ),
              (success) => Navigator.of(context).popUntil((route) => route.settings.name == HomePageRoute.name),
            ),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(todo != null ? 'Edit "${todo!.title}"' : "Create Todo"),
          ),
          body: TodoDetailForm(),
        ),
      ),
    );
  }
}
