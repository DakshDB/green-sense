import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/ui/share_button.dart';
import 'package:green_sense/data/quiz_data.dart';
import 'package:green_sense/providers/quiz_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class QuizResultScreen extends StatelessWidget {
  final String quizId;

  const QuizResultScreen({
    super.key,
    required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final quiz = quizzesData.firstWhere(
          (q) => q.id == quizId,
          orElse: () => quizzesData.first,
        );

        final score = provider.score;
        final total = quiz.questions.length;
        final percentage = (score / total * 100).round();
        final badge = _getBadge(percentage);

        return PageScaffold(
          showAppBar: true,
          body: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Results Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getBadgeColor(percentage),
                          _getBadgeColor(percentage).withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _getBadgeColor(percentage).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getBadgeIcon(percentage),
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          badge,
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 32 : 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getCongratulationsMessage(percentage),
                          style: AppStyles.subtitle.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Your Score',
                                style: AppStyles.bodyText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$score',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' / $total',
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$percentage% Correct',
                                style: AppStyles.headline3.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Questions Review
                  Text(
                    'Question Review',
                    style: AppStyles.headline2,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Review all questions and their correct answers',
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ...quiz.questions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final question = entry.value;
                    final userAnswered = provider.getUserAnswer(index);
                    final isCorrect = userAnswered == question.correctAnswer;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCorrect
                              ? AppColors.primaryColor
                              : const Color(0xFFEF4444),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? AppColors.primaryColor.withOpacity(0.1)
                                      : const Color(0xFFEF4444).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: isCorrect
                                      ? AppColors.primaryColor
                                      : const Color(0xFFEF4444),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Question ${index + 1}',
                                  style: AppStyles.headline3.copyWith(
                                    color: isCorrect
                                        ? AppColors.primaryColor
                                        : const Color(0xFFEF4444),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            question.question,
                            style: AppStyles.bodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Correct Answer:',
                                      style: AppStyles.bodyText.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  question.options[question.correctAnswer],
                                  style: AppStyles.bodyText,
                                ),
                              ],
                            ),
                          ),
                          if (!isCorrect) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        color: const Color(0xFFEF4444),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Your Answer:',
                                        style: AppStyles.bodyText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFEF4444),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    userAnswered >= 0
                                        ? question.options[userAnswered]
                                        : 'Not answered',
                                    style: AppStyles.bodyText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Explanation:',
                                      style: AppStyles.bodyText.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  question.explanation,
                                  style: AppStyles.bodyText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 32),

                  // Recommendations
                  if (percentage < 80) ...[
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
                                Icons.school,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Keep Learning!',
                                style: AppStyles.headline3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _getRecommendation(percentage, quiz.category),
                            style: AppStyles.bodyText,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.go('/insight-lab');
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: const Text('Explore Articles'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            provider.resetQuiz();
                            context.go('/quiz/$quizId');
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retake Quiz'),
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
                            context.go('/quiz');
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('More Quizzes'),
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

                  const SizedBox(height: 24),

                  // Share Button
                  Center(
                    child: ShareButton(
                      text: 'I scored $percentage% on the "${ quiz.title}" quiz on Green Sense! Test your knowledge too!',
                    ),
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

  String _getBadge(int percentage) {
    if (percentage >= 81) return 'Master';
    if (percentage >= 61) return 'Expert';
    if (percentage >= 41) return 'Learner';
    return 'Novice';
  }

  IconData _getBadgeIcon(int percentage) {
    if (percentage >= 81) return Icons.diamond;
    if (percentage >= 61) return Icons.emoji_events;
    if (percentage >= 41) return Icons.star;
    return Icons.local_fire_department;
  }

  Color _getBadgeColor(int percentage) {
    if (percentage >= 81) return const Color(0xFF8B5CF6);
    if (percentage >= 61) return const Color(0xFFF59E0B);
    if (percentage >= 41) return const Color(0xFF3B82F6);
    return const Color(0xFFEF4444);
  }

  String _getCongratulationsMessage(int percentage) {
    if (percentage >= 81) return 'Outstanding! You\'re a climate champion!';
    if (percentage >= 61) return 'Great job! You really know your stuff!';
    if (percentage >= 41) return 'Good effort! Keep learning!';
    return 'Nice try! Review the questions to improve!';
  }

  String _getRecommendation(int percentage, String category) {
    if (percentage < 40) {
      return 'Visit our Insight Lab to learn more about $category and strengthen your knowledge base.';
    } else if (percentage < 60) {
      return 'You\'re on the right track! Explore related articles in our Insight Lab to deepen your understanding of $category.';
    } else {
      return 'Almost there! Check out our advanced articles on $category to reach expert level.';
    }
  }
}
