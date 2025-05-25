import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0872E9);
  static const Color secondaryColor = Color(0xFFF75555);
  static const Color backgroundColor = primaryColor;
  static const Color textColor = Color(0XFF000000);
  static const Color checkedColor = Color(0xFF0872E9);
  static const Color principalBackground = Color(0xFFFAFAFA);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color greyBackground = Color(0xFFF4F4F4);
  static const Color greySecondary = Color(0xFF797979);
  static const Color greenColor = Color(0xFF60D39C);
  static const Color greenBackground = Color(0xFF01B763);
  static const Color blueColor = Color(0xFF0047BB);

  // Define your custom text styles
  static TextTheme textTheme = const TextTheme(
    labelSmall: TextStyle(
      fontSize: 10.0,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),
    titleSmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
    titleMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
    titleLarge: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
  );

  // Define your overall theme
  static ThemeData lightTheme = ThemeData(
      fontFamily: 'Inter',
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        titleTextStyle: textTheme.titleMedium,
        elevation: 0,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: const IconThemeData(color: textColor),
      checkboxTheme: const CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(checkedColor),
        fillColor: WidgetStatePropertyAll(Colors.white),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primaryColor),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearMinHeight: 8.0,
      ));
}
