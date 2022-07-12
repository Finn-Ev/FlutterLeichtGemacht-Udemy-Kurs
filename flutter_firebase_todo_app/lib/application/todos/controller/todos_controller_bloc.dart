import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/auth/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todos_controller_event.dart';
part 'todos_controller_state.dart';

class TodosControllerBloc extends Bloc<TodosControllerEvent, TodosControllerState> {
  final TodoRepository todoRepository;

  TodosControllerBloc({required this.todoRepository}) : super(TodosControllerInitial()) {
    on<UpdateTodo>((event, emit) async {
      emit(TodosControllerLoading());
      final failureOrSuccess = await todoRepository.update(event.todo);

      failureOrSuccess.fold(
        (failure) => emit(TodosControllerFailure(failure)),
        (success) => emit(TodosControllerLoaded()),
      );
    });

    on<DeleteTodo>((event, emit) async {
      emit(TodosControllerLoading());
      final failureOrSuccess = await todoRepository.delete(event.id);

      failureOrSuccess.fold(
        (failure) => emit(TodosControllerFailure(failure)),
        (success) => emit(TodosControllerLoaded()),
      );
    });
  }
}
