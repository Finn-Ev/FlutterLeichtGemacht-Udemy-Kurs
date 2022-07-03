import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/repositories/advice_repository.dart';
import 'package:advisor_app/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:advisor_app/infrastructure/models/advice_model.dart';
import 'package:advisor_app/infrastructure/repositories/advice_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repository_impl.test.mocks.dart';

@GenerateMocks([AdviceRemoteDatasource])
void main() {
  late AdviceRepository adviceRepository;
  late MockAdviceRemoteDatasource mockAdvisorRemoteDatasource;

  setUp(() {
    mockAdvisorRemoteDatasource = MockAdviceRemoteDatasource();
    adviceRepository = AdviceRepositoryImpl(adviceRemoteDatasource: mockAdvisorRemoteDatasource);
  });

  group("getAdviceFromAPI", () {
    final tAdviceModel = AdviceModel(id: 1, text: 'Advice');
    final AdviceEntity tAdvice = tAdviceModel;

    test("should return remote data if the call to the remote source was successfully", () async {
      // arrange
      when(mockAdvisorRemoteDatasource.getRandomAdviceFromApi()).thenAnswer((_) async => tAdviceModel);

      // act
      final result = await adviceRepository.getAdviceFromApi();

      // assert
      verify(mockAdvisorRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(tAdvice));
      verifyNoMoreInteractions(mockAdvisorRemoteDatasource);
    });

    test("should return server failure if the call to the remote source throws a server-exception", () async {
      // arrange
      when(mockAdvisorRemoteDatasource.getRandomAdviceFromApi()).thenThrow(ServerException());

      // act
      final result = await adviceRepository.getAdviceFromApi();

      // assert
      verify(mockAdvisorRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockAdvisorRemoteDatasource);
    });
  });
}
