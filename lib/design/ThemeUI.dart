import 'package:flutter/material.dart';

class FitnessAppTheme {
  FitnessAppTheme._();
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Montserrat';
  static const Color selectorGrayText = Color.fromRGBO(103, 103, 103, 1);
  static const Color selectorGrayBackGround = Color.fromRGBO(234, 234, 234, 1);
  static const Color selectorGray1 = Color.fromRGBO(180, 180, 180, 1);
  static const Color selectorGray2 = Color.fromRGBO(132, 132, 132, 1);
  static const Color selectorGray3 = Color.fromRGBO(72, 72, 72, 1);

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );
  static const TextStyle headlineBlue = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: FitnessAppTheme.darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: FitnessAppTheme.nearlyBlue,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
  static BoxShadow get selectorShadow => BoxShadow(//The selected shadow of the box in goalAchieved form
    // color: CustomTheme.mainColor.withOpacity(0.25),
    color: FitnessAppTheme.nearlyWhite.withOpacity(0.25),
    blurRadius: 8.0,
    spreadRadius: 2.0,
    offset: const Offset(
      0.0,
      4.0,
    ),
  );
  static const BoxShadow transperentShadow = BoxShadow(//The unselected shadow of the box in goalAchieved for
    color:FitnessAppTheme.nearlyWhite,
    blurRadius: 15.0,
    spreadRadius: 2.0,
    offset: Offset(
      10.0,
      10.0,
    ),
  );

  static TextStyle get selectorBigTextAction => TextStyle(//Selected big text
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: FitnessAppTheme.nearlyBlue,
  );
  static const TextStyle selectorBigText = TextStyle(//unselected big text
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: FitnessAppTheme.selectorGray3,
  );
  static const TextStyle selectorMiniLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: selectorGrayText,
  );
}
