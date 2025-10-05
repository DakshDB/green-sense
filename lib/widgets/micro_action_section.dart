import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class MicroActionSection extends StatelessWidget {
  const MicroActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Text('Where Do You Want to Start?', style: AppStyles.headline2),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;
              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildActionCard(
                    icon: Icons.eco,
                    text: 'Food: Easy Swaps for a Lighter Footprint.',
                    isMobile: isMobile,
                  ),
                  if (isMobile) const SizedBox(height: 20),
                  _buildActionCard(
                    icon: Icons.repartition,
                    text: 'Waste: Master the Art of Reduce, Reuse, Repair.',
                    isMobile: isMobile,
                  ),
                  if (isMobile) const SizedBox(height: 20),
                  _buildActionCard(
                    icon: Icons.lightbulb_outline,
                    text: 'Energy: Low-Effort Tips to Cut Consumption.',
                    isMobile: isMobile,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Explore All Actions', style: AppStyles.button),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String text, bool isMobile = false}) {
    final card = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppColors.primaryColor),
            const SizedBox(height: 16),
            Text(text, textAlign: TextAlign.center, style: AppStyles.bodyText.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );

    return isMobile ? card : Expanded(flex: 1, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: card));
  }
}