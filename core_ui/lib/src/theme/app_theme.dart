import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.turquoise,
      cardColor: AppColors.paleTurquoise,
      scaffoldBackgroundColor: AppColors.white,
      highlightColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.turquoise,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.turquoise,
        circularTrackColor: AppColors.white,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.turquoise,
        selectionColor: AppColors.turquoise,
        selectionHandleColor: AppColors.turquoise,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.turquoise,
        foregroundColor: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 20),
        labelStyle: AppTextTheme.font16.copyWith(
          color: AppColors.darkGrey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGrey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.turquoise,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        headerBackgroundColor: AppColors.turquoise,
        headerForegroundColor: AppColors.white,
        todayBackgroundColor: WidgetStatePropertyAll<Color>(
          AppColors.turquoise,
        ),
        dayStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: AppColors.black,
      primaryColor: AppColors.lightGrey,
      scaffoldBackgroundColor: AppColors.black,
      cardColor: AppColors.darkGrey,
      highlightColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextTheme.font18Bold,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.turquoise,
        circularTrackColor: AppColors.white,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.lightGrey,
        selectionColor: AppColors.lightGrey,
        selectionHandleColor: AppColors.lightGrey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.turquoise,
        foregroundColor: AppColors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 20),
        labelStyle: AppTextTheme.font16.copyWith(
          color: AppColors.lightGrey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGrey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
        todayBackgroundColor: WidgetStatePropertyAll<Color>(
          AppColors.turquoise,
        ),
        todayBorder: BorderSide(color: AppColors.turquoise),
      ),
    );
  }
}
