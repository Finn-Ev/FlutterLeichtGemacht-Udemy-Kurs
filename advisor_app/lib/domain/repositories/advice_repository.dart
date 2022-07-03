import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi();
}
