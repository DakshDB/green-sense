import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_grid.dart';
import 'package:green_sense/widgets/cards/story_card.dart';
import 'package:green_sense/data/stories_data.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';

class ImpactStoriesScreen extends StatefulWidget {
  const ImpactStoriesScreen({super.key});

  @override
  State<ImpactStoriesScreen> createState() => _ImpactStoriesScreenState();
}

class _ImpactStoriesScreenState extends State<ImpactStoriesScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Individual', 'Community', 'Corporate'];

  @override
  Widget build(BuildContext context) {
    final filteredStories = _selectedFilter == 'All'
        ? storiesData
        : storiesData.where((story) => story.type == _selectedFilter.toLowerCase()).toList();

    return PageScaffold(
      title: 'Impact Stories',
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
                  'Real Stories, Real Impact',
                  style: Responsive.isMobile(context)
                      ? AppStyles.headline2
                      : AppStyles.headline1,
                ),
                const SizedBox(height: 16),
                Text(
                  'Discover how individuals, communities, and organizations are making a difference',
                  style: AppStyles.subtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${storiesData.length} Stories of Change',
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

          const SizedBox(height: 32),

          // Filter Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 24 : 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Type',
                  style: AppStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.primaryColor.withOpacity(0.2),
                      checkmarkColor: AppColors.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Stories Grid
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 24 : 48,
            ),
            child: filteredStories.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(48),
                      child: Column(
                        children: [
                          Icon(
                            Icons.filter_list_off,
                            size: 64,
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No stories found',
                            style: AppStyles.subtitle.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try selecting a different filter',
                            style: AppStyles.bodyText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ResponsiveGrid(
                    children: filteredStories.map((story) {
                      return StoryCard(story: story);
                    }).toList(),
                  ),
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
