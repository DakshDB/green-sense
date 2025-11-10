import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class RadioGroup<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<RadioOption<T>> options;
  final ValueChanged<T?> onChanged;

  const RadioGroup({
    Key? key,
    required this.label,
    this.value,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...options.map((option) {
          return RadioListTile<T>(
            title: Text(
              option.title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: option.subtitle != null
              ? Text(
                  option.subtitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                )
              : null,
            value: option.value,
            groupValue: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ],
    );
  }
}

class RadioOption<T> {
  final T value;
  final String title;
  final String? subtitle;

  const RadioOption({
    required this.value,
    required this.title,
    this.subtitle,
  });
}
