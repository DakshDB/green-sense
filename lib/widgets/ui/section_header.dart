import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final bool centered;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
    this.centered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: centered
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
          children: [
            if (centered)
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.headline1,
                  textAlign: TextAlign.center,
                ),
              )
            else
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.headline1,
                ),
              ),
            if (actionText != null && onAction != null && !centered)
              TextButton(
                onPressed: onAction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: AppStyles.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ],
      ],
    );
  }
}
