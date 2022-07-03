import 'package:advisor_app/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String IS_DARK_MODE_KEY = 'theme_mode';

abstract class ThemeLocalDataSource {
  ThemeLocalDataSource();
  Future<void> setDarkModeLocally(bool value);
  Future<bool> getIsDarkModeLocally();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> setDarkModeLocally(bool value) async {
    sharedPreferences.setBool(IS_DARK_MODE_KEY, value);
  }

  @override
  Future<bool> getIsDarkModeLocally() {
    final modeBool = sharedPreferences.getBool(IS_DARK_MODE_KEY);

    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }
}
