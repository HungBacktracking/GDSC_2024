import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const splash = Color(0xFFFEC400);
  static const statusBar = Color(0xFF2E3147);
  static const appBarColor = Color(0xFF222539);
  static const greenColor = Color(0xFF2EC492);
  static const orangeColor = Color(0xFFEB8D2F);
  static const greyColor = Color(0xFFF4F4F4);
  static const darkGreyColor = Color(0xFFD9D9D9);
  static const greenGray = Color(0xFFE7EAEA);
  static const blueBorder = Color(0xFF3164CE);
  static const Blue = Color(0xFF2A15AD);
  static const darkGreen = Color(0xFF017227);
  static const lightBlue = Color(0xFF4179E0);
  static const redBorder = Color(0xFFF14336);
  static const redLight = Color(0xFFFFF1F0);
  static const orangeLight = Color(0x44FB5E2C);
  static const orange = Color(0xAAFB5E2C);
  static const lightRedBackGround = Color(0xFFF4F0F0);
  static const blueLight = Color(0xFFF5F9FF);
  static const yellowBtn = Color.fromARGB(255, 243, 185, 37);
  static const redBtn = Color.fromARGB(255, 205, 50, 15);
  static const mistyrose = Color.fromARGB(255, 255, 228, 225);

  static List<Color> defaultGradientColors = [
    Colors.grey[100]!,
    Colors.orange[100]!,
  ];
  static List<Color> orangeGiftGradientColors = [
    const Color(0xFFEB8D2F).withOpacity(1),
    const Color(0xFFF3B925).withOpacity(1),
  ];
  static List<Color> redGiftGradientColors = [
    const Color(0xFFFCCAC6).withOpacity(0.3),
    const Color(0xFFDB5449).withOpacity(0.3),
  ];
  static List<Color> greenGiftGradientColors = [
    const Color(0xFF89D980).withOpacity(0.3),
    const Color(0xFF34BA25).withOpacity(0.3),
  ];
  static const redTextColor = Color(0xFFD05045);
  static const greenTextColor = Color(0xFF8CC153);

  static final myLightTheme = ThemeData(
    primaryColor: splash,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white.withOpacity(0.7), inherit: true),
    ),
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    fontFamily: 'Poppins',
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(
        background: splash,
        primary: splash,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColor,
    ),
  );

  static final myDarkTheme = ThemeData(
    primaryColor: splash,
    scaffoldBackgroundColor: appBarColor,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    backgroundColor: appBarColor,
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.dark(
        background: splash,
        primary: splash,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColor,
    ),
  );
}
