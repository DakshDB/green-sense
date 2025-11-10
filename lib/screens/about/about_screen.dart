import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/data/articles_data.dart';
import 'package:green_sense/data/actions_data.dart';
import 'package:green_sense/data/stories_data.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'About Green Sense',
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Hero Section
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
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.eco,
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'About Green Sense',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 32 : 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Every green seed of awareness grows a brighter future',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Mission Statement
              Text(
                'Our Mission',
                style: AppStyles.headline2,
              ),
              const SizedBox(height: 16),
              Text(
                'Green Sense is dedicated to promoting environmental awareness and empowering individuals to take meaningful action against climate change. We believe that every person has the power to make a difference, and through education, inspiration, and practical tools, we help transform awareness into action.',
                style: AppStyles.bodyText.copyWith(height: 1.8),
              ),

              const SizedBox(height: 48),

              // Our Approach
              Text(
                'Our Approach',
                style: AppStyles.headline2,
              ),
              const SizedBox(height: 24),

              _buildApproachCard(
                icon: Icons.school,
                title: 'Educate',
                description:
                    'We provide clear, science-based information about environmental issues through articles, quizzes, and resources that make complex topics accessible to everyone.',
                color: const Color(0xFF3B82F6),
                context: context,
              ),
              const SizedBox(height: 16),

              _buildApproachCard(
                icon: Icons.lightbulb,
                title: 'Empower',
                description:
                    'We offer practical tools like the carbon calculator, action guides, and daily challenges that enable you to measure your impact and make informed choices.',
                color: const Color(0xFFF59E0B),
                context: context,
              ),
              const SizedBox(height: 16),

              _buildApproachCard(
                icon: Icons.people,
                title: 'Inspire',
                description:
                    'We share real success stories from individuals, communities, and organizations that demonstrate how collective action creates meaningful change.',
                color: AppColors.primaryColor,
                context: context,
              ),

              const SizedBox(height: 48),

              // Statistics Showcase
              Text(
                'Impact by Numbers',
                style: AppStyles.headline2,
              ),
              const SizedBox(height: 24),

              Responsive.isMobile(context)
                  ? Column(
                      children: [
                        _buildStatCard(
                          articlesData.length.toString(),
                          'Educational Articles',
                          Icons.article,
                          context,
                        ),
                        const SizedBox(height: 16),
                        _buildStatCard(
                          actionsData.length.toString(),
                          'Action Guides',
                          Icons.task_alt,
                          context,
                        ),
                        const SizedBox(height: 16),
                        _buildStatCard(
                          storiesData.length.toString(),
                          'Success Stories',
                          Icons.star,
                          context,
                        ),
                        const SizedBox(height: 16),
                        _buildStatCard(
                          '1000+',
                          'Community Members',
                          Icons.group,
                          context,
                        ),
                      ],
                    )
                  : Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width -
                                  (Responsive.isDesktop(context) ? 96 : 48) -
                                  32) /
                              (Responsive.isDesktop(context) ? 4 : 2),
                          child: _buildStatCard(
                            articlesData.length.toString(),
                            'Educational Articles',
                            Icons.article,
                            context,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width -
                                  (Responsive.isDesktop(context) ? 96 : 48) -
                                  32) /
                              (Responsive.isDesktop(context) ? 4 : 2),
                          child: _buildStatCard(
                            actionsData.length.toString(),
                            'Action Guides',
                            Icons.task_alt,
                            context,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width -
                                  (Responsive.isDesktop(context) ? 96 : 48) -
                                  32) /
                              (Responsive.isDesktop(context) ? 4 : 2),
                          child: _buildStatCard(
                            storiesData.length.toString(),
                            'Success Stories',
                            Icons.star,
                            context,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width -
                                  (Responsive.isDesktop(context) ? 96 : 48) -
                                  32) /
                              (Responsive.isDesktop(context) ? 4 : 2),
                          child: _buildStatCard(
                            '1000+',
                            'Community Members',
                            Icons.group,
                            context,
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 48),

              // How It Works
              Text(
                'How It Works',
                style: AppStyles.headline2,
              ),
              const SizedBox(height: 24),

              _buildHowItWorksStep(
                1,
                'Learn',
                'Explore articles and quizzes to understand environmental issues',
                Icons.menu_book,
              ),
              _buildHowItWorksStep(
                2,
                'Measure',
                'Calculate your carbon footprint to identify areas for improvement',
                Icons.calculate,
              ),
              _buildHowItWorksStep(
                3,
                'Act',
                'Follow action guides and complete daily challenges',
                Icons.task_alt,
              ),
              _buildHowItWorksStep(
                4,
                'Commit',
                'Make your green pledge and track your progress',
                Icons.eco,
              ),
              _buildHowItWorksStep(
                5,
                'Share',
                'Inspire others by sharing your journey and achievements',
                Icons.share,
              ),

              const SizedBox(height: 48),

              // Contact CTA
              Container(
                padding: const EdgeInsets.all(32),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contact_mail,
                      size: 48,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Get in Touch',
                      style: AppStyles.headline2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Have questions, feedback, or want to collaborate? We\'d love to hear from you!',
                      style: AppStyles.bodyText.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/contact');
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Contact Us'),
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

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApproachCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.headline3.copyWith(color: color),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppStyles.bodyText.copyWith(height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String number,
    String label,
    IconData icon,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppStyles.bodyText.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksStep(
    int step,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppStyles.bodyText.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
