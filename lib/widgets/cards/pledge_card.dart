import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class PledgeCard extends StatelessWidget {
  final String commitment;
  final bool isSelected;
  final VoidCallback onTap;

  const PledgeCard({
    Key? key,
    required this.commitment,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : Colors.white,
          border: Border.all(
            color: isSelected
              ? AppColors.primaryColor
              : AppColors.textSecondary.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textSecondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  )
                : null,
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Text(
                commitment,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
