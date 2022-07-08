import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Card(
        elevation: 16,
        color: todo.color.color,
        child: ListTile(
          title: Text(
            todo.title,
            style: themeData.textTheme.headline1!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (value) {
              print(value);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
