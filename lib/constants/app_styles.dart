import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class AppStyles {
  // Headline styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
    height: 1.2,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
    height: 1.3,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.headingColor,
    height: 1.3,
  );

  // Body text styles
  static const TextStyle subtitle = TextStyle(
    fontSize: 20,
    color: AppColors.textColor,
    height: 1.5,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
    height: 1.6,
  );

  static const TextStyle bodyTextLarge = TextStyle(
    fontSize: 18,
    color: AppColors.textColor,
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.subtextColor,
    height: 1.4,
  );

  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    color: AppColors.subtextColor,
    height: 1.4,
  );

  // Button styles
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Card styles
  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.headingColor,
    height: 1.3,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.subtextColor,
    height: 1.4,
  );

  // Badge styles
  static const TextStyle badge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Link style
  static const TextStyle link = TextStyle(
    fontSize: 16,
    color: AppColors.primaryColor,
    decoration: TextDecoration.underline,
    height: 1.5,
  );

  // Box shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get cardShadowHover => [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  // Border radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 48.0;
}