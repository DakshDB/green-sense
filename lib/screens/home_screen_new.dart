import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/section_wrapper.dart';
import 'package:green_sense/widgets/ui/section_header.dart';
import 'package:green_sense/widgets/ui/custom_button.dart';
import 'package:green_sense/widgets/cards/article_card.dart';
import 'package:green_sense/widgets/cards/action_card.dart';
import 'package:green_sense/widgets/cards/story_card.dart';
import 'package:green_sense/widgets/cards/challenge_card.dart';
import 'package:green_sense/widgets/cards/stat_card.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:green_sense/data/articles_data.dart';
import 'package:green_sense/data/actions_data.dart';
import 'package:green_sense/data/stories_data.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/providers/challenge_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      body: Column(
        children: [
          _HeroSection(),
          _FeaturedArticlesSection(),
          _QuickActionsSection(),
          _ImpactStoriesSection(),
          _DailyChallengeSection(),
          _CallToActionSection(),
          _StatsSection(),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.isMobile(context) ? 400 : 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryGreen,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SectionWrapper(
        padding: EdgeInsets.zero,
        child: Center(
          child: FadeInDown(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.eco,
                  size: Responsive.isMobile(context) ? 60 : 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'Every Green Seed Grows\nA Brighter Future',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 28 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Join thousands making a difference through small daily actions',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 16 : 20,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Calculate Your Impact',
                      onPressed: () => context.go('/calculator'),
                      variant: ButtonVariant.primary,
                      icon: Icons.calculate,
                    ),
                    const SizedBox(width: 16),
                    CustomButton(
                      text: 'Take the Pledge',
                      onPressed: () => context.go('/pledge'),
                      variant: ButtonVariant.outline,
                      icon: Icons.volunteer_activism,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedArticlesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = articlesData.take(3).toList();

    return SectionWrapper(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          FadeInUp(
            child: SectionHeader(
              title: 'Latest Insights',
              subtitle: 'Stay informed about environmental topics',
              actionText: 'View All',
              onAction: () => context.go('/insight-lab'),
            ),
          ),
          const SizedBox(height: 40),
          Responsive.isMobile(context)
            ? Column(
                children: articles
                  .map((article) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FadeInUp(
                      child: ArticleCard(article: article),
                    ),
                  ))
                  .toList(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: articles
                  .map((article) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FadeInUp(
                        child: ArticleCard(article: article),
                      ),
                    ),
                  ))
                  .toList(),
              ),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = actionsData.take(3).toList();

    return SectionWrapper(
      backgroundColor: AppColors.backgroundGreen,
      child: Column(
        children: [
          FadeInUp(
            child: SectionHeader(
              title: 'Quick Green Actions',
              subtitle: 'Easy steps you can take today',
              actionText: 'View All',
              onAction: () => context.go('/action-plan'),
            ),
          ),
          const SizedBox(height: 40),
          Responsive.isMobile(context)
            ? Column(
                children: actions
                  .map((action) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FadeInUp(
                      child: ActionCard(action: action),
                    ),
                  ))
                  .toList(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: actions
                  .map((action) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FadeInUp(
                        child: ActionCard(action: action),
                      ),
                    ),
                  ))
                  .toList(),
              ),
        ],
      ),
    );
  }
}

class _ImpactStoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final story = storiesData.first;

    return SectionWrapper(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          FadeInUp(
            child: SectionHeader(
              title: 'Impact Stories',
              subtitle: 'Real people making a real difference',
              actionText: 'View All',
              onAction: () => context.go('/impact-stories'),
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            child: StoryCard(story: story),
          ),
        ],
      ),
    );
  }
}

class _DailyChallengeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final challengeProvider = context.watch<ChallengeProvider>();
    final challenge = challengeProvider.todayChallenge;

    if (challenge == null) return const SizedBox.shrink();

    return SectionWrapper(
      backgroundColor: AppColors.backgroundGreen,
      child: Column(
        children: [
          FadeInUp(
            child: const SectionHeader(
              title: 'Today\'s Challenge',
              subtitle: 'Complete daily challenges to build your streak',
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            child: ChallengeCard(
              challenge: challenge,
              isCompleted: challengeProvider.isTodayCompleted,
              onComplete: () => challengeProvider.completeChallenge(),
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(
            child: CustomButton(
              text: 'View All Challenges',
              onPressed: () => context.go('/challenges'),
              variant: ButtonVariant.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallToActionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.accentGreen,
          ],
        ),
      ),
      child: SectionWrapper(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.isMobile(context) ? 40 : 80,
        ),
        child: FadeInUp(
          child: Column(
            children: [
              Text(
                'Ready to Make a Difference?',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Calculate your carbon footprint and discover personalized actions',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 16 : 18,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Get Started Now',
                onPressed: () => context.go('/calculator'),
                variant: ButtonVariant.primary,
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          FadeInUp(
            child: const SectionHeader(
              title: 'Our Impact Together',
              subtitle: 'Join our growing community',
              centered: true,
            ),
          ),
          const SizedBox(height: 40),
          Responsive.isMobile(context)
            ? Column(
                children: const [
                  StatCard(
                    icon: Icons.people,
                    value: '10K+',
                    label: 'Active Members',
                    delay: 0,
                  ),
                  SizedBox(height: 20),
                  StatCard(
                    icon: Icons.eco,
                    value: '50K',
                    label: 'Actions Taken',
                    color: Colors.green,
                    delay: 100,
                  ),
                  SizedBox(height: 20),
                  StatCard(
                    icon: Icons.cloud,
                    value: '2M kg',
                    label: 'CO2 Reduced',
                    color: Colors.blue,
                    delay: 200,
                  ),
                ],
              )
            : Row(
                children: const [
                  Expanded(
                    child: StatCard(
                      icon: Icons.people,
                      value: '10K+',
                      label: 'Active Members',
                      delay: 0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: StatCard(
                      icon: Icons.eco,
                      value: '50K',
                      label: 'Actions Taken',
                      color: Colors.green,
                      delay: 100,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: StatCard(
                      icon: Icons.cloud,
                      value: '2M kg',
                      label: 'CO2 Reduced',
                      color: Colors.blue,
                      delay: 200,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
