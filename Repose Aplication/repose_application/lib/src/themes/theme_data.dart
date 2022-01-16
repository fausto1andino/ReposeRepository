import 'package:flutter/material.dart';

class AppTheme {
  static const Color colorMediumPriority = Colors.yellow;
  static const Color colorHighPriority = Colors.red;
  static final Color colorLowPriority = Colors.green.shade400;

  static final TextTheme textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 = TextStyle(fontFamily: 'VujahdayScript', fontWeight: FontWeight.bold);
  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 = _headLine5.copyWith(fontFamily: 'VujahdayScript');
  static final TextStyle _subTitle1 = _headLine6.copyWith(fontFamily: 'LuxuriousRoman', fontWeight: FontWeight.bold);
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
        primaryColor: const Color(0xFF1d87e5),
        primaryColorDark: const Color(0xFF005bb2),
        primaryColorLight: const Color(0xFF69b6ff),
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey,
            labelColor: ligthMode ? const Color(0xFFCE93D8) : Colors.white),
        colorScheme: ColorScheme(
            primary: const Color(0xFFCE93D8),
            primaryVariant: const Color(0xFF1d87e5),
            secondary: const Color(0XFFFFFFFF),
            secondaryVariant: const Color(0XFFFFFFFF),
            surface: Colors.white,
            background: const Color(0x1AFFFFFF),
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: ligthMode ? Brightness.light : Brightness.dark),
        textTheme: textTheme);
  }
}
