import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/ui/share_button.dart';
import 'package:green_sense/widgets/ui/badge.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:green_sense/data/articles_data.dart';
import 'package:green_sense/models/article.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:animate_do/animate_do.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String articleId;

  const ArticleDetailScreen({Key? key, required this.articleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = articlesData.firstWhere(
      (a) => a.id == articleId,
      orElse: () => articlesData.first,
    );

    return PageScaffold(
      body: Column(
        children: [
          // Hero image
          FadeIn(
            child: AspectRatio(
              aspectRatio: Responsive.isMobile(context) ? 16 / 9 : 21 / 9,
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.backgroundGreen,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          // Content
          ResponsiveContainer(
            maxWidth: 800,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  child: Row(
                    children: [
                      Badge(
                        text: article.category.toString().split('.').last.toUpperCase(),
                        variant: BadgeVariant.primary,
                      ),
                      const Spacer(),
                      ShareButton(
                        title: article.title,
                        url: 'https://greensense.com/insight-lab/${article.id}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    article.title,
                    style: AppStyles.headline1,
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${article.readingTime} min read',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        article.publishDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    article.content,
                    style: AppStyles.bodyText.copyWith(
                      fontSize: 18,
                      height: 1.8,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Key Takeaways',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.headingGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...article.keyTakeaways.map((takeaway) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    takeaway,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
