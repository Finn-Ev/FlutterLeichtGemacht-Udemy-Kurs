part of 'todo_detail_form_bloc.dart';

class TodoDetailFormState {
  final Todo todo;
  final bool showErrorMessages;
  final bool isEditing;
  final bool isLoading;
  final Option<Either<TodoFailure, Unit>> failureOrSuccessOption;

  TodoDetailFormState({
    required this.todo,
    required this.showErrorMessages,
    required this.isEditing,
    required this.isLoading,
    required this.failureOrSuccessOption,
  });

  factory TodoDetailFormState.initial() {
    return TodoDetailFormState(
      todo: Todo.empty(),
      showErrorMessages: false,
      isEditing: false,
      isLoading: false,
      failureOrSuccessOption: none(),
    );
  }

  TodoDetailFormState copyWith({
    Todo? todo,
    bool? showErrorMessages,
    bool? isEditing,
    bool? isLoading,
    Option<Either<TodoFailure, Unit>>? failureOrSuccessOption,
  }) {
    return TodoDetailFormState(
      todo: todo ?? this.todo,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isEditing: isEditing ?? this.isEditing,
      isLoading: isLoading ?? this.isLoading,
      failureOrSuccessOption: failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}
