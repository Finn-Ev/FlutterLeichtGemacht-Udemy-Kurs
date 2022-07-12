import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_firebase_todo_app/application/todos/controller/todos_controller_bloc.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: InkResponse(
        onTap: () {
          AutoRouter.of(context).push(TodoDetailPageRoute(todo: todo));
        },
        child: Card(
          elevation: 16,
          color: todo.color.color,
          child: ListTile(
            title: Text(
              todo.title,
              style: themeData.textTheme.headline1!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: Checkbox(
              checkColor: Colors.black,
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) => states.contains(MaterialState.selected) ? Colors.white : Colors.white,
              ),
              value: todo.isDone,
              onChanged: (value) {
                BlocProvider.of<TodosControllerBloc>(context).add(UpdateTodo(todo: todo.copyWith(isDone: value)));
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showPlatformDialog(
                  context: context,
                  builder: (_) => BasicDialogAlert(
                    title: Text(todo.title),
                    content: Text("Möchstest du dieses Todo wirklich löschen?"),
                    actions: <Widget>[
                      BasicDialogAction(
                        title: const Text("Abbrechen"),
                        iosIsDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      BasicDialogAction(
                        title: const Text("Löschen"),
                        iosIsDestructiveAction: true,
                        onPressed: () {
                          print("Todo löschen");
                          BlocProvider.of<TodosControllerBloc>(context).add(DeleteTodo(id: todo.id));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
