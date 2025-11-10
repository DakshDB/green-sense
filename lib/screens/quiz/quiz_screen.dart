import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/data/quiz_data.dart';
import 'package:green_sense/providers/quiz_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class QuizScreen extends StatefulWidget {
  final String quizId;

  const QuizScreen({
    super.key,
    required this.quizId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswer;
  bool _showFeedback = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().startQuiz(widget.quizId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final quiz = quizzesData.firstWhere(
          (q) => q.id == widget.quizId,
          orElse: () => quizzesData.first,
        );

        if (provider.currentQuiz != widget.quizId) {
          return PageScaffold(
            showAppBar: true,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final currentQuestion = quiz.questions[provider.currentQuestionIndex];
        final progress = (provider.currentQuestionIndex + 1) / quiz.questions.length;

        return PageScaffold(
          showAppBar: true,
          body: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Quiz Header
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
                        Text(
                          quiz.title,
                          style: Responsive.isMobile(context)
                              ? AppStyles.headline3
                              : AppStyles.headline2,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildBadge(
                              quiz.difficulty,
                              _getDifficultyColor(quiz.difficulty),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Score: ${provider.score}/${quiz.questions.length}',
                              style: AppStyles.bodyText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${provider.currentQuestionIndex + 1} of ${quiz.questions.length}',
                        style: AppStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.borderColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                          minHeight: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Question Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.question,
                          style: Responsive.isMobile(context)
                              ? AppStyles.headline3
                              : AppStyles.headline2,
                        ),
                        const SizedBox(height: 32),
                        ...currentQuestion.options.asMap().entries.map((entry) {
                          final index = entry.key;
                          final option = entry.value;
                          final isSelected = _selectedAnswer == index;
                          final isCorrect =
                              index == currentQuestion.correctAnswer;

                          Color? backgroundColor;
                          Color? borderColor;
                          Color? textColor;

                          if (_showFeedback) {
                            if (isCorrect) {
                              backgroundColor =
                                  AppColors.primaryColor.withOpacity(0.1);
                              borderColor = AppColors.primaryColor;
                              textColor = AppColors.primaryColor;
                            } else if (isSelected) {
                              backgroundColor =
                                  const Color(0xFFEF4444).withOpacity(0.1);
                              borderColor = const Color(0xFFEF4444);
                              textColor = const Color(0xFFEF4444);
                            }
                          } else if (isSelected) {
                            backgroundColor =
                                AppColors.primaryColor.withOpacity(0.1);
                            borderColor = AppColors.primaryColor;
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: _showFeedback
                                  ? null
                                  : () {
                                      setState(() {
                                        _selectedAnswer = index;
                                      });
                                    },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: backgroundColor ?? Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderColor ?? AppColors.borderColor,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: backgroundColor ?? Colors.transparent,
                                        border: Border.all(
                                          color: borderColor ?? AppColors.borderColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: textColor ?? AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: AppStyles.bodyText.copyWith(
                                          color: textColor,
                                          fontWeight: isSelected || (_showFeedback && isCorrect)
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (_showFeedback && isCorrect)
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.primaryColor,
                                      ),
                                    if (_showFeedback && isSelected && !isCorrect)
                                      const Icon(
                                        Icons.cancel,
                                        color: Color(0xFFEF4444),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Feedback Section
                  if (_showFeedback) ...[
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _isCorrect
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isCorrect
                              ? AppColors.primaryColor
                              : const Color(0xFFEF4444),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isCorrect ? Icons.check_circle : Icons.cancel,
                                color: _isCorrect
                                    ? AppColors.primaryColor
                                    : const Color(0xFFEF4444),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _isCorrect ? 'Correct!' : 'Incorrect',
                                style: AppStyles.headline3.copyWith(
                                  color: _isCorrect
                                      ? AppColors.primaryColor
                                      : const Color(0xFFEF4444),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            currentQuestion.explanation,
                            style: AppStyles.bodyText,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!_showFeedback)
                        ElevatedButton(
                          onPressed: _selectedAnswer == null
                              ? null
                              : () {
                                  setState(() {
                                    _isCorrect = _selectedAnswer ==
                                        currentQuestion.correctAnswer;
                                    _showFeedback = true;
                                    if (_isCorrect) {
                                      provider.answerQuestion(_selectedAnswer!);
                                    } else {
                                      provider.answerQuestion(-1);
                                    }
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            disabledBackgroundColor:
                                AppColors.textSecondary.withOpacity(0.3),
                          ),
                          child: const Text('Submit Answer'),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: () {
                            if (provider.currentQuestionIndex ==
                                quiz.questions.length - 1) {
                              context.go('/quiz/${widget.quizId}/result');
                            } else {
                              setState(() {
                                _selectedAnswer = null;
                                _showFeedback = false;
                                _isCorrect = false;
                                provider.nextQuestion();
                              });
                            }
                          },
                          icon: Icon(
                            provider.currentQuestionIndex ==
                                    quiz.questions.length - 1
                                ? Icons.emoji_events
                                : Icons.arrow_forward,
                          ),
                          label: Text(
                            provider.currentQuestionIndex ==
                                    quiz.questions.length - 1
                                ? 'View Results'
                                : 'Next Question',
                          ),
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

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: AppStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
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
