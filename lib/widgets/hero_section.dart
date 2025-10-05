import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your Choices, Their Future: Start Living Green.',
            textAlign: TextAlign.center,
            style: AppStyles.headline1,
          ),
          const SizedBox(height: 20),
          const Text(
            'Every green seed of awareness grows a brighter future.',
            textAlign: TextAlign.center,
            style: AppStyles.subtitle,
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 600),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.eco,
                    size: 120,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Inspiring Future',
                    style: AppStyles.headline2.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Start My Green Journey', style: AppStyles.button),
          ),
        ],
      ),
    );
  }
}