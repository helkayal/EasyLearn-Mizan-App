import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle black28Bold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static const black18Bold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static const TextStyle black16SemiBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );

  static const TextStyle grey16Regular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.greyColor,
  );

  static const TextStyle lightYellow20SemiBold = TextStyle(
    color: AppColors.lightYellowColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
