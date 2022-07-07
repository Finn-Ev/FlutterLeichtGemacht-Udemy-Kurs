import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo_color.dart';

import '../../domain/entities/auth/id.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final int color;
  final dynamic createdAt;

  TodoModel({
    required this.id,
    required this.description,
    required this.title,
    required this.color,
    required this.isDone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'color': color,
      'createdAt': createdAt,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: "",
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
      color: map['color'] as int,
      createdAt: map['createdAt'],
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    int? color,
    dynamic createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TodoModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Todo toEntity() {
    return Todo(
        id: UniqueID.fromString(id),
        title: title,
        description: description,
        isDone: isDone,
        color: TodoColor(color: Color(color).withOpacity(1)));
  }

  factory TodoModel.fromEntity(Todo todoItem) {
    return TodoModel(
      id: todoItem.id.value,
      description: todoItem.description,
      title: todoItem.title,
      color: todoItem.color.color.value,
      isDone: todoItem.isDone,
      createdAt: FieldValue.serverTimestamp(), // kind of a placeholder, firebase replaces it with the creation time
    );
  }
}
