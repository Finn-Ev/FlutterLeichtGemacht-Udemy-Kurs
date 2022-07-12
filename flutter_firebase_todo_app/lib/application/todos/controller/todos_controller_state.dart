part of 'todos_controller_bloc.dart';

@immutable
abstract class TodosControllerState {}

class TodosControllerInitial extends TodosControllerState {}

class TodosControllerLoading extends TodosControllerState {}

class TodosControllerLoaded extends TodosControllerState {}

class TodosControllerFailure extends TodosControllerState {
  final TodoFailure failure;

  TodosControllerFailure(this.failure);
}
