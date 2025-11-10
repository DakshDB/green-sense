import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

enum BadgeVariant { primary, success, warning, error, info }

class Badge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final IconData? icon;

  const Badge({
    Key? key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.icon,
  }) : super(key: key);

  Color _getBackgroundColor() {
    switch (variant) {
      case BadgeVariant.primary:
        return AppColors.primaryColor;
      case BadgeVariant.success:
        return Colors.green;
      case BadgeVariant.warning:
        return Colors.orange;
      case BadgeVariant.error:
        return Colors.red;
      case BadgeVariant.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getBackgroundColor(),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: _getBackgroundColor(),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getBackgroundColor(),
            ),
          ),
        ],
      ),
    );
  }
}
