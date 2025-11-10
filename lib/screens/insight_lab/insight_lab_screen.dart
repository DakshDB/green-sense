import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/section_wrapper.dart';
import 'package:green_sense/widgets/layout/responsive_grid.dart';
import 'package:green_sense/widgets/ui/section_header.dart';
import 'package:green_sense/widgets/cards/article_card.dart';
import 'package:green_sense/widgets/forms/dropdown_selector.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/data/articles_data.dart';
import 'package:green_sense/models/article.dart';
import 'package:animate_do/animate_do.dart';

class InsightLabScreen extends StatefulWidget {
  const InsightLabScreen({Key? key}) : super(key: key);

  @override
  State<InsightLabScreen> createState() => _InsightLabScreenState();
}

class _InsightLabScreenState extends State<InsightLabScreen> {
  ArticleCategory? _selectedCategory;

  List<Article> get _filteredArticles {
    if (_selectedCategory == null) return articlesData;
    return articlesData
      .where((article) => article.category == _selectedCategory)
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: SectionWrapper(
        backgroundColor: AppColors.backgroundGreen,
        child: Column(
          children: [
            FadeInDown(
              child: const SectionHeader(
                title: 'The Insight Lab',
                subtitle: 'Explore environmental topics and expand your knowledge',
                centered: true,
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              child: DropdownSelector<ArticleCategory>(
                label: 'Filter by Category',
                value: _selectedCategory,
                hint: 'All Categories',
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('All Categories'),
                  ),
                  ...ArticleCategory.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.toString().split('.').last.toUpperCase(),
                      ),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            _filteredArticles.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'No articles found in this category.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : ResponsiveGrid(
                  children: _filteredArticles
                    .map((article) => FadeInUp(
                      child: ArticleCard(article: article),
                    ))
                    .toList(),
                ),
          ],
        ),
      ),
    );
  }
}
