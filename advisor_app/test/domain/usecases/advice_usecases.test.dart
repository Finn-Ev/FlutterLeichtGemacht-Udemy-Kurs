import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/repositories/advice_repository.dart';
import 'package:advisor_app/domain/usecases/advice_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases.test.mocks.dart';

@GenerateMocks([AdviceRepository])
void main() {
  late AdviceUseCases advisorUseCases;
  late MockAdviceRepository mockAdviceRepository;

  setUp(() =>
      {mockAdviceRepository = MockAdviceRepository(), advisorUseCases = AdviceUseCases(adviceRepository: mockAdviceRepository)});

  group("getAdviceUseCase", () {
    final tAdvice = AdviceEntity(id: 1, text: 'Advice');

    test("should return the same advice as the repository", () async {
      // arrange
      when(mockAdviceRepository.getAdviceFromApi()).thenAnswer((_) async => Right(tAdvice));

      // act
      final result = await advisorUseCases.getAdviceUseCase();

      // assert
      expect(result, Right(tAdvice));
      verify(mockAdviceRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviceRepository);
    });

    test("should return the same failure as the repository", () async {
      // arrange
      when(mockAdviceRepository.getAdviceFromApi()).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await advisorUseCases.getAdviceUseCase();

      // assert
      expect(result, Left(ServerFailure()));
      verify(mockAdviceRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviceRepository);
    });
  });
}
