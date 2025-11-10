import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/utils/responsive.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.eco, color: AppColors.primaryColor, size: 32),
            SizedBox(width: 8),
            Text(
              'Green Sense',
              style: TextStyle(
                color: AppColors.headingGreen,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: Responsive.isMobile(context)
        ? null
        : [
            _NavLink(text: 'Home', route: '/', currentPath: currentPath),
            _NavLink(text: 'Insight Lab', route: '/insight-lab', currentPath: currentPath),
            _NavLink(text: 'Action Plan', route: '/action-plan', currentPath: currentPath),
            _NavLink(text: 'Impact Stories', route: '/impact-stories', currentPath: currentPath),
            _NavLink(text: 'Calculator', route: '/calculator', currentPath: currentPath),
            _NavLink(text: 'Challenges', route: '/challenges', currentPath: currentPath),
            _NavLink(text: 'Pledge', route: '/pledge', currentPath: currentPath),
            const SizedBox(width: 16),
          ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String text;
  final String route;
  final String currentPath;

  const _NavLink({
    required this.text,
    required this.route,
    required this.currentPath,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.currentPath == widget.route ||
                     widget.currentPath.startsWith('${widget.route}/');

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: () => context.go(widget.route),
        style: TextButton.styleFrom(
          foregroundColor: isActive || _isHovered
            ? AppColors.primaryColor
            : AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isActive ? 40 : 0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
