import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/providers/pledge_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class PledgeTrackerScreen extends StatelessWidget {
  const PledgeTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PledgeProvider>(
      builder: (context, provider, child) {
        if (provider.currentPledge.isEmpty) {
          return PageScaffold(
            showAppBar: true,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.eco_outlined,
                    size: 80,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No Pledge Yet',
                    style: AppStyles.headline2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create your green pledge to start tracking',
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/pledge');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create Pledge'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final progress = provider.getProgress();
        final completedCount = provider.getCompletedCount();
        final totalCount = provider.currentPledge.length;
        final streak = provider.getStreak();

        return PageScaffold(
          title: 'Pledge Tracker',
          body: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Progress Overview
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
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Overall Progress',
                          style: AppStyles.headline3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CircularProgressIndicator(
                                value: progress / 100,
                                strokeWidth: 12,
                                backgroundColor:
                                    Colors.white.withOpacity(0.3),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${progress.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$completedCount of $totalCount',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _getMotivationalMessage(progress),
                          style: AppStyles.bodyText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Stats Row
                  _buildStatsRow(streak, completedCount, totalCount, context),

                  const SizedBox(height: 32),

                  // Commitments List
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Commitments',
                        style: AppStyles.headline2,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.go('/pledge');
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Update'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Track your daily progress on each commitment',
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ...provider.currentPledge.map((commitment) {
                    final isCompleted =
                        provider.isCommitmentCompleted(commitment);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCompleted
                              ? AppColors.primaryColor
                              : AppColors.borderColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CheckboxListTile(
                        value: isCompleted,
                        onChanged: (value) {
                          provider.toggleCommitment(commitment);
                        },
                        title: Text(
                          commitment,
                          style: AppStyles.bodyText.copyWith(
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: isCompleted
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                        secondary: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : AppColors.borderColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isCompleted ? Icons.check_circle : Icons.eco,
                            color: isCompleted
                                ? AppColors.primaryColor
                                : AppColors.textSecondary,
                          ),
                        ),
                        activeColor: AppColors.primaryColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 32),

                  // Tracking Options
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(0.1),
                          AppColors.accentColor.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Tracking Tips',
                              style: AppStyles.headline3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTipItem(
                          'Check off commitments as you complete them each day',
                        ),
                        _buildTipItem(
                          'Build a streak by completing commitments consistently',
                        ),
                        _buildTipItem(
                          'Update your pledge anytime to add or remove commitments',
                        ),
                        _buildTipItem(
                          'Share your progress to inspire others',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            provider.resetTracking();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tracking reset for today'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset Today'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                            side: BorderSide(color: AppColors.primaryColor),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.go('/action-plan');
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Action Guides'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsRow(
    int streak,
    int completed,
    int total,
    BuildContext context,
  ) {
    return Responsive.isMobile(context)
        ? Column(
            children: [
              _buildStatCard('🔥 Streak', '$streak Days', context),
              const SizedBox(height: 12),
              _buildStatCard('✓ Completed Today', '$completed', context),
              const SizedBox(height: 12),
              _buildStatCard('📋 Total Goals', '$total', context),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: _buildStatCard('🔥 Streak', '$streak Days', context),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('✓ Completed Today', '$completed', context),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('📋 Total Goals', '$total', context),
              ),
            ],
          );
  }

  Widget _buildStatCard(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppStyles.headline2.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppStyles.bodyText,
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage(double progress) {
    if (progress == 100) {
      return 'Perfect! You completed all your commitments today! 🎉';
    } else if (progress >= 75) {
      return 'Almost there! Keep up the great work! 💪';
    } else if (progress >= 50) {
      return 'You\'re doing great! Stay committed! 🌱';
    } else if (progress >= 25) {
      return 'Good start! Keep going! 🌿';
    } else if (progress > 0) {
      return 'Every action counts! Continue your journey! 🌍';
    } else {
      return 'Start tracking your commitments today! 🚀';
    }
  }
}
