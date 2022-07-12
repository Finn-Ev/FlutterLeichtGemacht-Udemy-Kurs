part of 'todo_detail_form_bloc.dart';

@immutable
abstract class TodoDetailFormEvent {}

class InitializeTodoDetailPage extends TodoDetailFormEvent {
  final Todo? todo;
  InitializeTodoDetailPage({required this.todo});
}

class ColorChanged extends TodoDetailFormEvent {
  final Color color;
  ColorChanged({required this.color});
}
