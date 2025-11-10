import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/section_wrapper.dart';
import 'package:green_sense/widgets/layout/responsive_grid.dart';
import 'package:green_sense/widgets/ui/section_header.dart';
import 'package:green_sense/widgets/cards/action_card.dart';
import 'package:green_sense/widgets/forms/dropdown_selector.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/data/actions_data.dart';
import 'package:green_sense/models/action_guide.dart';
import 'package:animate_do/animate_do.dart';

class ActionPlanScreen extends StatefulWidget {
  const ActionPlanScreen({Key? key}) : super(key: key);

  @override
  State<ActionPlanScreen> createState() => _ActionPlanScreenState();
}

class _ActionPlanScreenState extends State<ActionPlanScreen> {
  ActionDifficulty? _selectedDifficulty;

  List<ActionGuide> get _filteredActions {
    if (_selectedDifficulty == null) return actionsData;
    return actionsData.where((action) => action.difficulty == _selectedDifficulty).toList();
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
                title: 'Green Action Plan',
                subtitle: 'Practical steps to reduce your environmental impact',
                centered: true,
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              child: DropdownSelector<ActionDifficulty>(
                label: 'Filter by Difficulty',
                value: _selectedDifficulty,
                hint: 'All Difficulties',
                items: [
                  const DropdownMenuItem(value: null, child: Text('All Difficulties')),
                  ...ActionDifficulty.values.map((difficulty) {
                    return DropdownMenuItem(
                      value: difficulty,
                      child: Text(difficulty.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                ],
                onChanged: (value) => setState(() => _selectedDifficulty = value),
              ),
            ),
            const SizedBox(height: 40),
            ResponsiveGrid(
              children: _filteredActions.map((action) => FadeInUp(child: ActionCard(action: action))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
