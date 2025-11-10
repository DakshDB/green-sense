import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? color;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primaryColor;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: effectiveColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: effectiveColor,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              title,
              style: AppStyles.headline3,
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              description,
              style: AppStyles.bodyText,
            ),
          ],
        ),
      ),
    );
  }
}
