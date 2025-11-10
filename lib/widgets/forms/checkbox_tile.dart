import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class CheckboxTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
        ? Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          )
        : null,
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryColor,
      checkColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
