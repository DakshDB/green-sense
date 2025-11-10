import 'package:flutter/material.dart';
import 'package:green_sense/models/action_guide.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class ActionCard extends StatefulWidget {
  final ActionGuide action;

  const ActionCard({Key? key, required this.action}) : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _isHovered = false;

  Color _getDifficultyColor() {
    switch (widget.action.difficulty) {
      case ActionDifficulty.easy:
        return Colors.green;
      case ActionDifficulty.medium:
        return Colors.orange;
      case ActionDifficulty.hard:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go('/action-plan/${widget.action.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
          child: Card(
            elevation: _isHovered ? 8 : 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                  child: Icon(
                    widget.action.icon,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Difficulty badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _getDifficultyColor(),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.action.difficulty.toString().split('.').last.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getDifficultyColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        widget.action.title,
                        style: AppStyles.headline3,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        widget.action.description,
                        style: AppStyles.bodyText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      // Impact stats
                      Row(
                        children: [
                          Expanded(
                            child: _ImpactStat(
                              label: 'CO2 Saved',
                              value: '${widget.action.impactStats['co2Saved']}',
                              icon: Icons.cloud_outlined,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ImpactStat(
                              label: 'Time',
                              value: widget.action.timeCommitment,
                              icon: Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImpactStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ImpactStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: AppColors.primaryColor),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
