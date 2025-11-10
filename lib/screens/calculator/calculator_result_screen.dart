import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/ui/share_button.dart';
import 'package:green_sense/providers/calculator_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class CalculatorResultScreen extends StatelessWidget {
  const CalculatorResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        if (provider.result == null) {
          return PageScaffold(
            showAppBar: true,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No calculation yet',
                    style: AppStyles.headline3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete the calculator to see your results',
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/calculator');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Start Calculator'),
                  ),
                ],
              ),
            ),
          );
        }

        final result = provider.result!;
        final breakdown = result['breakdown'] as Map<String, double>;
        final recommendations = result['recommendations'] as List<String>;

        return PageScaffold(
          showAppBar: true,
          body: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Total Carbon Footprint
                  _buildTotalCard(result['total'] as double, context),

                  const SizedBox(height: 32),

                  // Pie Chart - Breakdown by Category
                  _buildBreakdownSection(breakdown, context),

                  const SizedBox(height: 32),

                  // Comparison Bar Chart
                  _buildComparisonSection(result['total'] as double, context),

                  const SizedBox(height: 32),

                  // Recommendations
                  _buildRecommendationsSection(recommendations, context),

                  const SizedBox(height: 32),

                  // Action Buttons
                  _buildActionButtons(context, result['total'] as double),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalCard(double total, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.eco,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            'Your Annual Carbon Footprint',
            style: AppStyles.headline3.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${total.toStringAsFixed(2)} tons CO₂',
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 42 : 56,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              total < 10
                  ? 'Below Average - Great Job!'
                  : total < 16
                      ? 'Average - Room for Improvement'
                      : 'Above Average - Take Action!',
              style: AppStyles.bodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownSection(
      Map<String, double> breakdown, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breakdown by Category',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: _buildPieChartSections(breakdown),
                    sectionsSpace: 2,
                    centerSpaceRadius: Responsive.isMobile(context) ? 60 : 80,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildLegend(breakdown),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      Map<String, double> breakdown) {
    final colors = {
      'Transportation': const Color(0xFF10B981),
      'Energy': const Color(0xFF3B82F6),
      'Diet': const Color(0xFFF59E0B),
      'Waste': const Color(0xFFEF4444),
    };

    return breakdown.entries.map((entry) {
      final total = breakdown.values.reduce((a, b) => a + b);
      final percentage = (entry.value / total * 100);

      return PieChartSectionData(
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        color: colors[entry.key] ?? AppColors.primaryColor,
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildLegend(Map<String, double> breakdown) {
    final colors = {
      'Transportation': const Color(0xFF10B981),
      'Energy': const Color(0xFF3B82F6),
      'Diet': const Color(0xFFF59E0B),
      'Waste': const Color(0xFFEF4444),
    };

    final icons = {
      'Transportation': Icons.directions_car,
      'Energy': Icons.bolt,
      'Diet': Icons.restaurant,
      'Waste': Icons.delete_outline,
    };

    return Column(
      children: breakdown.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: colors[entry.key],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                icons[entry.key],
                size: 20,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.key,
                  style: AppStyles.bodyText,
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(2)} tons',
                style: AppStyles.bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildComparisonSection(double total, BuildContext context) {
    const usAverage = 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comparison',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: total > usAverage ? total + 2 : usAverage + 2,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'You',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                );
                              case 1:
                                return const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'US Average',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                );
                              default:
                                return const Text('');
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: total,
                            color: total < usAverage
                                ? AppColors.primaryColor
                                : const Color(0xFFF59E0B),
                            width: 60,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: usAverage,
                            color: AppColors.textSecondary.withOpacity(0.5),
                            width: 60,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                total < usAverage
                    ? 'You\'re ${((usAverage - total) / usAverage * 100).toStringAsFixed(1)}% below the US average!'
                    : 'You\'re ${((total - usAverage) / usAverage * 100).toStringAsFixed(1)}% above the US average',
                style: AppStyles.bodyText.copyWith(
                  color: total < usAverage
                      ? AppColors.primaryColor
                      : const Color(0xFFF59E0B),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection(
      List<String> recommendations, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Recommendations',
          style: AppStyles.headline2,
        ),
        const SizedBox(height: 16),
        Text(
          'Based on your results, here are the most impactful actions you can take:',
          style: AppStyles.bodyText.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        ...recommendations.take(3).map((rec) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.lightbulb,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    rec,
                    style: AppStyles.bodyText,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, double total) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.1),
                AppColors.accentColor.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(
                Icons.eco,
                size: 48,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Ready to Take Action?',
                style: AppStyles.headline3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Explore our action guides to reduce your carbon footprint',
                style: AppStyles.bodyText.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/action-plan');
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('View Action Guides'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.go('/calculator');
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Recalculate'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: BorderSide(color: AppColors.primaryColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShareButton(
          text: 'I calculated my carbon footprint: ${total.toStringAsFixed(2)} tons CO₂/year. Calculate yours on Green Sense!',
        ),
      ],
    );
  }
}
