import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;

  static const Color _accentColorDark = Color.fromRGBO(74, 217, 217, 1);

  static const TextStyle _lightHeadingText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Rubik", fontWeight: FontWeight.w500, fontSize: 16);

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightHeadingText,
    bodyText1: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle = _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkThemeHeadingTextStyle,
    bodyText1: _darkThemeBodyeTextStyle,
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: const AppBarTheme(color: _appbarColorLight, iconTheme: IconThemeData(color: _iconColor)),
      bottomAppBarColor: _appbarColorLight,
      colorScheme: ColorScheme.light(
          primary: _lightPrimaryColor,
          onPrimary: _lightOnPrimaryColor,
          secondary: _accentColorDark),
      textTheme: _lightTextTheme);

  static final ThemeData darkTheme = ThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: AppBarTheme(color: _appbarColorDark, iconTheme: const IconThemeData(color: _iconColor)),
      bottomAppBarColor: _appbarColorDark,
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _accentColorDark,
        onPrimary: _darkOnPrimaryColor,
      ),
      textTheme: _darkTextTheme);
}
