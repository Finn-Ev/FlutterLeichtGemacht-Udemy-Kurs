part of 'todos_controller_bloc.dart';

@immutable
abstract class TodosControllerEvent {}

class UpdateTodo extends TodosControllerEvent {
  final Todo todo;

  UpdateTodo({required this.todo});
}

class DeleteTodo extends TodosControllerEvent {
  final UniqueID id;

  DeleteTodo({required this.id});
}
