import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todos_observer_event.dart';
part 'todos_observer_state.dart';

class TodosObserverBloc extends Bloc<TodosObserverEvent, TodosObserverState> {
  final TodoRepository todoRepository;

  StreamSubscription<Either<TodoFailure, List<Todo>>>? _todosSubscription;

  TodosObserverBloc({required this.todoRepository}) : super(TodosObserverInitial()) {
    on<TodosObserveAll>(
      (event, emit) async {
        emit(TodosObserverLoading());
        await _todosSubscription?.cancel();
        _todosSubscription =
            todoRepository.watchAll().listen((failureOrTodos) => add(TodosUpdated(failureOrTodos: failureOrTodos)));
      },
    );

    on<TodosUpdated>(
      (event, emit) async {
        event.failureOrTodos.fold(
          (failure) => emit(TodosObserverFailure(failure)),
          (todos) => emit(TodosObserverLoaded(todos: todos)),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
