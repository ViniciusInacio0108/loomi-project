import 'package:flutter/material.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';

/// MyThemeData is responsable to manage everything related to the ThemeData
/// of the app.
class MyThemeData {
  final themeData = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: MyAppColors.primary,
      onPrimary: MyAppColors.white,
      secondary: MyAppColors.secondary,
      surface: MyAppColors.white,
      onSurface: MyAppColors.black,
      outline: MyAppColors.black2,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: TextStyle(
        fontSize: 12,
        color: MyAppColors.black,
      ),
      labelStyle: TextStyle(
        color: MyAppColors.greyLabel,
        fontSize: 16,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide(
          color: MyAppColors.redErrorColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide(
          color: MyAppColors.black2,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        borderSide: BorderSide(
          color: MyAppColors.redErrorColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: MyAppColors.greyInputBorder,
          width: 1,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        foregroundColor: MyAppColors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    useMaterial3: true,
  );
}
