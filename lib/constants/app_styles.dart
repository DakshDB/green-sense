import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class AppStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 20,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}