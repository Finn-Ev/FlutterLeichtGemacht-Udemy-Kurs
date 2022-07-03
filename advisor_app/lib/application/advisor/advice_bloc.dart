import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/usecases/advice_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advice_event.dart';
part 'advice_state.dart';

const SERVER_FAILURE_MESSAGE = "Internal Server Failure. Please try again.";
const GENERAL_FAILURE_MESSAGE = "Something went wrong. Please try again.";

class AdviceBloc extends Bloc<AdviceEvent, AdvisorState> {
  final AdviceUseCases useCases;

  AdviceBloc({required this.useCases}) : super(AdviceInitialState()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdviceLoadingState());

      Either<Failure, AdviceEntity> adviceOrFailure = await useCases.getAdviceUseCase();

      adviceOrFailure.fold(
        (failure) => emit(AdviceErrorState(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdviceLoadedState(text: advice.text)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
