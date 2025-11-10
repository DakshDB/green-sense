import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/cards/quiz_card.dart';
import 'package:green_sense/data/quiz_data.dart';
import 'package:green_sense/providers/quiz_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        return PageScaffold(
          title: 'Knowledge Quizzes',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section
              Container(
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 48),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.1),
                      AppColors.accentColor.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Your Knowledge',
                      style: Responsive.isMobile(context)
                          ? AppStyles.headline2
                          : AppStyles.headline1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Challenge yourself with interactive quizzes and earn badges!',
                      style: AppStyles.subtitle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.quiz,
                          label: 'Quizzes',
                          value: '${quizzesData.length}',
                          context: context,
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          icon: Icons.emoji_events,
                          label: 'Badges Earned',
                          value: '${provider.getCompletedQuizzes().length}',
                          context: context,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Quizzes Grid
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 24 : 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Quizzes',
                      style: AppStyles.headline2,
                    ),
                    const SizedBox(height: 24),
                    _buildQuizzesGrid(provider, context),
                  ],
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: AppStyles.headline3.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    label,
                    style: AppStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizzesGrid(QuizProvider provider, BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: quizzesData.map((quiz) {
          final quizResult = provider.getQuizResult(quiz.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: QuizCard(
              quiz: quiz,
              completed: quizResult != null,
              score: quizResult?['score'] as int?,
              totalQuestions: quiz.questions.length,
            ),
          );
        }).toList(),
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: quizzesData.map((quiz) {
        final quizResult = provider.getQuizResult(quiz.id);
        return SizedBox(
          width: (MediaQuery.of(context).size.width -
                  (Responsive.isMobile(context) ? 48 : 96) -
                  32) /
              (Responsive.isDesktop(context) ? 3 : 2),
          child: QuizCard(
            quiz: quiz,
            completed: quizResult != null,
            score: quizResult?['score'] as int?,
            totalQuestions: quiz.questions.length,
          ),
        );
      }).toList(),
    );
  }
}
