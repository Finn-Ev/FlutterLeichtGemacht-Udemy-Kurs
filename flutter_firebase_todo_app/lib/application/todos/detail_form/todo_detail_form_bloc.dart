import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo_color.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/todo_repository.dart';

part 'todo_detail_form_event.dart';
part 'todo_detail_form_state.dart';

class TodoDetailFormBloc extends Bloc<TodoDetailFormEvent, TodoDetailFormState> {
  final TodoRepository todoRepository;

  TodoDetailFormBloc({required this.todoRepository}) : super(TodoDetailFormState.initial()) {
    on<InitializeTodoDetailPage>((event, emit) {
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      } else {
        emit(state); // no-op would also be valid
      }
    });

    on<ColorChanged>((event, emit) => emit(state.copyWith(todo: state.todo.copyWith(color: TodoColor(color: event.color)))));
  }
}
