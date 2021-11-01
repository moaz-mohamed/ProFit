import 'package:flutter/material.dart';
import 'custom_theme.dart';

ThemeData get lightTheme => ThemeData(
  fontFamily: 'Montserrat',
  cardColor: Colors.white,
  hintColor: Colors.grey[400],
  backgroundColor: CustomTheme.backgroundColor,
  scaffoldBackgroundColor: CustomTheme.lightScaffoldBackgroundColor,
  primaryColor: CustomTheme.mainColor,
  dividerColor: Colors.grey.withOpacity(0.5),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: CustomTheme.mainColor,
    accentColor: CustomTheme.mainColor,
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: CustomTheme.mainColor,
  ),
  textTheme: const TextTheme(
    button: TextStyle(
      color: Colors.white,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
);
