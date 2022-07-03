part of 'advice_bloc.dart';

@immutable
abstract class AdvisorState with EquatableMixin {}

class AdviceInitialState extends AdvisorState {
  @override
  List<Object?> get props => [];
}

class AdviceLoadingState extends AdvisorState {
  @override
  List<Object?> get props => [];
}

class AdviceLoadedState extends AdvisorState {
  final String text;

  AdviceLoadedState({required this.text});

  @override
  List<Object?> get props => [text];
}

class AdviceErrorState extends AdvisorState {
  final String message;

  AdviceErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
