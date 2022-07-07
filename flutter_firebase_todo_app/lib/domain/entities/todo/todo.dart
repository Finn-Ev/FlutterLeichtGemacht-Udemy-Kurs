import 'package:flutter_firebase_todo_app/domain/entities/auth/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo_color.dart';

class Todo {
  final UniqueID id;
  final String title;
  final String description;
  final bool isDone;
  final TodoColor color;

  Todo({required this.id, required this.description, required this.title, required this.color, required this.isDone});

  factory Todo.empty() {
    return Todo(
        id: UniqueID(), title: "", description: "", isDone: false, color: TodoColor(color: TodoColor.predefinedColors[5]));
  }

  Todo copyWith({
    UniqueID? id,
    String? title,
    String? description,
    bool? isDone,
    TodoColor? color,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      color: color ?? this.color,
    );
  }
}
