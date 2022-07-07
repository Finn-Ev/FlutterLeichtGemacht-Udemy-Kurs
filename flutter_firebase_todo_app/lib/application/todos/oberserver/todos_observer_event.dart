part of 'todos_observer_bloc.dart';

@immutable
abstract class TodosObserverEvent {}

class TodosObserveAll extends TodosObserverEvent {}

class TodosUpdated extends TodosObserverEvent {
  final Either<TodoFailure, List<Todo>> failureOrTodos;

  TodosUpdated({required this.failureOrTodos});
}

class TodoObserverFailure extends TodosObserverEvent {
  final TodoFailure failure;

  TodoObserverFailure(this.failure);
}
