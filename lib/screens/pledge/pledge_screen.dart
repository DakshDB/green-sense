import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/cards/pledge_card.dart';
import 'package:green_sense/data/pledge_data.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class PledgeScreen extends StatefulWidget {
  const PledgeScreen({super.key});

  @override
  State<PledgeScreen> createState() => _PledgeScreenState();
}

class _PledgeScreenState extends State<PledgeScreen> {
  final Set<String> _selectedCommitments = {};

  @override
  Widget build(BuildContext context) {
    final canProceed =
        _selectedCommitments.length >= 3 && _selectedCommitments.length <= 5;

    return PageScaffold(
      title: 'Green Pledge',
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Introduction Section
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.1),
                      AppColors.accentColor.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.eco,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Make Your Green Pledge',
                            style: Responsive.isMobile(context)
                                ? AppStyles.headline3
                                : AppStyles.headline2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Commit to sustainable actions that make a real difference. Choose 3-5 commitments that you can realistically maintain in your daily life.',
                      style: AppStyles.bodyText.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Select between 3 and 5 commitments to create your personalized pledge',
                              style: AppStyles.bodyText.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Selection Counter
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _selectedCommitments.length >= 3
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : AppColors.borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedCommitments.length >= 3
                        ? AppColors.primaryColor
                        : AppColors.borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _selectedCommitments.length >= 3
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: _selectedCommitments.length >= 3
                          ? AppColors.primaryColor
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${_selectedCommitments.length} of 3-5 commitments selected',
                        style: AppStyles.bodyText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _selectedCommitments.length >= 3
                              ? AppColors.primaryColor
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    if (_selectedCommitments.length > 5)
                      Text(
                        'Too many!',
                        style: AppStyles.caption.copyWith(
                          color: const Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Commitments Grid
              Text(
                'Choose Your Commitments',
                style: AppStyles.headline2,
              ),
              const SizedBox(height: 24),

              ...pledgeCommitmentsData.entries.map((entry) {
                final category = entry.key;
                final commitments = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(category),
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            category,
                            style: AppStyles.headline3.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...commitments.map((commitment) {
                      return PledgeCard(
                        commitment: commitment,
                        isSelected: _selectedCommitments.contains(commitment),
                        onChanged: (selected) {
                          setState(() {
                            if (selected) {
                              if (_selectedCommitments.length < 5) {
                                _selectedCommitments.add(commitment);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'You can select a maximum of 5 commitments',
                                    ),
                                    backgroundColor: const Color(0xFFF59E0B),
                                  ),
                                );
                              }
                            } else {
                              _selectedCommitments.remove(commitment);
                            }
                          });
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),

              const SizedBox(height: 32),

              // Create Pledge Button
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: canProceed
                          ? () {
                              context.go(
                                '/pledge/card',
                                extra: _selectedCommitments.toList(),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.create),
                      label: const Text('Create My Pledge'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.textSecondary.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 20,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (!canProceed) ...[
                      const SizedBox(height: 12),
                      Text(
                        _selectedCommitments.length < 3
                            ? 'Select at least ${3 - _selectedCommitments.length} more commitment(s)'
                            : 'Please select no more than 5 commitments',
                        style: AppStyles.caption.copyWith(
                          color: const Color(0xFFF59E0B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'energy':
        return Icons.bolt;
      case 'transportation':
        return Icons.directions_car;
      case 'food':
        return Icons.restaurant;
      case 'waste':
        return Icons.recycling;
      case 'water':
        return Icons.water_drop;
      case 'lifestyle':
        return Icons.eco;
      default:
        return Icons.check_circle;
    }
  }
}
