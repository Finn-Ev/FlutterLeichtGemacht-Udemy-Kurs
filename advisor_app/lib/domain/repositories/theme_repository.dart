import 'package:advisor_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> getIsDarkMode();
  Future<void> setDarkMode(bool value);
}
