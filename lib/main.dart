import 'package:flutter/material.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/screens/home_screen.dart';

void main() {
  runApp(const GreenSenseApp());
}

class GreenSenseApp extends StatelessWidget {
  const GreenSenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenSense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
