import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class CommunityPledgeSection extends StatelessWidget {
  const CommunityPledgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          const Text(
            '10,000+ Pledges Taken',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.headingColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Join the Movement. Be the Change.',
            style: AppStyles.subtitle,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Take the Green Pledge', style: AppStyles.button),
          ),
        ],
      ),
    );
  }
}