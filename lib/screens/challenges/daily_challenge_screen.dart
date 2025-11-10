import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/providers/challenge_provider.dart';
import 'package:green_sense/services/challenge_service.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeProvider>(
      builder: (context, provider, child) {
        final todayChallenge = ChallengeService.getTodayChallenge();
        final isTodayCompleted = provider.isChallengeCompleted(todayChallenge.id);
        final streak = provider.currentStreak;
        final totalCompleted = provider.completedChallenges.length;
        final longestStreak = provider.longestStreak;

        return PageScaffold(
          title: 'Daily Challenge',
          body: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Stats Cards
                  _buildStatsSection(
                    streak,
                    totalCompleted,
                    longestStreak,
                    context,
                  ),

                  const SizedBox(height: 32),

                  // Today's Challenge Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _getCategoryIcon(todayChallenge.category),
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Today\'s Challenge',
                                    style: AppStyles.bodyText.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().toString().split(' ')[0],
                                    style: AppStyles.caption.copyWith(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildDifficultyBadge(
                              todayChallenge.difficulty,
                              Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          todayChallenge.title,
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          todayChallenge.description,
                          style: AppStyles.bodyText.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (isTodayCompleted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Completed!',
                                  style: AppStyles.headline3.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ElevatedButton.icon(
                            onPressed: () {
                              provider.completeChallenge(todayChallenge.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Great job! Challenge completed! 🎉',
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('I Did It!'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Calendar View
                  _buildCalendarSection(provider, context),

                  const SizedBox(height: 32),

                  // Challenge History
                  _buildHistorySection(provider, context),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsSection(
    int streak,
    int totalCompleted,
    int longestStreak,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 16),
        Responsive.isMobile(context)
            ? Column(
                children: [
                  _buildStatCard(
                    'Current Streak',
                    '🔥 $streak Days',
                    AppColors.primaryColor,
                    context,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Total Completed',
                    '$totalCompleted',
                    const Color(0xFF3B82F6),
                    context,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    'Longest Streak',
                    '$longestStreak Days',
                    const Color(0xFFF59E0B),
                    context,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Current Streak',
                      '🔥 $streak Days',
                      AppColors.primaryColor,
                      context,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Total Completed',
                      '$totalCompleted',
                      const Color(0xFF3B82F6),
                      context,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Longest Streak',
                      '$longestStreak Days',
                      const Color(0xFFF59E0B),
                      context,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(
    ChallengeProvider provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last 30 Days',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: _buildCalendarGrid(provider, context),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(ChallengeProvider provider, BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(30, (index) {
      return now.subtract(Duration(days: 29 - index));
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 7 : 10,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final dateStr = day.toString().split(' ')[0];
        final isCompleted = provider.completedChallenges.any((challenge) {
          return challenge['date'] == dateStr;
        });

        return Tooltip(
          message: dateStr,
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primaryColor
                  : AppColors.borderColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistorySection(
    ChallengeProvider provider,
    BuildContext context,
  ) {
    final history = provider.completedChallenges.reversed.take(10).toList();

    if (history.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Challenge History',
            style: AppStyles.headline2,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: AppColors.borderColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No completed challenges yet',
                    style: AppStyles.subtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete today\'s challenge to get started!',
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenge History',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 16),
        Text(
          'Your recently completed challenges',
          style: AppStyles.bodyText.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        ...history.map((challenge) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge['title'],
                        style: AppStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        challenge['date'],
                        style: AppStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDifficultyBadge(
                  challenge['difficulty'],
                  _getDifficultyColor(challenge['difficulty']),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDifficultyBadge(String difficulty, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        difficulty,
        style: AppStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'energy':
        return Icons.bolt;
      case 'waste':
        return Icons.recycling;
      case 'transportation':
        return Icons.directions_car;
      case 'food':
        return Icons.restaurant;
      case 'water':
        return Icons.water_drop;
      default:
        return Icons.eco;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.primaryColor;
      case 'medium':
        return const Color(0xFFF59E0B);
      case 'hard':
        return const Color(0xFFEF4444);
      default:
        return AppColors.primaryColor;
    }
  }
}
