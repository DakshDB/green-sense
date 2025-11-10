import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/ui/share_button.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:green_sense/data/actions_data.dart';
import 'package:animate_do/animate_do.dart';

class ActionDetailScreen extends StatelessWidget {
  final String actionId;

  const ActionDetailScreen({Key? key, required this.actionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final action = actionsData.firstWhere((a) => a.id == actionId, orElse: () => actionsData.first);

    return PageScaffold(
      body: ResponsiveContainer(
        maxWidth: 800,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12)),
                  child: Icon(action.icon, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(action.title, style: AppStyles.headline1)),
                ShareButton(title: action.title, url: 'https://greensense.com/action-plan/${action.id}'),
              ],
            )),
            const SizedBox(height: 24),
            FadeInUp(delay: const Duration(milliseconds: 100), child: Text(action.description, style: AppStyles.bodyText.copyWith(fontSize: 18))),
            const SizedBox(height: 32),
            FadeInUp(delay: const Duration(milliseconds: 200), child: Text('Steps to Take', style: AppStyles.headline2)),
            const SizedBox(height: 16),
            ...action.steps.asMap().entries.map((entry) {
              return FadeInUp(
                delay: Duration(milliseconds: 300 + entry.key * 100),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                        child: Center(child: Text('${entry.key + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 16, height: 1.6))),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
