part of 'todos_observer_bloc.dart';

@immutable
abstract class TodosObserverState {}

class TodosObserverInitial extends TodosObserverState {}

class TodosObserverLoading extends TodosObserverState {}

class TodosObserverLoaded extends TodosObserverState {
  final List<Todo> todos;

  TodosObserverLoaded({required this.todos});
}

class TodosObserverFailure extends TodosObserverState {
  final TodoFailure failure;

  TodosObserverFailure(this.failure);
}
