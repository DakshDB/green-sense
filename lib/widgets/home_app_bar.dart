import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'GreenSense',
        style: TextStyle(
          color: AppColors.headingColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        TextButton(onPressed: () {}, child: const Text('Home', style: TextStyle(color: AppColors.textColor))),
        TextButton(onPressed: () {}, child: const Text('The Insight Lab', style: TextStyle(color: AppColors.textColor))),
        TextButton(onPressed: () {}, child: const Text('Green Action Plan', style: TextStyle(color: AppColors.textColor))),
        TextButton(onPressed: () {}, child: const Text('Impact Stories', style: TextStyle(color: AppColors.textColor))),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}