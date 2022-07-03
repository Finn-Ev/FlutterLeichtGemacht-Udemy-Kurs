import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/advice_repository.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepositoryImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      print("getAdviceFromApi");
      final advice = await adviceRemoteDatasource.getRandomAdviceFromApi();
      print(advice);
      return Right(advice);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
