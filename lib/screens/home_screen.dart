import 'package:flutter/material.dart';
import 'package:green_sense/widgets/community_pledge_section.dart';
import 'package:green_sense/widgets/footer.dart';
import 'package:green_sense/widgets/hero_section.dart';
import 'package:green_sense/widgets/home_app_bar.dart';
import 'package:green_sense/widgets/micro_action_section.dart';
import 'package:green_sense/widgets/personal_relevance_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeroSection(),
            SizedBox(height: 20),
            PersonalRelevanceSection(),
            SizedBox(height: 20),
            MicroActionSection(),
            SizedBox(height: 20),
            CommunityPledgeSection(),
            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }
}