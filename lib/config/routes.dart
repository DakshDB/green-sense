import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_sense/screens/home_screen.dart';
import 'package:green_sense/screens/insight_lab/insight_lab_screen.dart';
import 'package:green_sense/screens/insight_lab/article_detail_screen.dart';
import 'package:green_sense/screens/action_plan/action_plan_screen.dart';
import 'package:green_sense/screens/action_plan/action_detail_screen.dart';
import 'package:green_sense/screens/impact_stories/impact_stories_screen.dart';
import 'package:green_sense/screens/impact_stories/story_detail_screen.dart';
import 'package:green_sense/screens/calculator/calculator_screen.dart';
import 'package:green_sense/screens/calculator/calculator_result_screen.dart';
import 'package:green_sense/screens/quiz/quiz_list_screen.dart';
import 'package:green_sense/screens/quiz/quiz_screen.dart';
import 'package:green_sense/screens/quiz/quiz_result_screen.dart';
import 'package:green_sense/screens/challenges/daily_challenge_screen.dart';
import 'package:green_sense/screens/pledge/pledge_screen.dart';
import 'package:green_sense/screens/pledge/pledge_card_screen.dart';
import 'package:green_sense/screens/pledge/pledge_tracker_screen.dart';
import 'package:green_sense/screens/about/about_screen.dart';
import 'package:green_sense/screens/contact/contact_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/insight-lab',
      builder: (context, state) => const InsightLabScreen(),
    ),
    GoRoute(
      path: '/insight-lab/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ArticleDetailScreen(articleId: id);
      },
    ),
    GoRoute(
      path: '/action-plan',
      builder: (context, state) => const ActionPlanScreen(),
    ),
    GoRoute(
      path: '/action-plan/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ActionDetailScreen(actionId: id);
      },
    ),
    GoRoute(
      path: '/impact-stories',
      builder: (context, state) => const ImpactStoriesScreen(),
    ),
    GoRoute(
      path: '/impact-stories/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return StoryDetailScreen(storyId: id);
      },
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorScreen(),
    ),
    GoRoute(
      path: '/calculator/result',
      builder: (context, state) => const CalculatorResultScreen(),
    ),
    GoRoute(
      path: '/quiz',
      builder: (context, state) => const QuizListScreen(),
    ),
    GoRoute(
      path: '/quiz/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return QuizScreen(quizId: id);
      },
    ),
    GoRoute(
      path: '/quiz/:id/result',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return QuizResultScreen(quizId: id);
      },
    ),
    GoRoute(
      path: '/challenges',
      builder: (context, state) => const DailyChallengeScreen(),
    ),
    GoRoute(
      path: '/pledge',
      builder: (context, state) => const PledgeScreen(),
    ),
    GoRoute(
      path: '/pledge/card',
      builder: (context, state) {
        final commitments = state.extra as List<String>;
        return PledgeCardScreen(commitments: commitments);
      },
    ),
    GoRoute(
      path: '/pledge/tracker',
      builder: (context, state) => const PledgeTrackerScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
  ],
);
