import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String? label;
  final Color? color;
  final double height;

  const ProgressBar({
    Key? key,
    required this.progress,
    this.label,
    this.color,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: effectiveColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height,
            backgroundColor: effectiveColor.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          ),
        ),
      ],
    );
  }
}
