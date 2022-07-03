import 'package:advisor_app/application/advisor/advice_bloc.dart';
import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc.test.mocks.dart';

@GenerateMocks([AdviceUseCases])
void main() {
  late AdviceBloc adviceBloc;
  late MockAdviceUseCases mockAdviceUseCases;

  setUp(() {
    mockAdviceUseCases = MockAdviceUseCases();
    adviceBloc = AdviceBloc(useCases: mockAdviceUseCases);
  });

  test('Initial state should be AdviceInitial', () {
    // assert
    expect(adviceBloc.state, equals(AdviceInitialState()));
  });

  group('AdviceRequestedEvent', () {
    final tAdvice = AdviceEntity(id: 1, text: 'test');
    const tAdviceString = 'test';

    test('should call useCase if event is added', () async {
      // arrange
      when(mockAdviceUseCases.getAdviceUseCase()).thenAnswer((_) async => Right(tAdvice));

      // act
      adviceBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdviceUseCases.getAdviceUseCase());

      // assert
      verify(mockAdviceUseCases.getAdviceUseCase());
      verifyNoMoreInteractions(mockAdviceUseCases);
    });

    test('should emit loading, then emit the loaded-state when finished loading', () async {
      // arrange
      when(mockAdviceUseCases.getAdviceUseCase()).thenAnswer((_) async => Right(tAdvice));

      // assert later
      final expected = [
        AdviceLoadingState(),
        AdviceLoadedState(text: tAdviceString),
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });

    test('should emit loading, and emit the error-state with the SERVER_FAILURE_MESSAGE when the useCase fails', () async {
      // arrange
      when(mockAdviceUseCases.getAdviceUseCase()).thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        AdviceLoadingState(),
        AdviceErrorState(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });

    test(
        'should emit loading and emit the error-state with the GENERAL_FAILURE_MESSAGE when the useCase fails for an unknown reason',
        () async {
      // arrange
      when(mockAdviceUseCases.getAdviceUseCase()).thenAnswer((_) async => Left(GeneralFailure()));

      // assert later
      final expected = [
        AdviceLoadingState(),
        AdviceErrorState(message: GENERAL_FAILURE_MESSAGE),
      ];
      expectLater(adviceBloc.stream, emitsInOrder(expected));

      // act
      adviceBloc.add(AdviceRequestedEvent());
    });
  });
}
