import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/ui/share_button.dart';
import 'package:green_sense/widgets/cards/story_card.dart';
import 'package:green_sense/data/stories_data.dart';
import 'package:green_sense/data/actions_data.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class StoryDetailScreen extends StatelessWidget {
  final String storyId;

  const StoryDetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    final story = storiesData.firstWhere(
      (s) => s.id == storyId,
      orElse: () => storiesData.first,
    );

    final relatedStories = storiesData
        .where((s) => s.id != story.id && (s.type == story.type || s.region == story.region))
        .take(3)
        .toList();

    return PageScaffold(
      showAppBar: true,
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Hero Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: Responsive.isMobile(context) ? 250 : 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.accentColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _getIconForType(story.type),
                      size: Responsive.isMobile(context) ? 80 : 120,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Title and Meta
              Text(
                story.title,
                style: Responsive.isMobile(context)
                    ? AppStyles.headline2
                    : AppStyles.headline1,
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildMetaChip(
                    Icons.location_on_outlined,
                    story.region,
                    context,
                  ),
                  _buildMetaChip(
                    Icons.category_outlined,
                    _formatType(story.type),
                    context,
                  ),
                  _buildMetaChip(
                    Icons.calendar_today_outlined,
                    story.year,
                    context,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Impact Metrics
              if (story.impact != null) ...[
                Text(
                  'Impact Metrics',
                  style: AppStyles.headline3,
                ),
                const SizedBox(height: 16),
                _buildImpactMetrics(story.impact!, context),
                const SizedBox(height: 32),
              ],

              // Description
              Text(
                'The Story',
                style: AppStyles.headline3,
              ),
              const SizedBox(height: 16),
              Text(
                story.description,
                style: AppStyles.bodyText.copyWith(height: 1.8),
              ),

              const SizedBox(height: 32),

              // Challenge Section
              _buildSection(
                'The Challenge',
                story.challenge,
                Icons.warning_amber_rounded,
                context,
              ),

              const SizedBox(height: 24),

              // Solution Section
              _buildSection(
                'The Solution',
                story.solution,
                Icons.lightbulb_outline,
                context,
              ),

              const SizedBox(height: 24),

              // Results Section
              _buildSection(
                'The Results',
                story.results,
                Icons.trending_up,
                context,
              ),

              const SizedBox(height: 32),

              // Key Learnings
              if (story.keyLearnings != null && story.keyLearnings!.isNotEmpty) ...[
                Text(
                  'Key Learnings',
                  style: AppStyles.headline3,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.accentColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: story.keyLearnings!.map((learning) {
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
                                learning,
                                style: AppStyles.bodyText,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // What You Can Do
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
                          Icons.eco,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'What You Can Do',
                          style: AppStyles.headline3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Inspired by this story? Take action in your own community!',
                      style: AppStyles.bodyText,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/action-plan');
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Explore Action Guides'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Share Button
              Center(
                child: ShareButton(
                  text: 'Check out this inspiring story: ${story.title} on Green Sense!',
                ),
              ),

              const SizedBox(height: 48),

              // Related Stories
              if (relatedStories.isNotEmpty) ...[
                Text(
                  'Related Stories',
                  style: AppStyles.headline3,
                ),
                const SizedBox(height: 24),
                _buildRelatedStories(relatedStories, context),
                const SizedBox(height: 48),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppStyles.caption.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactMetrics(Map<String, String> impact, BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: impact.entries.map((entry) {
        return Container(
          width: Responsive.isMobile(context)
              ? double.infinity
              : (MediaQuery.of(context).size.width - 128) / 3,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                entry.value,
                style: AppStyles.headline2.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                entry.key,
                style: AppStyles.bodyText.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    IconData icon,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppStyles.headline3,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: AppStyles.bodyText.copyWith(height: 1.8),
        ),
      ],
    );
  }

  Widget _buildRelatedStories(List<dynamic> stories, BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: stories.map((story) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: StoryCard(story: story),
        )).toList(),
      );
    }

    return Row(
      children: stories.map((story) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: StoryCard(story: story),
        ),
      )).toList(),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'individual':
        return Icons.person;
      case 'community':
        return Icons.people;
      case 'corporate':
        return Icons.business;
      default:
        return Icons.eco;
    }
  }

  String _formatType(String type) {
    return type[0].toUpperCase() + type.substring(1);
  }
}
