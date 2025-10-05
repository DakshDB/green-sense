import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_styles.dart';

class PersonalRelevanceSection extends StatelessWidget {
  const PersonalRelevanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFactCard(
                icon: Icons.favorite_border,
                title: 'Breathe Easier.',
                text: 'Cleaner choices today mean better air quality in your community tomorrow.',
                isMobile: isMobile,
              ),
              if (isMobile) const SizedBox(height: 20),
              _buildFactCard(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Save Your Money.',
                text: 'Simple home efficiency tweaks can cut your utility bills by up to 20% annually.',
                isMobile: isMobile,
              ),
              if (isMobile) const SizedBox(height: 20),
              _buildFactCard(
                icon: Icons.people_outline,
                title: 'Grow Your Local Area.',
                text: 'Supporting local sustainable businesses strengthens your neighborhood economy.',
                isMobile: isMobile,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFactCard({required IconData icon, required String title, required String text, bool isMobile = false}) {
    final card = Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.green.shade700),
            const SizedBox(height: 16),
            Text(title, style: AppStyles.headline2.copyWith(fontSize: 22)),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.center, style: AppStyles.bodyText),
          ],
        ),
      ),
    );

    return isMobile ? card : Expanded(flex: 1, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: card));
  }
}