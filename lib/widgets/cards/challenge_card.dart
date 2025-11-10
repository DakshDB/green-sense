import 'package:flutter/material.dart';
import 'package:green_sense/models/challenge.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final bool isCompleted;
  final VoidCallback onComplete;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    this.isCompleted = false,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor.withOpacity(0.05),
              AppColors.accentGreen.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCompleted
                        ? Colors.green
                        : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.emoji_events,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCompleted ? 'Challenge Completed!' : 'Today\'s Challenge',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor().withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            challenge.category.toString().split('.').last.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                challenge.title,
                style: AppStyles.headline3,
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                challenge.description,
                style: AppStyles.bodyText,
              ),
              const SizedBox(height: 20),
              // Points
              Row(
                children: [
                  const Icon(
                    Icons.stars,
                    size: 20,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Earn ${challenge.points} points',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isCompleted ? null : onComplete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted
                      ? Colors.grey
                      : AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isCompleted ? 'Completed!' : 'I Did It!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (challenge.category) {
      case ChallengeCategory.energy:
        return Colors.orange;
      case ChallengeCategory.waste:
        return Colors.brown;
      case ChallengeCategory.transport:
        return Colors.blue;
      case ChallengeCategory.food:
        return Colors.green;
      case ChallengeCategory.water:
        return Colors.cyan;
      case ChallengeCategory.community:
        return Colors.purple;
    }
  }
}
