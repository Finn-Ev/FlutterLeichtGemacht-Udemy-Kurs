import 'package:advisor_app/domain/failures/failures.dart';
import 'package:advisor_app/domain/repositories/theme_repository.dart';
import 'package:advisor_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:advisor_app/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_impl.test.mocks.dart';

@GenerateMocks([ThemeLocalDataSource])
void main() {
  late MockThemeLocalDataSource mockThemeLocalDataSource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDataSource = MockThemeLocalDataSource();
    themeRepository = ThemeRepositoryImpl(themeLocalDataSource: mockThemeLocalDataSource);
  });

  group("getIsDarkMode", () {
    const isDarkMode = true;
    test('should return stored value insofar it was cached', () async {
      // arrange
      when(mockThemeLocalDataSource.getIsDarkModeLocally()).thenAnswer((_) async => true);

      // act
      final result = await themeRepository.getIsDarkMode();

      // assert
      expect(result, const Right(isDarkMode));
      verify(mockThemeLocalDataSource.getIsDarkModeLocally());
      verifyNoMoreInteractions(mockThemeLocalDataSource);
    });

    test('should return CacheFailure value insofar no darkMode was cached', () async {
      // arrange
      when(mockThemeLocalDataSource.getIsDarkModeLocally()).thenThrow(CacheException());

      // act
      final result = await themeRepository.getIsDarkMode();

      // assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDataSource.getIsDarkModeLocally());
      verifyNoMoreInteractions(mockThemeLocalDataSource);
    });
  });

  group("setDarkMode", () {
    const isDarkMode = true;

    test("should call setDarkModeLocally", () async {
      // arrange
      when(mockThemeLocalDataSource.setDarkModeLocally(any)).thenAnswer((_) async => true);

      // act
      await themeRepository.setDarkMode(isDarkMode);

      // assert
      verify(mockThemeLocalDataSource.setDarkModeLocally(isDarkMode));
    });
  });
}
