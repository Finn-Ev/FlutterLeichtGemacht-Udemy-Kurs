import 'package:advisor_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource.test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late final MockSharedPreferences mockSharedPreferences;
  late final ThemeLocalDataSource themeLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDataSource = ThemeLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getIsDarkMode", () {
    const tIsDarkMode = true;

    test("should return the darkMode Setting if there is a ThemeMode saved in sharedPreferences", () async {
      // arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(tIsDarkMode);

      // act
      final result = await themeLocalDataSource.getIsDarkModeLocally();

      // assert
      verify(mockSharedPreferences.getBool(IS_DARK_MODE_KEY));
      expect(result, tIsDarkMode);
    });

    test("should throw a CacheException if there is no ThemeMode saved in sharedPreferences", () async {
      // arrange
      when(mockSharedPreferences.getBool(any)).thenReturn(null);

      // act
      final call = themeLocalDataSource.getIsDarkModeLocally;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("setDarkMode", () {
    const tIsDarkMode = true;

    test("should call setDarkMode to save the ThemeMode in sharedPreferences", () async {
      when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => true);

      // act
      await themeLocalDataSource.setDarkModeLocally(tIsDarkMode);

      // assert
      verify(mockSharedPreferences.setBool(IS_DARK_MODE_KEY, tIsDarkMode));
    });
  });
}
