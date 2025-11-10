import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/config/routes.dart';
import 'package:green_sense/providers/calculator_provider.dart';
import 'package:green_sense/providers/quiz_provider.dart';
import 'package:green_sense/providers/challenge_provider.dart';
import 'package:green_sense/providers/pledge_provider.dart';
import 'package:green_sense/constants/app_colors.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ChallengeProvider()),
        ChangeNotifierProvider(create: (_) => PledgeProvider()),
      ],
      child: MaterialApp.router(
        title: 'Green Sense',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundGreen,
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
