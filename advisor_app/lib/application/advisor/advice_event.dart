part of 'advice_bloc.dart';

@immutable
abstract class AdviceEvent {}

/// event when Get-Advice Button is pressed
class AdviceRequestedEvent extends AdviceEvent {
  // final String advice;

  AdviceRequestedEvent();
}
