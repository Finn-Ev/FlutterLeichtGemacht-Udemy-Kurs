import 'package:advisor_app/domain/entities/advice_entity.dart';
import 'package:advisor_app/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

class AdviceUseCases {
  final AdviceRepository adviceRepository;

  AdviceUseCases({required this.adviceRepository});

  Future<Either<Failure, AdviceEntity>> getAdviceUseCase() async {
    return await adviceRepository.getAdviceFromApi();
  }
}
