import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_colors.dart';
import 'package:mizan_app/core/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightYellowColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightYellowColor,
      titleTextStyle: AppTextStyles.black28Bold,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.greenColor),
    ),

    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.black28Bold,
      headlineMedium: AppTextStyles.black20Bold,
      headlineSmall: AppTextStyles.black16SemiBold,

      bodyMedium: AppTextStyles.grey20Regular,

      labelMedium: AppTextStyles.lightYellow20SemiBold,
      labelSmall: AppTextStyles.green20Bold,
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.greenColor,
      onPrimary: AppColors.lightGreenColor,
      secondary: AppColors.lightYellowColor,
      onSecondary: AppColors.blackColor,
      surface: AppColors.greyColor,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightYellowColor,
      errorStyle: const TextStyle(color: AppColors.errorColor, fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.greenColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenColor,
        foregroundColor: AppColors.blackColor,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: AppTextStyles.black20Bold,
        elevation: 0,
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.greenColor,
      contentTextStyle: AppTextStyles.lightYellow20SemiBold,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightYellowColor,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.lightYellowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.lightYellowColor,
      headerBackgroundColor: AppColors.greenColor,
      headerForegroundColor: AppColors.blackColor,
      todayForegroundColor: WidgetStateProperty.all(AppColors.blackColor),
      todayBackgroundColor: WidgetStateProperty.all(AppColors.lightGreenColor),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.greyColor),
        backgroundColor: WidgetStateProperty.all(AppColors.lightGreenColor),
        textStyle: WidgetStateProperty.all(AppTextStyles.black16SemiBold),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.greyColor),
        backgroundColor: WidgetStateProperty.all(AppColors.lightGreenColor),
        textStyle: WidgetStateProperty.all(AppTextStyles.black16SemiBold),
      ),
    ),
  );
}
