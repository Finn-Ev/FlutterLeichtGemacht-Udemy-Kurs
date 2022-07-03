import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/repositories/theme_repository.dart';
import 'package:advisor_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;
  ThemeRepositoryImpl({required this.themeLocalDataSource});

  @override
  Future<void> setDarkMode(bool value) {
    return themeLocalDataSource.setDarkModeLocally(value);
  }

  @override
  Future<Either<Failure, bool>> getIsDarkMode() async {
    try {
      final themeMode = await themeLocalDataSource.getIsDarkModeLocally();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
