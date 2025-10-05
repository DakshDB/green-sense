import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.textColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('© 2024 GreenSense. All Rights Reserved.'),
          const SizedBox(width: 20),
          TextButton(onPressed: () {}, child: const Text('About Us')),
          const SizedBox(width: 10),
          TextButton(onPressed: () {}, child: const Text('Contact')),
        ],
      ),
    );
  }
}